import 'package:flutter/material.dart';

import 'package:easy_erp/data/models/customer_model/customer_model.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class CustomerWidget extends StatelessWidget {
  final CustomerModel customerModel;
  const CustomerWidget({
    Key? key,
    required this.customerModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(10),
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
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryColorBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.near_me_rounded,
                  color: Colors.white,
                ),
                const GapW(w: 2),
                TextBuilder(
                  customerModel.custcode.toString(),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // (customerModel.custname != null &&
          //             customerModel.custname!.isNotEmpty) ||
          //         (customerModel.custename != null &&
          //             customerModel.custename!.isNotEmpty)
          // ?
          Row(
            children: [
              const Icon(
                Icons.person,
              ),
              const GapW(w: 2),
              TextBuilder(customerModel.custename ?? "7777"),
            ],
          ),
          // : Container(),
          customerModel.fax != null || customerModel.fax!.isNotEmpty
              ? Row(
                  children: [
                    const Icon(
                      Icons.app_registration_rounded,
                    ),
                    const GapW(w: 2),
                    TextBuilder(customerModel.fax!),
                  ],
                )
              : Container(),
          customerModel.address != null || customerModel.address!.isNotEmpty
              ? Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                    ),
                    const GapW(w: 2),
                    TextBuilder(customerModel.address!),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
