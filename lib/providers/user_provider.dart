import 'package:flutter/material.dart';
import 'package:tdp_flutter_project/models/user.dart';
import 'package:tdp_flutter_project/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}