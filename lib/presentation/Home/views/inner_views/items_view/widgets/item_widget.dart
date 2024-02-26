import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_images.dart';
import '../../../../../../core/helper/utils.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    var size = Utils(context: context).screenSize;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueGrey,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Card(
            color: Colors.white,
            child: Image.asset(
              AppImages.logo,
              width: size.width * .25,
              height: size.width * .25,
            ),
          ),
        ),
        const GapW(w: 1),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBuilder(
                item.itmname ?? item.itmename ?? "none",
                color: Colors.white,
                fontSize: 22,
                isHeader: true,
              ),
              TextBuilder(
                item.itmcode ?? "00",
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBuilder(
                    item.salesprice != null ? item.salesprice.toString() : "00",
                    color: Colors.white,
                  ),
                  TextBuilder(
                    item.unitname ?? "none",
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
