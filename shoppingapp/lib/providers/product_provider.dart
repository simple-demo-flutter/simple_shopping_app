import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider extends ChangeNotifier{

  List<Product> productSpecial = [];

  Future<List<Product>> getProductSpecial() async {
    String url = "https://apiforlearning.zendvn.com/api/mobile/products?offset=0&sortBy=id&order=asc&special=true";
    final uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: {});

    try {
      final response = await http.get(finalUri);
      final jsonData = jsonDecode(response.body);
      List<Product> data = List<Product>.from(
          jsonData.map((product) => Product.fromJson(product)))
          .toList();
      productSpecial = data;
      return data;
    }catch(e){
      return Future.error(e);
    }
  }

  Future<Product> getProducById(int id) async{
    String url = 'https://apiforlearning.zendvn.com/api/mobile/products/$id';
    final uri = Uri.parse(url);
    try{
      final response = await http.get(uri);
      final jsonData = jsonDecode(response.body);
      Product product = Product.fromJson(jsonData);
      return product;
    }catch(e){
      return Future.error(e);
    }
  }
}