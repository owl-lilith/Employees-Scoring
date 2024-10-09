import 'package:shared_preferences/shared_preferences.dart';

import '../../business/theme_bloc/theme_bloc.dart';

var userCredentials;
var TOKEN;

Future<Map<String, dynamic>> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print("username = ${prefs.getString("username")}");
  return {
    'token': prefs.getString('token'),
    'name': prefs.getString('name'),
    'email': prefs.getString('email'),
    'picture': prefs.getString('picture'),
  };
}

Future<void> storeUserInfo(var response) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', response["data"]["token"]);
  prefs.setString('name', response["data"]["user"]["name"]);
  prefs.setString('email', response["data"]["user"]["email"]);
  prefs.setString('picture', response["data"]["user"]["picture"]);

  userCredentials = await getUserInfo();
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.reload();
  return prefs.getString('token');
}

Future<String?> storeToken(var response) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response["token"]);
    TOKEN = await getToken();
  } catch (error) {
    throw Future.error(" Wrong Information, Not Exist");
  }
  return null;
}

Future<void> clearUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var a = prefs.getBool("isDarkTheme") ?? false;
  await prefs.clear();
  prefs.setBool("isDarkTheme", a);
}

Future<void> storeSettings(darkTheme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isDarkTheme", darkTheme);
  print(darkTheme);
}

Future<void> loadUserSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isDarkTheme = prefs.getBool("isDarkTheme") ?? false;
  print(prefs.getBool("isDarkTheme"));
}
