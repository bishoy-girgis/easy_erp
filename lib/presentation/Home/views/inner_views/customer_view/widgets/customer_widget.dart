import 'package:flutter/material.dart';

import '../../../../../../core/helper/utils.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class CustomerWidget extends StatelessWidget {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String taxNumber;
  const CustomerWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.phone,
    this.address = "",
    this.taxNumber = "",
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
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.numbers_rounded,
                  color: Colors.white,
                ),
                GapW(w: 2),
                TextBuilder(
                  id.toString(),
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
              GapW(w: 2),
              TextBuilder(name),
            ],
          ),
          taxNumber.isNotEmpty
              ? Row(
                  children: [
                    Icon(
                      Icons.app_registration_rounded,
                    ),
                    GapW(w: 2),
                    TextBuilder(taxNumber),
                  ],
                )
              : Container(),
          Row(
            children: [
              Icon(
                Icons.phone,
              ),
              GapW(w: 2),
              TextBuilder(phone),
            ],
          ),
          address.isNotEmpty
              ? Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                    ),
                    GapW(w: 2),
                    TextBuilder("Address"),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
