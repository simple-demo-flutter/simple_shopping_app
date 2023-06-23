import 'dart:ffi';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsecond/pages/auth/auth_page.dart';
import 'package:shoppingsecond/pages/home/widgets/home_category.dart';
import 'package:shoppingsecond/pages/home/widgets/home_slider.dart';
import 'package:shoppingsecond/pages/home/widgets/list_product_special.dart';
import 'package:shoppingsecond/pages/order/list_order.dart';
import 'package:shoppingsecond/providers/auth_provider.dart';
import 'package:shoppingsecond/providers/cart_provider.dart';

import '../cart/cart_page.dart';

class MyHomePage extends StatelessWidget {
  static const routeName = '/home';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return value.isAuth
              ? const Home()
              : FutureBuilder(
                  future: value.autoLogin(),
                  initialData: false,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if(snapshot.hasError) {
                        return const Center(child: Text('Something wrong happened'));
                      } else {
                        return snapshot.data! ? const Home() : AuthPage();
                      }
                    }
                  },
                );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                child: Image(
                  image: AssetImage("assets/images/icon.jpg"),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 400.0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text("Home Page"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.library_books),
                        title: const Text("List Order"),
                        onTap: () {
                          //quay tro lai roi ms push
                          Navigator.popAndPushNamed(context, ListOrderPage.routeName);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text("Log out"),
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return badges.Badge(
                  badgeContent: Text("${value.items.length}"),
                  position: badges.BadgePosition.topEnd(top: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CartPage.routeName);
                    },
                    child: const Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          HomeSlider(),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Danh muc san pham",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Tat ca (4)"),
              ],
            ),
          ),
          HomeCategory(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Danh muc san pham",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Tat ca (4)"),
              ],
            ),
          ),
          ListProductSpecial(),
        ],
      ),
    );
  }
}
