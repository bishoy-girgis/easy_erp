import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/presentation/Home/view_models/customer_cubit/customer_cubit.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/widgets/customer_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            BlocConsumer<GetCustomerCubit, GetCustomerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetCustomerSuccessState) {
                  return Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.whiteColor,
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemCount: state.customers.length,
                        itemBuilder: (context, index) {
                          return CustomerWidget(
                            customerModel: state.customers[index],
                          );
                        }),
                  ));
                } else if (state is GetCustomerFailureState) {
                  debugPrint(state.error);
                  return Center(
                    child: TextBuilder(
                        "Sorry there is error , we will work on it "),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
