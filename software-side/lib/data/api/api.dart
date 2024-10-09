import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/model/employee.dart';
import '../../data/model/service.dart';
import '../../data/storage/storage.dart';
import '../../business/authentication/authentication_bloc.dart';
// import 'data/model/user.dart';

import "package:internet_connection_checker/internet_connection_checker.dart";
import 'package:http/http.dart' as http;

var iPAndPort = "192.168.43.139:8000";
var baseUrl = "http://$iPAndPort/api";

AuthenticationBloc authenticationBloc = AuthenticationBloc();
String token = "";

void logIn(String email, String password) async {
  try {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      Map data = {
        "email": email,
        "password": password,
      };

      var body = json.encode(data);
      var response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          "Content-Type": "application/json",
          "Charset": "utf8_bin",
          "Accept": "application/json"
        },
        body: body,
      );
      var responseData = await jsonDecode(response.body);
      print("token is: ${responseData["token"]}");
      storeToken(responseData);
    } else {
      throw ErrorDescription("Check your internet connection and try again.");
    }
  } catch (e) {
    print("******error is:${e.toString()}");
    throw ErrorDescription(Future.error(e).toString());
    // authenticationBloc.add(LoginAPIErrorActionEvent(Future.error(e)));
  }
}

Future logOut() async {
  // bool result = await InternetConnectionChecker().hasConnection;
  // if (result) {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(
    Uri.parse("$baseUrl/logout"),
    headers: headers,
  );
  var decodedJson = await json.decode(response.body.trim());
  if (decodedJson["message"] != "unauthorized") {
    print(decodedJson);
  } else {
    Future.delayed(const Duration(seconds: 1), () {
      // unAuthorizedAction();
    });
    throw ErrorDescription("Unauthorized Action, logging you out");
  }
  // } else {
  // throw ErrorDescription("Check your internet connection and try again.");
  // }
}

Map<String, dynamic> fileToJson(File file) {
  return {
    'path': file.path,
    // Include other relevant properties if needed
  };
}

void addEmployee(
  String firstName,
  String lastName,
  String email,
  String phoneNumber,
  String address,
  DateTime birthday,
  String position,
  String department,
  String salary,
  DateTime contractDate,
  File primaryImage,
  List<File> secondaryImagesList,
) async {
  // try {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result) {
    Map data = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "address": address,
      "birth_date": "2012-09-08",
      "position": position,
      "department": department,
      "salary": salary,
      "password": "1234567890",
      // "contractDate": contractDate,
      "photos": secondaryImagesList,
      "shift_starts": "9:00",
      "shift_ends": "10:00",
      "info_description": "hello",
    };

    // var body = json.encode(data);
    var encodedBody = jsonEncode(data, toEncodable: (nonEncodable) {
      if (nonEncodable is File) {
        print("hereeeeeeeeee");
        return fileToJson(nonEncodable);
      }
      throw UnsupportedError(
          'Cannot convert ${nonEncodable.runtimeType} to JSON');
    });
    var response = await http.post(
      Uri.parse("$baseUrl/employees"),
      headers: {
        "Content-Type": "application/json",
        "Charset": "utf8_bin",
        "Accept": "application/json",
        'Authorization': 'Bearer $TOKEN',
      },
      body: encodedBody,
    );
    var responseData = await jsonDecode(response.body);
    print(responseData);
  } else {
    throw ErrorDescription("Check your internet connection and try again.");
  }
  // } catch (e) {
  //   // print("******error is:${e.toString()}");
  //   throw ErrorDescription(Future.error(e).toString());
  //   // authenticationBloc.add(LoginAPIErrorActionEvent(Future.error(e)));
  // }
}

void getEmployeesList() async {
  // bool result = await InternetConnectionChecker().hasConnection;
  // if (result) {
  var response = await http.get(
    Uri.parse("$baseUrl/employees"),
    headers: {
      "Content-Type": "application/json",
      "Charset": "utf8_bin",
      "Accept": "application/json",
      "Authorization": "Bearer $TOKEN"
    },
  );

  var refreshResponse = await http.post(
    Uri.parse("$baseUrl/refresh"),
    headers: {
      "Content-Type": "application/json",
      "Charset": "utf8_bin",
      "Accept": "application/json",
      "Authorization": "Bearer $TOKEN"
    },
  );

  var refreshResponsedata = await json.decode(refreshResponse.body.trim());
  print(refreshResponsedata);

  var recordResponse = await http.get(
    Uri.parse("$baseUrl/records/date/2024-08-25"),
    headers: {
      "Content-Type": "application/json",
      "Charset": "utf8_bin",
      "Accept": "application/json",
      "Authorization": "Bearer $TOKEN"
    },
  );

  var recordResponsedata = await json.decode(recordResponse.body.trim());
  // print(record_responseData);

  var responseData = await json.decode(response.body.trim());
  print(responseData);

  for (var element in responseData["data"]) {
    List<String> photos = [];
    for (var photo in element["photos"]) {
      photos.add(photo);
    }
    employeesList.add(Employee(
        id: element["id"].toString(),
        first_name: element["first_name"],
        last_name: element["last_name"],
        primary_image_url: "assets/images/user_pic.jpg",
        secondary_images_url: photos,
        totalPoints: element["total_score"],
        jobTitle: element["department"],
        phone_number: element["phone_number"].toString(),
        shift_starts: element["shift_starts"],
        shift_ends: element["shift_ends"],
        address: element["address"],
        info_description: element["info_description"]));
  }

  // for (var element in record_responseData["data"]) {
  //   var id = element["id"];
  //   print(id);
  //   print(employeesList.firstWhere((element) => element.id == id.toString()));
  //   Employee employee =
  //       employeesList.firstWhere((element) => element.id == id.toString());
  //   employee.shift_starts = record_responseData["shift_starts"];
  //   employee.shift_ends = record_responseData["shift_ends"];
  //   employee.totalPoints = record_responseData["total_score"];
  // }
  print(employeesList);
  // } else {
  //   throw ErrorDescription("Check your internet connection and try again.");
  // }
}

void getServicesList() async {
  var response = await http.get(
    Uri.parse("$baseUrl/settings"),
    headers: {
      "Content-Type": "application/json",
      "Charset": "utf8_bin",
      "Accept": "application/json",
      "Authorization": "Bearer $TOKEN"
    },
  );

  var responseData = await json.decode(response.body.trim());
  path = responseData["path"];
  servicesList = [
    Service(name: "Employees Check in", points: (responseData["check_in"])),
    Service(
        name: "Time Spent With Customer",
        points: (responseData["time_spent_with_costumer"])),
    Service(name: "Reach Casher", points: (responseData["payment"])),
    Service(
        name: "Enter Changing Room", points: (responseData["changing_room"])),
    Service(
        name: "Disagreement over Customer",
        points: (responseData["disagreement"])),
    Service(
        name: "Lonely Customer While Employees Not Working",
        points: (responseData["customer_alone"])),
  ];
}

void editServicesList(
    {required String path,
    required int check_in_points,
    required int time_spent_with_costumer_points,
    required int changing_room_points,
    required int payment_points,
    required int disagreement_points}) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result) {
    print(check_in_points);
    Map data = {
      "path": path,
      "check_in": check_in_points,
      "time_spent_with_costumer": time_spent_with_costumer_points,
      "changing_room": changing_room_points,
      "disagreement": disagreement_points,
      "payment": payment_points
    };

    var encodedBody = json.encode(data);

    var response = await http.post(
      Uri.parse("$baseUrl/settings"),
      headers: {
        "Content-Type": "application/json",
        "Charset": "utf8_bin",
        "Accept": "application/json",
        "Authorization": "Bearer $TOKEN"
      },
      body: encodedBody,
    );

    var responseData = await json.decode(response.body.trim());
    print(responseData);
  } else {
    throw ErrorDescription("Check your internet connection and try again.");
  }
}

Future<Employee> getEmployee(String id) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result) {
    var response = await http.get(
      Uri.parse("$baseUrl/employees/$id"),
      headers: {
        "Content-Type": "application/json",
        "Charset": "utf8_bin",
        "Accept": "application/json",
        "Authorization": "Bearer $TOKEN"
      },
    );

    var responseData = await json.decode(response.body.trim());
    Employee employee;

    List<String> photos = [];
    for (var photo in responseData["data"]["photos"]) {
      photos.add(photo);
    }
    employee = Employee(
      id: responseData["data"]["id"].toString(),
      first_name: responseData["data"]["first_name"],
      last_name: responseData["data"]["last_name"],
      primary_image_url: responseData["data"]["photos"][0],
      secondary_images_url: photos,
      totalPoints: responseData["data"]["total_score"],
      jobTitle: responseData["data"]["department"],
      phone_number: responseData["data"]["phone_number"].toString(),
      shift_starts: responseData["data"]["shift_starts"],
      shift_ends: responseData["data"]["shift_ends"],
      address: responseData["data"]["address"],
      info_description: responseData["data"]["info_description"],
      contract_begin: DateTime(2020, 9, 14),
      arrived_date: "8:30 am",
      clothes_changing_attempt: 9,
      customer_count: 13,
      not_working_event: [],
      payment_attempt: 8,
      pointsThisDay: 80,
      pointsThisMonth: 340,
      disagreement_over_customer: [
        Employee(
          first_name: "Maria",
          last_name: "RoseMary",
          primary_image_url: "assets/images/user_pic.jpg",
          secondary_images_url: ["assets/images/user_pic.jpg"],
          address: "Syria, Damascus, Al-Tabaleh",
          contract_begin: DateTime(2020, 9, 14),
          info_description:
              "Head Leader, i can count on but he miss the last week so he is under watching now",
          jobTitle: "Head Leader",
          phone_number: "0967563434",
          totalPoints: 370,
          shift_ends: "8 pm",
          shift_starts: "9 am",
        ),
        Employee(
          first_name: "Nora",
          last_name: "NoWorry",
          primary_image_url: "assets/images/user_pic.jpg",
          secondary_images_url: ["assets/images/user_pic.jpg"],
          address: "Syria, Damascus, Al-Tabaleh",
          contract_begin: DateTime(2020, 9, 14),
          info_description:
              "Head Leader, i can count on but he miss the last week so he is under watching now",
          jobTitle: "Head Leader",
          phone_number: "0967563434",
          totalPoints: 510,
          shift_ends: "8 pm",
          shift_starts: "9 am",
        ),
      ],
    );

    return employee;
  } else {
    throw ErrorDescription("Check your internet connection and try again.");
  }
}
