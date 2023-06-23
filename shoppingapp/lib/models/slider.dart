import 'dart:convert';

class Slider {
  int? id;
  String? name;
  String? image;

  Slider({required this.id, required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Slider.fromMap(Map<String, dynamic> map) {
    return Slider(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Slider.fromJson(String source) =>
      Slider.fromMap(json.decode(source) as Map<String, dynamic>);
}
