import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardListView extends StatelessWidget {
  const ShimmerCardListView({required this.count, super.key});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 126,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (_, __) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
