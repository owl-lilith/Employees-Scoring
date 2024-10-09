class Employee {
  final String id;
  late final String first_name;
  final String last_name;
  final String primary_image_url;
  final List<String> secondary_images_url;
  int totalPoints; // per day
  final int? pointsThisDay;
  final int? pointsThisMonth;
  final String? address;
  final String phone_number;
  final DateTime? contract_begin;
  String? shift_starts;
  String? shift_ends;
  final String? info_description;
  final String? jobTitle;
  final String? arrived_date;
  final int? customer_count;
  final int? payment_attempt;
  final int? clothes_changing_attempt;
  final List<Employee>? disagreement_over_customer;
  final List<String>? not_working_event;

  Employee(
      {this.id = "",
      required this.first_name,
      required this.last_name,
      required this.primary_image_url,
      required this.secondary_images_url,
      this.totalPoints = 0,
      this.pointsThisDay,
      this.pointsThisMonth,
      this.address,
      this.contract_begin,
      this.info_description,
      required this.phone_number,
      this.shift_ends,
      this.shift_starts,
      this.jobTitle,
      this.arrived_date,
      this.clothes_changing_attempt,
      this.customer_count,
      this.disagreement_over_customer,
      this.not_working_event,
      this.payment_attempt});
}

List<Employee> employeesList = [
  Employee(
      first_name: "Noah",
      last_name: "RideFast",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [],
      phone_number: "0987678976",
      address: "Damascus Syria",
      arrived_date: "8:00 am",
      clothes_changing_attempt: 9,
      customer_count: 23,
      contract_begin: DateTime(1990),
      disagreement_over_customer: [
        Employee(
            first_name: "Liam CodeMaster",
            last_name: "FixItAll",
            primary_image_url: "assets/images/user_pic.jpg",
            secondary_images_url: ["assets/images/user_pic.jpg"],
            phone_number: "0987654321",
            address: "Homs Syria",
            arrived_date: "7:50 am",
            clothes_changing_attempt: 7,
            customer_count: 30,
            contract_begin: DateTime(2010),
            disagreement_over_customer: [],
            id: "5678",
            info_description:
                "quick to resolve issues but needs to improve communication",
            jobTitle: "Senior Developer",
            not_working_event: ["2:30", "4:36"],
            payment_attempt: 5,
            pointsThisDay: 60,
            pointsThisMonth: 145,
            shift_ends: "6:00 pm",
            shift_starts: "8:00 am",
            totalPoints: 470),
        Employee(
            first_name: "Sophia",
            last_name: "CreativeMind",
            primary_image_url: "assets/images/user_pic.jpg",
            secondary_images_url: [
              "assets/images/user_pic.jpg",
              "assets/images/user_pic.jpg"
            ],
            phone_number: "1122334455",
            address: "Latakia Syria",
            arrived_date: "9:00 am",
            clothes_changing_attempt: 4,
            customer_count: 20,
            contract_begin: DateTime(2015),
            disagreement_over_customer: [],
            id: "9012",
            info_description: "innovative designer with a great eye for detail",
            jobTitle: "Lead Designer",
            not_working_event: [],
            payment_attempt: 3,
            pointsThisDay: 48,
            pointsThisMonth: 140,
            shift_ends: "5:30 pm",
            shift_starts: "8:30 am",
            totalPoints: 460),
      ],
      id: "8907",
      info_description: "he missed the last few days so he is under watch now",
      jobTitle: "Head Leader",
      not_working_event: ["3:40 pm", "2:45 pm", "9:00 am"],
      payment_attempt: 4,
      pointsThisDay: 46,
      pointsThisMonth: 130,
      shift_ends: "5:00 pm",
      shift_starts: "7:30 am",
      totalPoints: 450),
  Employee(
      first_name: "Emma",
      last_name: "QuickNotes",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: ["assets/images/user_pic.jpg"],
      phone_number: "1234567890",
      address: "Aleppo Syria",
      arrived_date: "8:15 am",
      clothes_changing_attempt: 5,
      customer_count: 18,
      contract_begin: DateTime(2000),
      disagreement_over_customer: [],
      id: "2345",
      info_description: "always punctual and highly productive",
      jobTitle: "Content Manager",
      not_working_event: [],
      payment_attempt: 2,
      pointsThisDay: 52,
      pointsThisMonth: 160,
      shift_ends: "4:30 pm",
      shift_starts: "7:45 am",
      totalPoints: 500),
  Employee(
      first_name: "Liam CodeMaster",
      last_name: "FixItAll",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: ["assets/images/user_pic.jpg"],
      phone_number: "0987654321",
      address: "Homs Syria",
      arrived_date: "7:50 am",
      clothes_changing_attempt: 7,
      customer_count: 30,
      contract_begin: DateTime(2010),
      disagreement_over_customer: [
        Employee(
            first_name: "Sophia",
            last_name: "CreativeMind",
            primary_image_url: "assets/images/user_pic.jpg",
            secondary_images_url: [
              "assets/images/user_pic.jpg",
              "assets/images/user_pic.jpg"
            ],
            phone_number: "1122334455",
            address: "Latakia Syria",
            arrived_date: "9:00 am",
            clothes_changing_attempt: 4,
            customer_count: 20,
            contract_begin: DateTime(2015),
            disagreement_over_customer: [],
            id: "9012",
            info_description: "innovative designer with a great eye for detail",
            jobTitle: "Lead Designer",
            not_working_event: [],
            payment_attempt: 3,
            pointsThisDay: 48,
            pointsThisMonth: 140,
            shift_ends: "5:30 pm",
            shift_starts: "8:30 am",
            totalPoints: 460),
        Employee(
            first_name: "James",
            last_name: "HandsOn",
            primary_image_url: "assets/images/user_pic.jpg",
            secondary_images_url: ["assets/images/user_pic.jpg"],
            phone_number: "5566778899",
            address: "Tartus Syria",
            arrived_date: "8:45 am",
            clothes_changing_attempt: 8,
            customer_count: 25,
            contract_begin: DateTime(2012),
            disagreement_over_customer: [],
            id: "3456",
            info_description:
                "reliable worker with strong problem-solving skills",
            jobTitle: "Operations Manager",
            not_working_event: [],
            payment_attempt: 6,
            pointsThisDay: 54,
            pointsThisMonth: 150,
            shift_ends: "5:00 pm",
            shift_starts: "8:15 am",
            totalPoints: 480)
      ],
      id: "5678",
      info_description:
          "quick to resolve issues but needs to improve communication",
      jobTitle: "Senior Developer",
      not_working_event: [],
      payment_attempt: 5,
      pointsThisDay: 60,
      pointsThisMonth: 145,
      shift_ends: "6:00 pm",
      shift_starts: "8:00 am",
      totalPoints: 470),
  Employee(
      first_name: "Sophia",
      last_name: "CreativeMind",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [
        "assets/images/user_pic.jpg",
        "assets/images/user_pic.jpg"
      ],
      phone_number: "1122334455",
      address: "Latakia Syria",
      arrived_date: "9:00 am",
      clothes_changing_attempt: 4,
      customer_count: 20,
      contract_begin: DateTime(2015),
      disagreement_over_customer: [],
      id: "9012",
      info_description: "innovative designer with a great eye for detail",
      jobTitle: "Lead Designer",
      not_working_event: [],
      payment_attempt: 3,
      pointsThisDay: 48,
      pointsThisMonth: 140,
      shift_ends: "5:30 pm",
      shift_starts: "8:30 am",
      totalPoints: 460),
  Employee(
      first_name: "James",
      last_name: "HandsOn",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: ["assets/images/user_pic.jpg"],
      phone_number: "5566778899",
      address: "Tartus Syria",
      arrived_date: "8:45 am",
      clothes_changing_attempt: 8,
      customer_count: 25,
      contract_begin: DateTime(2012),
      disagreement_over_customer: [],
      id: "3456",
      info_description: "reliable worker with strong problem-solving skills",
      jobTitle: "Operations Manager",
      not_working_event: [],
      payment_attempt: 6,
      pointsThisDay: 54,
      pointsThisMonth: 150,
      shift_ends: "5:00 pm",
      shift_starts: "8:15 am",
      totalPoints: 480),
  Employee(
      first_name: "Lona",
      last_name: "SmartMind",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [
        "assets/images/user_pic.jpg",
        "assets/images/user_pic.jpg"
      ],
      phone_number: "1122334455",
      address: "Latakia Syria",
      arrived_date: "9:00 am",
      clothes_changing_attempt: 4,
      customer_count: 20,
      contract_begin: DateTime(2015),
      disagreement_over_customer: [],
      id: "9012",
      info_description: "innovative designer with a great eye for detail",
      jobTitle: "Lead Designer",
      not_working_event: [],
      payment_attempt: 3,
      pointsThisDay: 48,
      pointsThisMonth: 140,
      shift_ends: "5:30 pm",
      shift_starts: "8:30 am",
      totalPoints: 390),
  Employee(
      first_name: "Khalid",
      last_name: "CallMallFall",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [
        "assets/images/user_pic.jpg",
        "assets/images/user_pic.jpg"
      ],
      phone_number: "1122334455",
      address: "Latakia Syria",
      arrived_date: "9:00 am",
      clothes_changing_attempt: 4,
      customer_count: 20,
      contract_begin: DateTime(2015),
      disagreement_over_customer: [],
      id: "9012",
      info_description: "innovative designer with a great eye for detail",
      jobTitle: "Lead Designer",
      not_working_event: [],
      payment_attempt: 3,
      pointsThisDay: 48,
      pointsThisMonth: 140,
      shift_ends: "5:30 pm",
      shift_starts: "8:30 am",
      totalPoints: 500),
  Employee(
      first_name: "Samah",
      last_name: "WantMoreMoney",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [
        "assets/images/user_pic.jpg",
        "assets/images/user_pic.jpg"
      ],
      phone_number: "1122334455",
      address: "Latakia Syria",
      arrived_date: "9:00 am",
      clothes_changing_attempt: 4,
      customer_count: 20,
      contract_begin: DateTime(2015),
      disagreement_over_customer: [],
      id: "9012",
      info_description: "innovative designer with a great eye for detail",
      jobTitle: "Lead Designer",
      not_working_event: [],
      payment_attempt: 3,
      pointsThisDay: 48,
      pointsThisMonth: 140,
      shift_ends: "5:30 pm",
      shift_starts: "8:30 am",
      totalPoints: 230),
  Employee(
      first_name: "Pull",
      last_name: "JustMakeItHappen",
      primary_image_url: "assets/images/user_pic.jpg",
      secondary_images_url: [
        "assets/images/user_pic.jpg",
        "assets/images/user_pic.jpg"
      ],
      phone_number: "1122334455",
      address: "Latakia Syria",
      arrived_date: "9:00 am",
      clothes_changing_attempt: 4,
      customer_count: 20,
      contract_begin: DateTime(2015),
      disagreement_over_customer: [],
      id: "9012",
      info_description: "innovative designer with a great eye for detail",
      jobTitle: "Lead Designer",
      not_working_event: [],
      payment_attempt: 3,
      pointsThisDay: 48,
      pointsThisMonth: 140,
      shift_ends: "5:30 pm",
      shift_starts: "8:30 am",
      totalPoints: 130),
];
