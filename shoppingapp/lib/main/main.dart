import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsecond/category/widgets/category.dart';
import 'package:shoppingsecond/providers/auth_provider.dart';
import 'package:shoppingsecond/providers/cart_provider.dart';
import 'package:shoppingsecond/providers/category_provider.dart';
import 'package:shoppingsecond/providers/order_provider.dart';
import 'package:shoppingsecond/providers/slider_provider.dart';

import '../pages/auth/auth_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/home/myhomepage.dart';
import '../pages/order/list_order.dart';
import '../pages/product/widgets/product.dart';
import '../providers/product_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SliderProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final isLogin = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        ProductPage.routeName: (context) => const ProductPage(),
        AuthPage.routeName: (context) => AuthPage(),
        CartPage.routeName: (context) => const CartPage(),
        ListOrderPage.routeName : (context) => const ListOrderPage(),
      },
    );
  }
}
