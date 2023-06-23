import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsecond/providers/order_provider.dart';
import 'package:shoppingsecond/providers/product_provider.dart';

import '../../models/product.dart';

class ListOrderPage extends StatefulWidget {
  static const String routeName = "/list_order";
  const ListOrderPage({Key? key}) : super(key: key);

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  @override
  Widget build(BuildContext context) {
    bool _customTileExpanded = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context).getList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data as List;
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var dataItem = data[index]["order_items"] as List;
                    return ExpansionTile(
                      title: Text("Code : ${data[index]['code']}"),
                      subtitle: Text(DateFormat('kk:mm - dd-MM-yyyy ').format(
                        DateTime.parse(data[index]["created_at"]),
                      )),
                      trailing: Icon(
                        _customTileExpanded
                            ? Icons.arrow_drop_down_circle
                            : Icons.arrow_drop_down,
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dataItem.length,
                          itemBuilder: (context, index) {
                            int id = dataItem[index]["product_id"];
                            return FutureBuilder(
                              future: Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .getProducById(id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                var item = snapshot.data as Product;
                                return ListTile(
                                  leading: Image.network(item.image!),
                                  title: Text(item.name!),
                                );
                              },
                            );
                          },
                        ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(
                          () {
                            _customTileExpanded = expanded;
                          },
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: SvgPicture.asset("assets/images/svg/no-data.svg"),
                );
        },
      ),
    );
  }
}
