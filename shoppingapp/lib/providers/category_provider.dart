import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/category.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class CategoryProvider extends ChangeNotifier {

  Future<List<Category>> getCategory() async {
    String url = "https://apiforlearning.zendvn.com/api/mobile/categories";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Category> data = List<Category>.from(
          jsonData.map((category) => Category.fromJson(jsonEncode(category))))
          .toList();
      return data;
    }catch(e){
      return Future.error(e);
    }
  }

  Future<List<Product>> getProductByCategory(int id) async {
    String url = "https://apiforlearning.zendvn.com/api/mobile/categories/$id/products";
    final uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: {});

    try {
      final response = await http.get(finalUri);
      final jsonData = jsonDecode(response.body);
      List<Product> data = List<Product>.from(
          jsonData.map((product) => Product.fromJson(product)))
          .toList();
      return data;
    }catch(e){
      return Future.error(e);
    }
  }
}
