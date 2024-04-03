import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../cubits/addItem_cubit/add_item_cubit.dart';

class AddItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  const AddItemWidget({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var priceController =
        TextEditingController(text: itemModel.salesprice.toString());
    // var quantityController = TextEditingController(text: 1.toString());
    // var limitController = TextEditingController(text: "5000");
    // if (SharedPref.get(key: "ReturnSelectedId") != null) {
    //   quantityController = TextEditingController(text: 1.toString());
    //   limitController =
    //       TextEditingController(text: itemModel.quantity.toString());
    // }
    int quantityController = 1;
    int limitController = 5000;
    // if (SharedPref.get(key: "ReturnSelectedId") != null) {
    //quantityController = 1;
    //limitController = int.parse(itemModel.quantity.toInt().toString());
    // }
    // ignore: non_constant_identifier_names
    var Controller = TextEditingController(text:itemModel.quantity.toString());

    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<AddItemCubit>(context).checkItemInList(itemModel)
                ? BlocProvider.of<AddItemCubit>(context).removeItem(itemModel)
                : BlocProvider.of<AddItemCubit>(context).addItem(itemModel);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: BlocProvider.of<AddItemCubit>(context)
                          .checkItemInList(itemModel)
                      ? AppColors.primaryColorBlue
                      : Colors.transparent,
                  width: 3),
              color: BlocProvider.of<AddItemCubit>(context)
                      .checkItemInList(itemModel)
                  ? AppColors.primaryColorBlue.withOpacity(.22)
                  : Colors.white,
              boxShadow: BlocProvider.of<AddItemCubit>(context)
                      .checkItemInList(itemModel)
                  ? null
                  : const [
                      BoxShadow(
                        color: Colors.black45,
                        spreadRadius: 1.5,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBuilder(
                  (itemModel.itmname != null && itemModel.itmname!.isNotEmpty)
                      ? itemModel.itmname!
                      : "",
                  isHeader: true,
                  textAlign: TextAlign.center,
                  fontSize: 17,
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBuilder(
                      itemModel.itmcode.toString(),
                      fontSize: 14,
                    ),
                    TextBuilder(
                      itemModel.unitname ?? "",
                      fontSize: 14,
                    ),
                  ],
                ),
                Flexible(
                  child: CustomTextFormField(
                    suffixIcon: FontAwesomeIcons.moneyBillWave,
                    suffixIconSize: 22.sp,
                    labelText: priceController.text,
                    keyboardType: TextInputType.number,
                    // backgroundOfTextFeild: Colors.blueGrey,
                    centerContent: true,
                    contentSize: 18,
                    controller: priceController,
                    isContentBold: true,
                    onTap: () {
                      priceController.text = "";
                    },
                    onChange: (value) {
                      priceController.text = value;
                      String price = priceController.text;
                      if (value.isEmpty) {
                        price = "0.0";
                      }
                      itemModel.salesprice = double.parse(price);
                      getIt.get<AddItemCubit>().changeQuantity();
                    },
                  ),
                ),
                TextBuilder(
                  AppLocalizations.of(context)!.quantity,
                  isHeader: true,
                  fontSize: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        if (quantityController < limitController) {
                          quantityController++;
                          itemModel.quantity = quantityController;
                        } else {
                          quantityController = limitController;
                          GlobalMethods.buildFlutterToast(
                              message:
                                  "You can't choose more than limit $limitController",
                              state: ToastStates.WARNING);
                        }
                        getIt.get<AddItemCubit>().changeQuantity();
                        Controller.text = quantityController.toString();
                      },
                      icon: Icon(
                        Icons.arrow_circle_up_outlined,
                        color: AppColors.primaryColorBlue,
                        size: 30.sp,
                      ),
                    ),
                    Flexible(
                      child: CustomTextFormField(
                        labelText: quantityController.toString(),
                        centerContent: true,
                        contentSize: 18,
                        controller: Controller,
                        keyboardType: TextInputType.number,
                        isContentBold: true,
                        onTap: () {
                          Controller.text = "";
                        },
                        onChange: (value) {
                          if (value.isEmpty) {
                            quantityController = 0;
                          } else if (quantityController >= limitController) {
                            quantityController = limitController;
                            itemModel.quantity = quantityController;
                            GlobalMethods.buildFlutterToast(
                                gravity: ToastGravity.CENTER,
                                message:
                                    "You can't add more than limit $limitController",
                                state: ToastStates.WARNING);
                          } else {
                            quantityController = int.parse(value);
                            itemModel.quantity = quantityController;
                          }
                          Controller.text = quantityController.toString();
                          getIt.get<AddItemCubit>().changeQuantity();
                        },
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        // itemModel.quantity = int.parse(quantityController.text);
                        if (quantityController > 1) {
                          quantityController--;

                          itemModel.quantity = quantityController;
                        } else {
                          GlobalMethods.buildFlutterToast(
                              message: "You can't choose less than 1 item",
                              state: ToastStates.WARNING);
                        }
                        Controller.text = quantityController.toString();
                        getIt.get<AddItemCubit>().changeQuantity();
                      },
                      icon: Icon(
                        Icons.arrow_circle_down_outlined,
                        color: AppColors.secondColorOrange,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBuilder(
                        AppLocalizations.of(context)!.discount,
                        isHeader: true,
                        fontSize: 14,
                      ),
                      TextBuilder(
                        // ignore: prefer_interpolation_to_compose_strings
                        itemModel.discP.toString() + "%",
                        isHeader: true,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        value: BlocProvider.of<AddItemCubit>(context)
                            .checkItemInList(itemModel),
                        onChanged: (bool? isChecked) {
                          BlocProvider.of<AddItemCubit>(context)
                                  .checkItemInList(itemModel)
                              ? BlocProvider.of<AddItemCubit>(context)
                                  .removeItem(itemModel)
                              : BlocProvider.of<AddItemCubit>(context)
                                  .addItem(itemModel);
                        },
                      ),
                    ),
                    TextBuilder(
                      AppLocalizations.of(context)!.add,
                      isHeader: true,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
??check