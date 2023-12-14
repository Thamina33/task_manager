import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../screens/main_bottom_nav_screen.dart';


class AuthController  extends GetxController
    implements GetxService {

  String? _token ;
  String? get token => _token;

  UserModel? _user ;
  UserModel? get user => _user;

  init(){

    initializeUserCache();

  }

   Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    _token = t;
    _user = model;

  }

   Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    _user = model;
    update();

  }

   Future<void> initializeUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString('token');
    _user = UserModel.fromJson(jsonDecode(sharedPreferences.getString('user') ?? '{}'));
  }

   Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('token')) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

   Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    _token = null;
  }

  String get fullName {
    return '${_user?.firstName ?? ''} ${_user?.lastName ?? ')'}';
  }

  Uint8List get imageBytes {
    return const Base64Decoder().convert(_user?.photo ?? '');
  }




  bool  _loginInProgress = false  ;
  bool get loginInProgress => _loginInProgress;

  Future<void> login(String email , String pass  , BuildContext context ) async {

    _loginInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body: {
      'email' :  email ,
      'password' : pass,
    }, isLogin: true);

    if (response.isSuccess) {
    await  saveUserInformation(response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data']));

        Get.to(const MainBottomNavScreen());

    } else {
      if (response.statusCode == 401) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Failed",
            message: 'Please check email/password',
            icon: Icon(Icons.error, color: Colors.red,),
            duration: Duration(seconds: 3),
          ),
        );


      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Failed",
            message: 'Login failed. Try again',
            icon: Icon(Icons.error, color: Colors.red,),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}