class Service {
  String name;
  dynamic points;

  Service({required this.name, required this.points});
}

String path = "path";

List<Service> servicesList = [
  Service(name: "Employees Check in", points: 0),
  Service(name: "Time Spent With Customer", points: 1),
  Service(name: "Reach Casher", points: 5),
  Service(name: "Enter Changing Room", points: 20),
  Service(name: "Disagreement over Customer", points: -10),
  Service(name: "Lonely Customer While Employees Not Working", points: -20),
];
