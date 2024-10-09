class CustomerAlone {
  final String time_moment;
  final String employee_list;

  CustomerAlone({required this.time_moment, required this.employee_list});
}

List<CustomerAlone> customerAloneList = [
  CustomerAlone(time_moment: "8:56 am", employee_list: "Mia Lia, Nora NoWorry"),
  CustomerAlone(
      time_moment: "4:31 pm", employee_list: "John CantSleep, Maria FoolMe"),
  CustomerAlone(
      time_moment: "2:08 pm", employee_list: "Jon CallBack, Gorge EatFast")
];
