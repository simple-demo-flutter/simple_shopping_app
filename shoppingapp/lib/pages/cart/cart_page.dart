import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shoppingsecond/providers/order_provider.dart';
import 'package:shoppingsecond/util/alert.dart';

import '../../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleAddCart() {
      //show thong bao
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertLoading;
        },
      );
      Future.delayed(const Duration(seconds: 3), (() {
        Provider.of<OrderProvider>(context, listen: false)
            .buy(Provider.of<CartProvider>(context, listen: false).items)
            .then(
              (value) => {
                if (value)
                  {
                    Navigator.pop(context),
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alertSuccess;
                      },
                    ),
                    Provider.of<CartProvider>(context, listen: false)
                        .removeCart(),
                  }
              },
            );

        Navigator.pop(context);
      }));
    }

    final itemsData = Provider.of<CartProvider>(context).items;
    return Scaffold(
      appBar: AppBar(),
      body: itemsData.isNotEmpty
          ? Stack(
              children: [
                Positioned.fill(
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      var dataItem = value.items.values.toList();
                      return ListView.separated(
                        itemCount: value.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image(
                              image: NetworkImage(
                                dataItem[index].image,
                              ),
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              dataItem[index].name,
                              maxLines: 2,
                            ),
                            subtitle: Text(
                              intl.NumberFormat.simpleCurrency(locale: "vi")
                                  .format(dataItem[index].price),
                            ),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .decrease(
                                              value.items.keys.toList()[index]);
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "${dataItem[index].quantity}",
                                      style: const TextStyle(
                                          fontSize: 20.0, color: Colors.blue),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .increase(
                                              value.items.keys.toList()[index]);
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10.0,
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        handleAddCart();
                      },
                      child: const Text("Mua hang"),
                    ),
                  ),
                )
              ],
            )
          : Container(
              child: Center(
                child: SvgPicture.asset("assets/images/svg/no-data.svg"),
              ),
            ),
    );
  }
}
