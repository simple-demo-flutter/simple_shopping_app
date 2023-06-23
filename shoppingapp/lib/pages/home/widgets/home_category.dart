import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsecond/category/widgets/category.dart';
import 'package:shoppingsecond/providers/category_provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({
    super.key,
  });

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future categoryFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    categoryFuture = Provider.of<CategoryProvider>(context).getCategory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoryFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var categoryData = [];
          if (snapshot.hasData) {
            categoryData = snapshot.data! as List;
          } else {
            const Text("No data");
          }
          return SizedBox(
            height: 120.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 15.0,
                );
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CategoryPage.routeName,
                      arguments: {
                        'id': categoryData[index].id,
                        'name': categoryData[index].name,
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          boxShadow: const [],
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(categoryData[index].image),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        categoryData[index].name,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
