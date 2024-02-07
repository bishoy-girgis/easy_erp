import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_images.dart';
import '../../../../../../core/helper/utils.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class CustomerWidget extends StatelessWidget {
  const CustomerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = Utils(context: context).screenSize;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      // padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.numbers_rounded,
                ),
                TextBuilder(
                  "1",
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.person,
              ),
              TextBuilder("Name"),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
              ),
              TextBuilder("01065666548"),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
              ),
              TextBuilder("Address"),
            ],
          ),
        ],
      ),
    );
  }
}
