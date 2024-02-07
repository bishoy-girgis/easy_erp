import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/widgets/customer_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../items_view/widgets/item_widget.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: "Search",
              hintText: "Search with Customer name",
              suffixIcon: Icons.search,
              suffixColor: Colors.blueGrey,
              backgroundOfTextFeild: Colors.white,
              suffixPressed: () {},
            ),
            const GapH(h: 1),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.whiteColor,
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CustomerWidget(
                      id: 1,
                      name: "Yusuf",
                      phone: "445",
                      // address: "ddd",
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
