import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingsecond/providers/cart_provider.dart';

class OrderProvider extends ChangeNotifier {
  Future<bool> buy(Map<int, CartItem> items) async {
    const url = 'https://apiforlearning.zendvn.com/api/mobile/orders/save';
    final prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString('userData') ?? '');
    final token = data["token"];

    var datas = [];

    items.forEach((key, value) {
      datas.add({
        "product_id": key,
        "quantity": value.quantity,
      });
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": 'bearer ${token}',
        },
        body: jsonEncode({"data": datas}),
      );
      if (response.statusCode != 201) {
        //goi api that bai
        return false;
      }
      // goi api thanh cong
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
  Future<List> getList() async{
    const url = 'https://apiforlearning.zendvn.com/api/mobile/orders';
    final prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString('userData') ?? '');
    final token = data["token"];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": 'bearer ${token}',
        },
      );
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }
      return [];
    } catch (e) {
      return Future.error(e);
    }
  }
}
