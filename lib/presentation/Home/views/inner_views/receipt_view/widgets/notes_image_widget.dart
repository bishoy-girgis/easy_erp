import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';

class NotesImageWidget extends StatelessWidget {
  NotesImageWidget({super.key});
  TextEditingController notes = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBuilder(
                  "Image",
                  isHeader: true,
                  fontSize: 13,
                ),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 45,
                    )),
              ],
            ),
            const Divider(),
            const TextBuilder(
              "Notes",
              isHeader: true,
              fontSize: 13,
            ),
            CustomTextFormField(
              controller: notes,
              labelText: notes.text.isEmpty ? "Notes" : notes.text,
              maxLines: 3,
              onChange: (value) {
                notes.text = value;
                debugPrint('😘😘' + notes.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
