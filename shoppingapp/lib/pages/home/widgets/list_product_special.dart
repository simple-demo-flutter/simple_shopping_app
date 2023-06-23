import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

import '../../../providers/cart_provider.dart';
import '../../../providers/product_provider.dart';

class ListProductSpecial extends StatefulWidget {
  const ListProductSpecial({Key? key}) : super(key: key);

  @override
  State<ListProductSpecial> createState() => _ListProductSpecialState();
}

class _ListProductSpecialState extends State<ListProductSpecial> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FutureBuilder(
        future: Provider.of<ProductProvider>(context).getProductSpecial(),
        initialData: [],
        builder: (context, snapshot) {
          var listData = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            listData = snapshot.data!;
          }
          return snapshot.hasData
              ? ListView.separated(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    String image = listData[index].image;
                    String name = listData[index].name;
                    int id = listData[index].id;
                    int price = listData[index].price;
                    return ListTile(
                      leading: Image(
                        image: NetworkImage(image),
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        name,
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        intl.NumberFormat.simpleCurrency(locale: "vi")
                            .format(listData[index].price),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addCart(id, name, image, price);
                        },
                        child: const Icon(Icons.shopping_cart_checkout),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 10.0,
                    );
                  },
                )
              : const Center(
                  child: Text("No data"),
                );
        },
      ),
    );
  }
}
