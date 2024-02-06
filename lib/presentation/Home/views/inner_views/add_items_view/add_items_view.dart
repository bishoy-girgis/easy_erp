import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../items_view/widgets/item_widget.dart';

class AddItemsView extends StatelessWidget {
  const AddItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select items'),
      ),
      body: Center(
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
          const GapH(h: 1),
          // AddItemWidget(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: AppColors.whiteColor,
              ),
              child: GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.48.r,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AddItemWidget();
                  }),
            ),
          )
        ],
      )),
    );
  }
}

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: Colors.black45,
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CheckboxMenuButton(
              child: TextBuilder(
                "data",
                isHeader: true,
              ),
              value: false,
              onChanged: (v) {
                v = !v!;
                print(v);
              },
            ),
          ),
          TextBuilder(
            "Test",
            isHeader: true,
            fontSize: 25,
          ),
          TextBuilder(
            "Price",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          Flexible(
            child: CustomTextFormField(
              labelText: "",
              backgroundOfTextFeild: AppColors.primaryColorBlue,
            ),
          ),
          TextBuilder(
            "Qnt",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          Flexible(
            child: CustomTextFormField(
              labelText: "",
              backgroundOfTextFeild: AppColors.primaryColorBlue,
            ),
          ),
          TextBuilder(
            "Discount",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          Flexible(
            child: CustomTextFormField(
              labelText: "",
              backgroundOfTextFeild: AppColors.primaryColorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
