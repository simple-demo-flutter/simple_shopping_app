import 'package:flutter/material.dart';
import 'package:shoppingsecond/category/widgets/category_body.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = "/category";
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Map<String , dynamic> arg = ModalRoute.of(context)!.settings.arguments as Map<String , dynamic>;
    var name = arg["name"];
    var id = arg["id"];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: CategoryBody(id : id),
    );
  }
}
