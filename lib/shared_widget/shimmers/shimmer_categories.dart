import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoriesView extends StatelessWidget {
  const ShimmerCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (_, __) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 25,
                    height: 25,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 8,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                      ),
                      Container(
                        width: 40,
                        height: 8,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
