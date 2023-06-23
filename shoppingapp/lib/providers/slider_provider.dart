import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/slider.dart';

class SliderProvider extends ChangeNotifier {
  Future<List<Slider>> getSlider() async {
    var url = "https://apiforlearning.zendvn.com/api/mobile/sliders";
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Slider> data = List<Slider>.from(
              jsonData.map((slider) => Slider.fromJson(jsonEncode(slider))))
          .toList();
      return data;
    } catch (e) {
      return Future.error(Exception("No data"));
    }
  }
}
