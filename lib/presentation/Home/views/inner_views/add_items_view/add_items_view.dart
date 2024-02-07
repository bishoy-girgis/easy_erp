import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';

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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: AppColors.whiteColor,
              ),
              child: GridView.builder(
                  padding: const EdgeInsets.all(20),
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
  AddItemWidget({super.key});
  var priceController = TextEditingController(text: "1");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CheckboxMenuButton(
              value: false,
              onChanged: (v) {
                v = !v!;
                print(v);
              },
              child: const TextBuilder(
                "data",
                isHeader: true,
              ),
            ),
          ),
          const TextBuilder(
            "Test",
            isHeader: true,
            fontSize: 25,
          ),
          const TextBuilder(
            "Price",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          Flexible(
            child: CustomTextFormField(
              labelText: priceController.text,
              backgroundOfTextFeild: Colors.blueGrey,
              centerContent: true,
              contentSize: 20,
              controller: priceController,
              isContentBold: true,
              onChange: (value) {
                priceController.text = value;
              },
            ),
          ),
          const TextBuilder(
            "Qnt",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          const Flexible(
            child: CustomTextFormField(
              labelText: "",
              backgroundOfTextFeild: Colors.blueGrey,
              centerContent: true,
            ),
          ),
          const TextBuilder(
            "Discount",
            isHeader: true,
            fontSize: 16,
            // color: Colors.,
          ),
          const Flexible(
            child: CustomTextFormField(
              labelText: "",
              backgroundOfTextFeild: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
