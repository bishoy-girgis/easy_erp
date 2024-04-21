import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helper/app_colors.dart';
import 'gap.dart';
import 'text_builder.dart';

class ShimmerItemWidget extends StatelessWidget {
  const ShimmerItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.8),
      highlightColor: Colors.grey.withOpacity(0.58),
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                width: double.infinity,
                height: 100,
              ),
            ),
            const GapW(w: 2),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: double.infinity,
                    height: 20,
                  ),
                  const GapH(h: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        width: 50,
                        height: 20,
                      ),
                      const GapW(w: 1),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  const GapH(h: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        width: 50,
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        width: 50,
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
