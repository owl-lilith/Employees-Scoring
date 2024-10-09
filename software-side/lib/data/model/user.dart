class User {
  String id;
  String name;
  String email;
  String password;
  String? image_url;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.image_url});
}

User user = User(
  id: "0",
  name: "User Name",
  email: "email@gmail.com",
  image_url: "assets/images/user_pic.jpg",
  password: "",
);
