import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/product/widgets/product.dart';
import '../../providers/category_provider.dart';

class CategoryBody extends StatefulWidget {
  CategoryBody({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late Future categoryFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    categoryFuture =
        Provider.of<CategoryProvider>(context).getProductByCategory(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: categoryFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var productData = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        }
        if (snapshot.hasData) {
          productData = snapshot.data! as List;
        } else {
          return const Text("No data");
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 3 / 4,
          ),
          itemCount: productData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductPage.routeName,
                  arguments: {
                    'data': productData[index],
                  },
                );
              },
              child: GridTile(
                footer: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                  child: GridTileBar(
                    backgroundColor: Colors.black12,
                    title: Text(productData[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData[index].summary),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          productData[index].price.toString(),
                          style: const TextStyle(
                              color: Colors.yellow, fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.shopping_cart),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        productData[index].image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
