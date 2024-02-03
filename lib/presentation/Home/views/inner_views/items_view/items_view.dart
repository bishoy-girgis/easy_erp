import 'package:easy_erp/core/helper/app_images.dart';
import 'package:easy_erp/core/helper/utils.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/item_widget.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({
    super.key,
    // required this.title,
  });
  // final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.items.toLowerCase(),
          // isHeader: true,
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: "Search",
              hintText: "Search with ID , Code, or Barcode NO",
              suffixIcon: Icons.search,
              suffixColor: Colors.blueGrey,
              prefixIcon: Icons.qr_code_rounded,
              prefixIconColor: Colors.blueGrey,
              backgroundOfTextFeild: Colors.white,
              prefixPressed: () {},
              suffixPressed: () {},
            ),
            GapH(h: 1),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteColor,
              ),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ItemWidget();
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
