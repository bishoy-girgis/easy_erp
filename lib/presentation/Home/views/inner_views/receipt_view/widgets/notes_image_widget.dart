// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesImageWidget extends StatefulWidget {
  const NotesImageWidget({super.key});

  @override
  State<NotesImageWidget> createState() => _NotesImageWidgetState();
}

class _NotesImageWidgetState extends State<NotesImageWidget> {
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
            TextBuilder(
              AppLocalizations.of(context)!.notes,
              isHeader: true,
              fontSize: 13,
            ),
            CustomTextFormField(
              controller: notes,
              labelText: AppLocalizations.of(context)!.notes,
              maxLines: 3,
              onChange: (value) {
                notes.text = value;
                SharedPref.set(key: "notesVoucher", value: value);
                debugPrint('sharedddd NOTEESSS ' +
                    SharedPref.get(key: 'notesVoucher'));
                setState(() {});
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBuilder(
                  AppLocalizations.of(context)!.image,
                  isHeader: true,
                  fontSize: 13,
                ),
                const Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 45,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
