import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userAvatar;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userAvatar => _userAvatar;

  void login({
    required String userId,
    required String userName,
    required String userEmail,
    String? userAvatar,
  }) {
    _isAuthenticated = true;
    _userId = userId;
    _userName = userName;
    _userEmail = userEmail;
    _userAvatar = userAvatar;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userAvatar = null;
    notifyListeners();
  }

  void updateUserProfile({
    String? userName,
    String? userEmail,
    String? userAvatar,
  }) {
    if (userName != null) _userName = userName;
    if (userEmail != null) _userEmail = userEmail;
    if (userAvatar != null) _userAvatar = userAvatar;
    notifyListeners();
  }
}
