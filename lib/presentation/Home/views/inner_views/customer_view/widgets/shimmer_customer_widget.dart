import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class ShimmerCustomerWidget extends StatelessWidget {
  const ShimmerCustomerWidget({
    super.key,
  });

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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColorBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: 20,
                    height: 20,
                  ),
                  const GapW(w: 2),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: 100,
                    height: 20,
                  ),
                ],
              ),
            ),
            const GapH(h: 1),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  width: 20,
                  height: 20,
                ),
                const GapW(w: 2),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: double.infinity,
                    height: 20,
                  ),
                ),
              ],
            ),
            const GapH(h: 0.5),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  width: 20,
                  height: 20,
                ),
                const GapW(w: 2),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: double.infinity,
                    height: 20,
                  ),
                ),
              ],
            ),
            const GapH(h: 0.5),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  width: 20,
                  height: 20,
                ),
                const GapW(w: 2),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    width: double.infinity,
                    height: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
