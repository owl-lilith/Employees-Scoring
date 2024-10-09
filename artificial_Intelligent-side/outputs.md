video: 
``` json
"test_video/payment.mp4"
```
output: 
``` python
[{'id': '1000', 'check_in': '08:00:00', 'customers_number': 1, 'purchases_attempt': 1, 'changing_clothes_attempt': 0, 'disagreement_over_customer': [], 'customer_alone': [], 'score': 30}]
```
add some other data for mini_cache:
``` python
mini_cache.append({'frame': i, 'id': '1000', 'name': 'Lisa', 'face': [0, 0, 0, 0], 'center':[200, 400], 'box': [300, 100, 400, 400]})
```
where data setting is:
```json
data = {
    "settings": {
        "path": "security/cameras/folder/path ",
        "check_in": 10,
        "time_spent_with_costumer": 10,
        "payment": 20,
        "changing_room": 5,
        "disagreement": -20,
        "customer_alone": -30},
    }
```

video: 
``` json
"test_video/disagreement.mp4"
```
 
output:
``` python
output = [{'id': '1', 'check_in': '08:00:00', 'customers_number': 1, 'purchases_attempt': 0, 'changing_clothes_attempt': 0, 'disagreement_over_customer': ['10'], 'customer_alone': [], 'score': -10}, {'id': '10', 'check_in': '08:00:00', 'customers_number': 1, 'purchases_attempt': 0, 'changing_clothes_attempt': 0, 'disagreement_over_customer': ['1'], 'customer_alone': [], 'score': -10}]
```

video: 
``` json
"test_video/work_state.mp4"
```
 
output:
``` python
output = [{'id': '1', 'check_in': '08:00:00', 'customers_number': 1, 'purchases_attempt': 0, 'changing_clothes_attempt': 0, 'disagreement_over_customer': [], 'customer_alone': [], 'score': 10}, {'id': '10', 'check_in': '08:00:00', 'customers_number': 0, 'purchases_attempt': 0, 'changing_clothes_attempt': 0, 'disagreement_over_customer': [], 'customer_alone': ['08:00:01'], 'score': 10}]
```