import 'dart:convert';

import 'package:benfica_social/models/user.dart';
import 'package:benfica_social/services/auth_service.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseService with ChangeNotifier {
   final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _authError = '';
  bool _authenticated = false;
  bool _showregScreen= false;
  User? _user;

  bool get authenticated => _authenticated;
  User get user => _user!;
  bool get showregScreen => _showregScreen;
  String get authError => _authError;
  bool get isLoading => _isLoading;

AuthProvider() {
    _initUser();
  }
  Future<void> _initUser() async {
  var user = await getuserFromStorage();
   
    if (user != null) {
      _user = user;
    }
    if (_user != null) {
      _authenticated = true;
      notifyListeners();
    } 
    notifyListeners();
  }

  switchAuthScreens(){
    _showregScreen=!_showregScreen;
    _authError='';
    _isLoading=false;
    notifyListeners();
  }
Future register(username,email, password,) async {
    try {
        _isLoading = true;
       notifyListeners();
      var res = await _authService.register(username,email,password);
      print(res);
     Constants.showTaost(msg: 'Registered Successfully', bgcolor: AppColors.success);
      return switchAuthScreens();
    } catch (e) {
      _isLoading = false;
      print("ERROS");
      print(e);
      notifyListeners();
      _authError = resolveException(e);
    }
  }
  Future login(email, password,) async {
    // Constants.showTaost(msg: "dsajkdas",bgcolor: AppColors.success);
    try {
        _isLoading = true;
       notifyListeners();
      var res = await _authService.login(email,password);
      notifyListeners();
      return setUserToStorage(res);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _authError = resolveException(e);
    }
  }
  
  Future logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    _authenticated=false;
    notifyListeners();
    Get.back();
    Constants.showTaost(msg: 'Success', bgcolor: AppColors.success);
  }

  setUserToStorage(response) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(response['data']));
    _isLoading = false;
    _authenticated = true;
    _user=User.fromJson(response['data']);
    notifyListeners();
    Constants.showTaost(msg: 'Success', bgcolor: AppColors.success);
  }
}