import 'package:easy_erp/core/helper/app_colors.dart';

import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../cubits/addItem_cubit/add_item_cubit.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    required this.itemModel,
  });
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.of<AddItemCubit>(context).addedItems.contains(itemModel)
        ? GestureDetector(
            onTap: () {},
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
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.secondColorOrange,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            itemModel.quantity.toString(),
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 10,
                          ),
                          const GapH(h: 5.4),
                          TextBuilder(
                            itemModel.unitname ?? "",
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 10,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 4.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            itemModel.itmname!,
                            isHeader: true,
                            color: AppColors.blackColor,
                          ),
                          const GapH(h: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextBuilder(
                                AppLocalizations.of(context)!.price,
                                color: Colors.black,
                              ),
                              TextBuilder(
                                AppLocalizations.of(context)!.totalItemsInvoice,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.blueGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextBuilder(
                                itemModel.salesprice.toString(),
                                color: Colors.black,
                              ),
                              TextBuilder(
                                "${itemModel.quantity * itemModel.salesprice!}",
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<AddItemCubit>(context)
                          .removeItem(itemModel);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      // fill: double.infinity,
                      // opticalSize: double.maxFinite,
                      size: 15.sp,
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
