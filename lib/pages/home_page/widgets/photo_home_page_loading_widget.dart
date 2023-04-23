import 'package:flutter/material.dart';
import 'package:photo_just_for_fun/widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

class PhotoHomePageLoadingWidget extends StatelessWidget {
  const PhotoHomePageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      const ShimmerContainer(width: double.maxFinite, height: 250),
      const SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const ShimmerContainer(width: 150, height: 20, borderRadius: 20),
            Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.white,
                child: Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[300]!))))
          ])),
      const SizedBox(height: 10)
    ]));
  }
}
