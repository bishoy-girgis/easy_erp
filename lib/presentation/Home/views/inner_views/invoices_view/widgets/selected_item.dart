import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/models/invoice_model/invoice_model.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    required this.itemModel,
    this.quantity = 1,
  });
  final ItemModel itemModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.of<AddItemCubit>(context).addedItems.contains(itemModel)
        ? GestureDetector(
            onTap: () {
              GlobalMethods.goRouterNavigateTO(
                context: context,
                router: AppRouters.kCreateInvoice,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            quantity.toString(),
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                          ),
                          GapH(h: 5.4),
                          TextBuilder(
                            itemModel.unitname!,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 5.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            itemModel.itmname!,
                            isHeader: true,
                            color: AppColors.blackColor,
                          ),
                          GapH(h: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextBuilder(
                                "Price",
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              TextBuilder(
                                "Total",
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.blueGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextBuilder(
                                itemModel.salesprice.toString(),
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              TextBuilder(
                                "${quantity * itemModel.salesprice!}",
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<AddItemCubit>(context)
                            .removeItem(itemModel);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        // fill: double.infinity,
                        // opticalSize: double.maxFinite,
                        size: 30.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
