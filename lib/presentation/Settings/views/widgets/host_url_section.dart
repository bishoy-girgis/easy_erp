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
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            TextBuilder(
              "Host URL",
              isHeader: true,
            ),
            Divider(),
            CustomTextFormField(
              labelText: "Base URL",
              // hintText: "http://148.113.1.230:1201/",
              // backgroundOfTextFeild: Colors.black26,
              controller: TextEditingController(
                  text: TextEditingController().text.isEmpty
                      ? "http://148.113.1.230:1201/"
                      : baseUrlController.text),
            ),
            TextBuilder(
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
