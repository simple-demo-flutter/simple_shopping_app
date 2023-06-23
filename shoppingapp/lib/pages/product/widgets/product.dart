import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  static const routeName = '/product';
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final product = data["data"];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //gim appbar
            pinned: true,
            //bat appbar ra nhanh
            snap: false,
            //keo den cuoi appbar luc keo len appbar tu dong bat ra
            floating: false,
            //do cao cua no khi no dat trang thai hoan hao
            expandedHeight: MediaQuery.of(context).size.height * (1.5 / 3),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(product.name),
              background: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image(
                  image: NetworkImage(product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Column(
                children: [
                  Text(
                    product.description,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      const Text("So luong"),
                      const SizedBox(
                        width: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text("Add Product"),
            onPressed: (){

            },
          ),
        ),
      ],
    );
  }
}
