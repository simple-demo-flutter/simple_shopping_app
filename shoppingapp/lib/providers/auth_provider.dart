import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // tao ra cac tham so de luu lai || check lai

  // neu token ton tai thi cta da dang nhap
  String _token = "";
  int _expires = 0;
  late Timer timer;

  //check xem dang nhap chua
  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authentication(
      String email, String password, String type) async {
    const url = "https://apiforlearning.zendvn.com/api/auth/login";
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(
          {"email": email, "password": password},
        ),
      );
      final responseData = jsonDecode(res.body);
      _token = responseData["access_token"];
      _expires = responseData["expires_in"];
      // lay tgian hien tai
      DateTime timeNow = DateTime.now();
      // tgian ma token co the luu thong = tgian hien tai + tgian dc phep
      DateTime timeExpires = timeNow.add(Duration(seconds: _expires));
      startTokenTimer(timeExpires);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();

      final userData = jsonEncode(
          {"token": _token, "expires": timeExpires.toIso8601String()});

      await prefs.setString("userData", userData);
    } catch (e) {
      Future.error(e);
    }
  }

  void login(String email, String password) {
    _authentication(email, password, "login");
  }

  Future<void> logout() async {
    _token = "";
    _expires = 0;
    stopTokenTimer();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }

  Future<bool> autoLogin() async {
   try {
     final prefs = await SharedPreferences.getInstance();

     if (!prefs.containsKey("userData")) {
       return false;
     }
     final data = jsonDecode(prefs.getString("userData") ?? "");
     DateTime expires = DateTime.parse(data[_expires]);
     startTokenTimer(expires);
     return true;
   } catch(e) {
     debugPrint(e.toString());
     return false;
   }
  }

  Future<void> checkTimeExpire() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString("userData") ?? "");
    var expires = DateTime.parse(data["expires"]);
    if(DateTime.now().isAfter(expires)){
      //het thoi han
      logout();
    }
  }

  void startTokenTimer(DateTime timeExpire){
    var timeUntil = timeExpire.difference(DateTime.now());
    timer = Timer(timeUntil , checkTimeExpire);
  }

  void stopTokenTimer(){
    timer.cancel();
  }
}
