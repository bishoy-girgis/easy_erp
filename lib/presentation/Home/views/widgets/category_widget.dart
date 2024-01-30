import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryName,
    this.onTap,
  });
  final String categoryName;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.whiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.home_max,
              ),
              TextBuilder(
                categoryName,
                isHeader: true,
                // fontSize: ,
              ),
            ],
          )),
    );
  }
}
