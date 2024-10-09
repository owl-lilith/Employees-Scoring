# import libraries
import os
import time as t
import numpy as np
from model.yolo_model import YOLO
import cv2
import ffmpeg
from FaceDetect import FaceDetector
from FaceRecognize import FaceRecognizer
from distance_module import Individual, DistanceProcessor, Frame, TimeCalculator, CostumerTimeAlone
from ActivityMonitor import ActivityMonitor

# fastapi library
from fastapi import FastAPI, HTTPException, File, UploadFile, Form
from fastapi.responses import JSONResponse
from typing import Optional, Dict, Any, List
import json
from pathlib import Path
from datetime import datetime
import os

app = FastAPI()

# Path to save the incoming request data
data_file_path = Path("refreshing_database.json")
UPLOAD_DIR = "uploaded_photos"

stream = True


def main(data):

    cache = []
    video = cv2.VideoCapture('test_images/work_state.mp4')
    # FPS = 1
    FPS = video.get(cv2.CAP_PROP_FPS)
    frame_height = 1080
    area_coords = (1272, 645)
    distance_threshold_cm = 100
    count_threshold = 10
    exit_enter_place = (1804, 724)
    new_customer = []
    people = []
    
    # addFace()
    yolo = YOLO(obj_threshold=0.6, nms_threshold=0.6)

    video = cv2.VideoCapture('test_images/work_state.mp4')
    fd = FaceDetector()
    fr = FaceRecognizer()

    if not video.isOpened():
        print('cannot open file!..')
        exit()
    fr.start(confident_threadshold=0.7)


    i = 0
    while True:

        ret, frame = video.read()
        if not ret:
            print('error reading video!...')
            break
        frame_height = frame.shape[0]

        # face recognition
        
        img, face_slices, faces = fd.detectFaces(frame, draw=False) # time: 0.05 seconds in average
        
        
        # person detection
        
        processed_frame = process_image(frame)
        boxes, _, ids = yolo.predict(processed_frame, img.shape) # time: 0.4 seconds in average
       

        names = []
        if len(face_slices) > 0:
            encs = fr.get_encodings(face_slices)
            proc_encs = fr.process_encoding(encs)
            n, _ = fr.find_on_batch(proc_encs)
            names = n

        # current_image, final_names, current_faces, current_boxes, current_centers, mini_cache = fd.label_faces(i=i, image=img, labels= names, coordinates=faces, boxes=boxes)
        mini_cache = fd.label_faces(
            i=i, image=img, labels=names, coordinates=faces, boxes=boxes)
        if len(cache) == 0:
            cache.append([{'frame': 0, 'id': '1', 'name': 'Laila', 'face': [0, 0, 0, 0], 'center': [117, 500], 'box': [24, 280, 210, 720]}, {'frame': 0, 'id': '10', 'name': 'Noore', 'face': [0, 0, 0, 0], 'center': [626, 459], 'box': [533, 241, 719, 677]}])
        else:
            # for current in mini_cache:
            #     exist = False
            #     for customer in new_customer:
            #         if customer['id'] == current['id']:
            #             exist = True
            #             break
            #     if exist == False: 
            #         distance = abs(current["center"][0] - exit_enter_place[0]) + \
            #             abs(current["center"][1] - exit_enter_place[1])
            #         # check to see first time
            #         if distance > 30:
            #             mini_cache.remove({'frame': current['frame'], 'id': current['id'], 'name': current['name'], 'face': current['face'], 'center': current['center'], 'box': current['box']})
            #         else:
            #             new_customer.append({'id': current['id']})
            #             # people.append({'id': current['id'], 'name': current['name']})
                            
            cache.append(mini_cache)
        i = i+1

    start = t.time()
    # configure services, time: seconds in average
    cache, check_in = neighborhood_bounding_box(cache, FPS, new_customer)

    time_results, distance_result, customer_alone = measure_time_distance(cache, frame_height, 100, 0)
    multi_employee_one_customer = disagreement_over_customer(time_results["results"])
    activity_monitor = ActivityMonitor(frame_height, time_results["results"], cache)
    changing_room_results = activity_monitor.check_activity(area_coords=area_coords,count_threshold=count_threshold,distance_threshold_cm=distance_threshold_cm,activity_type="changing_room")
    purchase_results = near_by_payment(cache, (30, 200), 50, time_results['results'])

    # print("cache: ")
    # print(cache)
    # print("check in: ")
    # print(check_in)
    # print('time measuring: ')
    # print(time_results)
    # print('distance measuring: ')
    # print(distance_result)
    # print('customer alone: ')
    # print(customer_alone)
    # print('disagreement over customer: ')
    # print(multi_employee_one_customer)
    # print("Purchase Activity Results:", purchase_results)
    # print("Changing Room Activity Results:", changing_room_results)
    
    video.release()
    cv2.destroyAllWindows()

    draw(cache, i-1)

    employees = []
    for i in check_in:
        employees.append(i['id'])

    employees_activity= []
    for employee_id in employees:
        
        score = 0
        
        check_in_result = ""
        for element in check_in:
            if employee_id == element['id']:
                score += data['settings']['check_in']
                formatted_time = add_time_seconds(int(element['check_in']))
                check_in_result = formatted_time
        
        customers_number = 0
        for element in time_results['results']:
            if employee_id == element['employee_id']:
                customers_number += 1
                time = int((element['end_frame'] - element['start_frame']) / FPS)
                score += data['settings']['time_spent_with_costumer'] * time // 60 // 5
        
        purchases = 0
        for element in purchase_results:
            if employee_id == element['employee_id']:
                
                time = element['time_count'] 
                if time > 0:
                    purchases += 1 
            
            score += purchases * data['settings']['customer_alone']

        changing_clothes_attempt = 0
        for element in changing_room_results:
            if employee_id == element[0]:
                changing_clothes_attempt += element[1]
                score += element[1] * data['settings']['changing_room']

        disagreement_over_customer_list = []
        for element in multi_employee_one_customer:
            exist = False
            for emp in element['employees_id']:
                if employee_id == emp:
                    exist = True
                    break
            if exist == True:
                score += data['settings']['disagreement']
                for emp in element['employees_id']:
                    if employee_id != emp:
                       disagreement_over_customer_list.append(emp)
        
        not_working_moment_list = []
        for element in customer_alone:
            for emp in element['employees_not_working']:
                if employee_id == emp:
                    time = int(element['frame'] / FPS)
                    formatted_time = add_time_seconds(time)
                    not_working_moment_list.append(formatted_time)
        
        employees_activity.append({
            'id': employee_id, 
            'check_in': check_in_result, 
            'customers_number': customers_number, 
            'purchases_attempt': purchases, 
            'changing_clothes_attempt': changing_clothes_attempt, 
            'disagreement_over_customer': disagreement_over_customer_list, 
            'customer_alone': not_working_moment_list,
            'score': score
            })
                
    print(employees_activity)
    end = t.time()
    print(end - start)
    return employees_activity


def draw(cache, i):

    video = cv2.VideoCapture('test_images/work_state.mp4')
    fps = video.get(cv2.CAP_PROP_FPS)
    width = int(video.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(video.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fourcc = cv2.VideoWriter_fourcc(*'MJPG')
    writer = cv2.VideoWriter('output_work_state.mp4',
                             fourcc, fps, (width, height))
    if not video.isOpened():
        print('cannot open file!..')
        exit()
    loop = 0
    while loop < i:

        ret, frame = video.read()
        if not ret:
            print('error reading video!...')
            break

        for current in cache[loop]:
            color = (0, 0, 0)
            if current["name"] == "unrecognized":
                color = (0, 0, 255)
            else:
                color = (0, 255, 0)
            cv2.rectangle(frame, (current["box"][0], current["box"][1]),
                          (current["box"][2], current["box"][3]), color, 2)
            cv2.putText(frame, 'name: {0}, id: {1}'.format(current["name"], current["id"]),
                        (current["box"][0], current["box"][1]),
                        cv2.FONT_HERSHEY_SIMPLEX,
                        0.7, color, 1,
                        cv2.LINE_AA)
            cv2.putText(frame, 'frame: {0}'.format(loop),
                        (10,30),
                        cv2.FONT_HERSHEY_SIMPLEX,
                        0.7, (0,0,0), 1,
                        cv2.LINE_AA)
            cv2.circle(frame, (current["box"][0], current["box"][1]),
                       radius=0, color=color, thickness=10)

            # cv2.imwrite("output\detected_" + str(loop) + ".png", frame)
        if stream is True:
            cv2.imshow('video', frame)

            if cv2.waitKey(1) == ord('q'):
                break
        writer.write(frame)
        loop = loop+1

    video.release()
    cv2.destroyAllWindows()


def process_image(img):

    image = cv2.resize(img, (416, 416), interpolation=cv2.INTER_CUBIC)
    image = np.array(image, dtype='float32')
    image /= 255.
    image = np.expand_dims(image, axis=0)

    return image


def addFace(id, first_name, last_name, saved_files):
    fd = FaceDetector(
        haarcascade_path='Resources/haarcascades/haarcascade_frontalface_default.xml')
    fr = FaceRecognizer(target_database_path='Resources/faces/database.pkl')
    for path in saved_files:
        fr.add_target_non_detect(path, str(first_name) + " " + str(last_name) + "-" + str(id))
    
    # fr.add_target_non_detect('test_images/jo4.jpg', 'Jo')
    # fr.add_target_non_detect('test_images/jo5.jpg', 'Jo')
    # fr.add_target_non_detect('test_images/jo6.jpg', 'Jo')
    # fr.add_target_non_detect('test_images/jo7.png', 'Jo')
    # fr.add_target_non_detect('test_images/jo8.png', 'Jo')
    # fr.add_target_non_detect('test_images/jo9.png', 'Jo')
    # fr.add_target_non_detect('test_images/jo10.png', 'Jo')
    # fr.add_target('test_images/jo1.jpg', 'Jo')
    # fr.add_target('test_images/jo2.jpg', 'Jo')
    # fr.add_target_non_detect('test_images/nora0.png', 'Nora')
    # fr.add_target_non_detect('test_images/nora1.png', 'Nora')
    # fr.add_target_non_detect('test_images/nora2.png', 'Nora')
    # fr.add_target_non_detect('test_images/nora3.png', 'Nora')
    # fr.add_target('test_images/liza0.jpg', 'Liza')
    # fr.add_target('test_images/liza1.webp', 'Liza')
    # fr.add_target('test_images/robin4.webp', 'Robin')
    # fr.add_target('test_images/robin5.webp', 'Robin')
    # fr.add_target_non_detect('test_images/robin0.jpg', 'Robin')
    # fr.add_target_non_detect('test_images/robin1.jpg', 'Robin')
    # fr.add_target_non_detect('test_images/robin2.jpg', 'Robin')
    # fr.add_target_non_detect('test_images/robin3.jpeg', 'Robin')


def neighborhood_bounding_box(cache, fps, new_customer):
    memory = []
    check_in = []
    exit_enter_place = (1804, 724)
    for i in range(1, len(cache)):
        # print(i)
        # print(memory)
        if len(cache[i]) == len(cache[i-1]):
            for current in cache[i]:
                min = 10000
                for previous in cache[i-1]:
                    distance = abs(current["center"][0] - previous["center"][0]) + \
                        abs(current["center"][1] - previous["center"][1])
                    if min > distance:
                        min = distance
                
                        current["id"] = previous["id"]
                        current["name"] = previous["name"]
                        

        elif len(cache[i]) < len(cache[i-1]):
            for current in cache[i]:
                min = 10000
                for previous in cache[i-1]:
                    distance = abs(current["center"][0] - previous["center"][0]) + \
                        abs(current["center"][1] - previous["center"][1])
                    if min > distance:
                        min = distance
                
                        current["id"] = previous["id"]
                        current["name"] = previous["name"]
                        
            for previous in cache[i-1]:
                exist = False
                for current in cache[i]:
                    if previous["id"] == current["id"]:
                        exist = True
                        break
                if exist == False:
                    memory.append(previous)


        elif len(cache[i]) > len(cache[i-1]):
            for previous in cache[i-1]:
                min = 10000
                smallest_distance = ""
                for current in cache[i]:
                    distance = abs(current["center"][0] - previous["center"][0]) + \
                        abs(current["center"][1] - previous["center"][1])
                    if min > distance:
                        min = distance
                        
                        smallest_distance = current
                if smallest_distance != "":
                    cache[i].remove(smallest_distance)
                    smallest_distance["id"] = previous["id"]
                    smallest_distance["name"] = previous["name"]
                    cache[i].append(smallest_distance)
                

            if  len(memory) != 0:
                exist = False
                for current in cache[i]:
                    skip = False
                    for previous in cache[i-1]:
                        if(current == previous):
                            skip = True
                            break
                    if skip == False:
                        for memory_element in memory:
                            if current["center"] == memory_element["center"]:
                                exist = True
                                current["id"] = memory_element["id"]
                                current["name"] = memory_element["name"]
                                memory.remove(memory_element)
                        if exist == False:
                            min = 10000
                            for memory_element in memory:
                                distance = abs(current["center"][0] - memory_element["center"][0]) + \
                                    abs(current["center"][1] - memory_element["center"][1])
                                if min > distance:
                                    min = distance
                                
                                    current["id"] = memory_element["id"]
                                    current["name"] = memory_element["name"]
                                    memory.remove(memory_element)
        
        # print(cache[i])
    
         # for current in mini_cache:
            #     exist = False
            #     for customer in new_customer:
            #         if customer['id'] == current['id']:
            #             exist = True
            #             break
            #     if exist == False: 
            #         distance = abs(current["center"][0] - exit_enter_place[0]) + \
            #             abs(current["center"][1] - exit_enter_place[1])
            #         # check to see first time
            #         if distance > 30:
            #             mini_cache.remove({'frame': current['frame'], 'id': current['id'], 'name': current['name'], 'face': current['face'], 'center': current['center'], 'box': current['box']})
            #         else:
            #             new_customer.append({'id': current['id']})
            #             # people.append({'id': current['id'], 'name': current['name']})
                            
        for current in cache[i - 1]:
            if current["name"] != "unrecognized":
                time = int(current['frame'] / fps)
               
                if len(check_in) == 0: 
                    check_in.append({"id": current["id"], "check_in": str(time)})
                else:
                    exist = False
                    for check_in_current in check_in:
                        if check_in_current["id"] == current["id"]:
                            exist = True
                            break
                    if exist == False:
                        check_in.append({"id": current["id"], "check_in": str(time)})
        

            
    return cache, check_in


def measure_time_distance(cache, frame_height, max_distance, min_time_spent_alone):
    # Initialize hyperparameters
    distance_results = []
    time_results = []
    frames = []
    
    
    customer_alone = []
    for frame in cache:
        customers = []
        employees = []
        individuals = []
        if len(frame) > 0 :
            for component in frame:
                # Create data
                individual_type = ""
                if component["name"] != "unrecognized":
                    exist = False
                    for employee in employees:
                        if component['id'] == employee['id']:
                            exist = True
                    if exist == False:
                        employees.append({'id': component["id"]})
                    individual_type = "employee"
                else:
                    exist = False
                    for customer in customers:
                        if component['id'] == customer['id']:
                            exist = True
                    if exist == False:
                        customers.append({'id': component["id"]})
                    individual_type = "customer"
                individuals.append(Individual(
                    id=component["id"],
                    type=individual_type,
                    coords=component["center"],
                    gender="male",
                    full_body_height_px=abs(
                        component["box"][3] - component["box"][0]),
                    face_height_px=abs(component["face"][3] - component["face"][0])
                ))

            # Initialize DistanceProcessor
            processor = DistanceProcessor(individuals, max_distance, frame_height, 'euclidean')

            # Run the process method and print results
            distance_result = processor.process()
            distance_results.append(distance_result)
            
            # print(frame[0]['frame'])
            # print(customers)
            # print(employees)
            # print(distance_result)

            for customer in customers:
                alone = True
                employees_not_working = []
                employees_working = []

                for element in distance_result:
                    employee_id = element[0]
                    customer_id = element[1]
                    distance = element[2]   
                    
                    if customer['id'] == customer_id and distance != -1:
                        alone = False
                    if distance != -1:
                        employees_working.append({'id' : employee_id})    
                if alone == True:
                    for employee in employees:
                        exist = False
                        for employee_working in employees_working:
                            if employee['id'] == employee_working['id']:
                                exist = True
                                break
                        if exist == False:
                            employees_not_working.append(employee['id'])
                
                if alone == True:
                    exist = False
                    
                    for element in customer_alone:
                        if customer['id'] == element['customer_id']:
                            customer_alone.append({'frame': element['frame'],'time_spent_alone': frame[0]['frame'] - element['frame'] ,'customer_id': element['customer_id'], 'employees_not_working': element['employees_not_working']})
                            customer_alone.remove({'frame': element['frame'],'time_spent_alone': element['time_spent_alone'],'customer_id': element['customer_id'], 'employees_not_working': element['employees_not_working']})
                            exist = True
                    if exist == False:
                        customer_alone.append({'frame': frame[0]['frame'],'time_spent_alone': 0,'customer_id': customer['id'], 'employees_not_working': employees_not_working})

            
            
            # Collect frames for TimeCalculator
            frames.append(Frame(
                individuals=individuals,
                max_distance_cm=max_distance,
                image_height=frame_height,
                frame_number=frame[0]["frame"]
            ))

    # Initialize and run TimeCalculator
    time_calculator = TimeCalculator(frames=frames, num_frames=len(frames))
    time_results = time_calculator.run(0.05)

    customer_alone_final_list = []
    for element in customer_alone:
        if element['time_spent_alone'] > min_time_spent_alone:
            customer_alone_final_list.append({'frame': element['frame'],'time_spent_alone': element['time_spent_alone'],'customer_id': element['customer_id'], 'employees_not_working': element['employees_not_working']})

    return time_results, distance_results, customer_alone_final_list


def disagreement_over_customer(time_results):
    multi_employee_one_customer = []
    for item1 in time_results:
        employees = []
        employees.append(item1['employee_id'])
        for item2 in time_results:
            if item1['employee_id'] != item2['employee_id'] and item1['customer_id'] == item2['customer_id'] and item2['start_frame'] < item1['end_frame']:
                employees.append(item2['employee_id'])
        
        exist = False
        for item in multi_employee_one_customer:
            if item1['customer_id'] == item['customer_id']:
                exist = True
        
        if exist == False and len(employees) > 1:
            multi_employee_one_customer.append({'customer_id': item1['customer_id'],'employees_id': employees})
    return multi_employee_one_customer


def format_time(total_seconds):
    hours = total_seconds // 3600
    minutes = (total_seconds % 3600) // 60
    seconds = total_seconds % 60
    return f"{hours:02}:{minutes:02}:{seconds:02}"


def add_time_seconds(total_seconds, add_hours=8, add_minutes=0, add_seconds=0):
    # Convert the additional time to seconds
    add_total_seconds = (add_hours * 3600) + (add_minutes * 60) + add_seconds
    # Sum the total seconds
    total_seconds += add_total_seconds
    # Format the result
    return format_time(total_seconds)


def near_by_payment(cache, casher_placement, distance_threshold, pairs):
    purchase_activities = []
    for i in range(0, len(cache)):
        for current in cache[i]:
            if current["name"] == "unrecognized":
                distance = abs(current["center"][0] - casher_placement[0]) + \
                        abs(current["center"][1] - casher_placement[1])
                if distance <= distance_threshold:
                    for pair in pairs:
                        if pair['customer_id'] == current["id"] and i >= pair['start_frame'] and i <= pair['end_frame']:
                            if len(purchase_activities) == 0:
                                purchase_activities.append({'employee_id': pair['employee_id'], 'customer_id': pair['customer_id'],'time_count': 1})
                            for element in purchase_activities:
                                if element['customer_id'] == pair['customer_id']:
                                    purchase_activities.append({'employee_id': element['employee_id'], 'customer_id': element['customer_id'], 'time_count': element['time_count'] + 1})
                                    purchase_activities.remove({'employee_id': element['employee_id'], 'customer_id': element['customer_id'], 'time_count': element['time_count']})
                                else:
                                    purchase_activities.append({'employee_id': pair['employee_id'], 'customer_id': pair['customer_id'],'time_count': 1})
    return purchase_activities


# Function to load data from the JSON file
def load_data() -> Optional[Dict[str, Any]]:
    if not data_file_path.exists():
        return None
    with data_file_path.open("r") as f:
        return json.load(f)

# Function to save data to the JSON file
def save_data(data: Dict[str, Any]):
    with data_file_path.open("w") as f:
        json.dump(data, f, indent=4)


# Endpoint to handle file uploads
@app.post("/upload")
async def upload_photos(
    id: int = Form(...),
    first_name: str = Form(...),
    last_name: str = Form(...),
    photos: List[UploadFile] = File(...),):
    os.makedirs(UPLOAD_DIR, exist_ok=True)

    saved_files = []
    p = 0
    for photo in photos:
        
        file_extension = os.path.splitext(photo.filename)[1]
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"{id}_{first_name}{last_name}_{p}{file_extension}"
        file_path = os.path.join(UPLOAD_DIR, filename)
        p = p + 1
        with open(file_path, "wb") as file:
            content = await photo.read()
            file.write(content)

        saved_files.append(file_path)
    
    addFace(id, first_name, last_name, saved_files)

    return JSONResponse(content={"message": "Photos uploaded successfully"})

# Endpoint to handle POST request and save data
@app.post("/refresh")
async def handle_post(data: Dict[str, Any]):
    try:
        save_data(data)
        output = main(data)
        return {"status": "success", "message": "Data saved successfully", "output:": output}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

# to run the server please use the following port number
# uvicorn main:app --reload --port 5000

if __name__ == '__main__':
    data = {
    "settings": {
        "path": "dcdl,cdoc,d",
        "check_in": 10,
        "time_spent_with_costumer": 10,
        "customer_alone": 20,
        "changing_room": 5,
        "disagreement": -20,
        "customer_alone": -30},
    
    "employees": [
            {
            "id": 1,
            "name": "Gerardo Hill"
            },]
    }
    main(data)


# if len(cash) == 0:
    #     ids = []
    #     for cb in range(len(current_boxes)):
    #         ids.append(cb)

    #     cash.append({
    #         'frame': i,
    #         'ids': ids,
    #         'names': final_names,
    #         'faces': current_faces,
    #         'boxes': current_boxes,
    #         'centers': current_centers
    #     })
    # else:
    #     previous_ids = cash[i-1]["ids"]
    #     previous_boxes = cash[i-1]["boxes"]
    #     previous_centers = cash[i-1]["centers"]
    #     current_ids = []

    #     for current_center in current_centers:
    #         current_id = ""
    #         min = 100000
    #         for previous_id, previous_center in zip(previous_ids, previous_centers):
    #             distance = abs(
    #                 current_center[0] - previous_center[0]) + abs(current_center[1] - previous_center[1])
    #             if min > distance:
    #                 min = distance
    #                 current_id = previous_id

    #         current_ids.append(current_id)
    #     cash.append({
    #         'frame': i,
    #         'ids': current_ids,
    #         'names': final_names,
    #         'faces': current_faces,
    #         'boxes': current_boxes,
    #         'centers': current_centers
    #     })

    # if cash[i]["ids"] != [0,1] :
    #     print(cash[i]["boxes"])
    #     cv2.imwrite('output/detected_'+ str(i) +'.png', img)
