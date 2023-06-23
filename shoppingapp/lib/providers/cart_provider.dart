import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String image;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> items = {};

  void addCart(
      int productId, String productName, String productImage, int productPrice,
      [int productQuantity = 1]) {
    if (items.containsKey(productId)) {
      // ton tai san pham
      items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          image: value.image,
          name: value.name,
          price: value.price,
          quantity: value.quantity + productQuantity,
        ),
      );
    } else {
      //chua ton tai
      items.putIfAbsent(
        productId,
        () => CartItem(
            id: productId,
            image: productImage,
            name: productName,
            price: productPrice,
            quantity: productQuantity),
      );
    }
    notifyListeners();
  }

  void increase(int productId, [int quantity = 1]) {
    items.update(
      productId,
      (value) => CartItem(
        id: value.id,
        image: value.image,
        name: value.name,
        price: value.price,
        quantity: value.quantity + quantity,
      ),
    );
    notifyListeners();
  }

  void decrease(int productId, [int quantity = 1]) {
    if (items[productId]?.quantity == quantity) {
      items.removeWhere((key, value) => key == productId);
    } else {
      items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          image: value.image,
          name: value.name,
          price: value.price,
          quantity: value.quantity - quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeCart(){
    items = {};
    notifyListeners();
  }
}
