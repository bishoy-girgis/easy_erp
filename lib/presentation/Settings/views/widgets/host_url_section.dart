import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/text_builder.dart';

class HostUrlSection extends StatelessWidget {
  HostUrlSection({
    super.key,
  });
  final TextEditingController baseUrlController = TextEditingController();
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
              "Host URL",
              isHeader: true,
            ),
            const Divider(),
            CustomTextFormField(
              labelText: AppConstants.baseUrl,
              hintText: AppConstants.baseUrl,
              controller: baseUrlController,
              onChange: (value) {
                baseUrlController.text = value;
                AppConstants.baseUrl = baseUrlController.text;
                debugPrint(AppConstants.baseUrl);
                debugPrint('😘😘' + baseUrlController.text);

                SharedPref.set(key: "baseUrl", value: baseUrlController.text);
                debugPrint('😘😘' + SharedPref.get(key: 'baseUrl'));
              },
              onSubmit: (value) {
                baseUrlController.text = value;
                debugPrint('😘😘😘' + baseUrlController.text);

                // SharedPref.set(key: "baseUrl", value: baseUrlController.text);
                debugPrint('😘' + SharedPref.get(key: 'baseUrl'));
              },
            ),
            const TextBuilder(
              "Host URL that connect app with server data \n  ex: https//www.domain.com/",
              isHeader: true,
              maxLines: 2,
              fontSize: 12,
              // color: Colors.black45,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
