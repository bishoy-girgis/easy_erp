import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';

class ChoosePrintModelSection extends StatefulWidget {
  const ChoosePrintModelSection({
    super.key,
  });

  @override
  State<ChoosePrintModelSection> createState() =>
      _ChoosePrintModelSectionState();
}

class _ChoosePrintModelSectionState extends State<ChoosePrintModelSection> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const TextBuilder(
              "Choose Print Model",
              isHeader: true,
            ),
            const Divider(),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTextButton("A4", 0),
                  const VDividerBuilder(),
                  buildTextButton("A5", 1),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: TextBuilder(
                  //     "RECEIPT",
                  //     isHeader: true,
                  //     fontSize: 14,
                  //   ),
                  // ),
                  const VDividerBuilder(),
                  buildTextButton("A6", 2),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: TextBuilder(
                  //     "MACHINE",
                  //     fontSize: 14,
                  //     isHeader: true,
                  //   ),
                  // ),
                ],
              ),
            ),
            const TextBuilder(
              "Host URL that connect app with server data \n  ex: https//www.domain.com/",
              isHeader: true,
              maxLines: 2,
              fontSize: 12,
              color: Colors.black45,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextButton(String text, int index) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
          });
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              // Change the color based on the selected state
              return selectedButtonIndex == index ? Colors.red : Colors.black;
            },
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class VDividerBuilder extends StatelessWidget {
  const VDividerBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      color: AppColors.blackColor,
      height: 20.h,
    );
  }
}
