import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/text_builder.dart';

class CompanyInfoSection extends StatefulWidget {
  const CompanyInfoSection({
    super.key,
  });

  @override
  State<CompanyInfoSection> createState() => _CompanyInfoSectionState();
}

class _CompanyInfoSectionState extends State<CompanyInfoSection> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    int selectedButtonIndex = -1;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBuilder(
              "Company information",
              isHeader: true,
            ),
            Divider(),
            // GapH(h: 1),
            TextBuilder(
              "Company logo",
              isHeader: true,
              fontSize: 16,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_photo_alternate_rounded,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_sharp,
                      )),
                ],
              ),
            ),
            // TextBuilder(
            //   "Branch name",
            //   isHeader: true,
            //   fontSize: 16,
            // ),
            CustomTextFormField(
              labelText: "Branch name",
              focusedBorderColor: Colors.blueGrey,
            ),
            CustomTextFormField(
              labelText: "Branch adress",
            ),
            CustomTextFormField(
              labelText: "Tax number",
            ),
            CustomTextFormField(
              labelText: "Notes",
              maxLines: 5,
            ),
            CustomElevatedButton(
              width: double.infinity,
              title: "Submit",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
