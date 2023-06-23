import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/slider_provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Future sliderFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    sliderFuture = Provider.of<SliderProvider>(context).getSlider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sliderFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var sliderData = [];
        if (snapshot.hasData) {
          sliderData = snapshot.data as List;
        } else {
          return const Text("No data");
        }
        return snapshot.hasData!
            ? CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.8,
                ),
                items: sliderData.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(i.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          'text $i',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            : Text("No data");
      },
    );
  }
}
