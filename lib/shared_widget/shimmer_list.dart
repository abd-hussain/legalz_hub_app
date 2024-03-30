import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  final int count;
  const ShimmerListView({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (_, __) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 100,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
