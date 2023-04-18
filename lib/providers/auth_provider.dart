import 'package:flutter/material.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => UserModel(
      email: "uky@gmail.com",
      id: 2,
      username: "admin",
      profilePhotoUrl:
          "https://www.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1771435607.jpg");

  set user(UserModel user) {
    // _user = user;
    _user = UserModel(email: "uky@gmail.com", id: 2, username: "admin");
    notifyListeners();
  }

  Future<bool> register({
    String name,
    String username,
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      // UserModel user = await AuthService().login(
      //   email: email,
      //   password: password,
      // );

      UserModel user =
          UserModel(email: "uky@gmail.com", id: 1, username: "admin");

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
