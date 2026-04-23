import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../database/db_helper.dart';

class AuthProvider extends ChangeNotifier {
  final UserModel _user = UserModel();

  UserModel get user => _user;

  // Register new user
  Future<void> register(String firstName, String lastName, String email, String password, String role) async {
    Map<String, dynamic> userData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role,
    };

    try {
      int userId = await DBHelper().insertUser(userData);
      if (userId > 0) {
        _user.id = userId;
        _user.firstName = firstName;
        _user.lastName = lastName;
        _user.email = email;
        _user.role = role;
        _user.isLoggedIn = true;
        _user.errorMessage = '';
      } else {
        _user.errorMessage = 'Registration failed';
      }
    } catch (e) {
      _user.errorMessage = 'Error: $e';
    }
    notifyListeners();
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      Map<String, dynamic>? userData = await DBHelper().getUserByEmail(email);

      if (userData != null && userData['password'] == password) {
        _user.id = userData['id'];
        _user.firstName = userData['firstName'];
        _user.lastName = userData['lastName'];
        _user.email = userData['email'];
        _user.role = userData['role'];
        _user.isLoggedIn = true;
        _user.errorMessage = '';
      } else {
        _user.isLoggedIn = false;
        _user.errorMessage = 'Invalid email or password';
      }
    } catch (e) {
      _user.isLoggedIn = false;
      _user.errorMessage = 'Login error: $e';
    }
    notifyListeners();
  }

  // Logout
  void logout() {
    _user.id = null;
    _user.firstName = '';
    _user.lastName = '';
    _user.email = '';
    _user.password = '';
    _user.role = 'student';
    _user.isLoggedIn = false;
    _user.errorMessage = '';
    notifyListeners();
  }
}