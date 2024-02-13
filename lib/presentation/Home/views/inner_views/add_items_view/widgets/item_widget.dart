import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/models/item_model/item_model.dart';
import '../../../../view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var quantityController =
        TextEditingController(text: itemModel.quantity.toString());
    // int quantity;

    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<AddItemCubit>(context).checkItemInList(itemModel)
                ? BlocProvider.of<AddItemCubit>(context).removeItem(itemModel)
                : BlocProvider.of<AddItemCubit>(context).addItem(itemModel);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
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
                  ? AppColors.primaryColorBlue.withOpacity(.3)
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBuilder(
                  (itemModel.itmname != null && itemModel.itmname!.isNotEmpty)
                      ? itemModel.itmname!
                      : "",
                  isHeader: true,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBuilder(itemModel.itmid.toString()),
                    TextBuilder(itemModel.unitname!),
                  ],
                ),
                TextBuilder(
                  AppLocalizations.of(context)!.price,
                  isHeader: true,
                  fontSize: 16,
                ),
                Flexible(
                  child: CustomTextFormField(
                    labelText: priceController.text,
                    keyboardType: TextInputType.number,
                    // backgroundOfTextFeild: Colors.blueGrey,
                    centerContent: true,
                    contentSize: 20,
                    controller: priceController,
                    isContentBold: true,
                    onChange: (value) {
                      priceController.text = value;
                    },
                  ),
                ),
                TextBuilder(
                  AppLocalizations.of(context)!.quantity,
                  isHeader: true,
                  fontSize: 16,
                  // color: Colors.,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // itemModel.quantity = int.parse(quantityController.text);
                        // itemModel.quantity++;
                        // quantityController.text = itemModel.quantity.toString();
                        if (itemModel.quantity < 500) {
                          itemModel.quantity =
                              int.parse(quantityController.text);
                          itemModel.quantity++;
                          quantityController.text =
                              itemModel.quantity.toString();
                        } else {
                          GlobalMethods.buildFlutterToast(
                              message: "You can't choose more than 500 item",
                              state: ToastStates.WARNING);
                        }
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      ),
                    ),
                    Flexible(
                      child: CustomTextFormField(
                        labelText: quantityController.text,
                        // backgroundOfTextFeild: Colors.blueGrey,
                        centerContent: true,
                        contentSize: 20,
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        isContentBold: true,
                        onChange: (value) {
                          if (value.isEmpty) {
                            quantityController.text = '1';
                          } else if (double.parse(quantityController.text) >=
                              5000) {
                            quantityController.text = '5000';
                            itemModel.quantity = int.parse(value);
                            GlobalMethods.buildFlutterToast(
                                gravity: ToastGravity.CENTER,
                                message: "You can't add more than 5000 items",
                                state: ToastStates.WARNING);
                          } else {
                            quantityController.text.replaceAll('1', value);
                            quantityController.text = value;
                            itemModel.quantity = int.parse(value);
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        itemModel.quantity = int.parse(quantityController.text);
                        if (itemModel.quantity > 1) {
                          itemModel.quantity--;
                          quantityController.text =
                              itemModel.quantity.toString();
                        } else {
                          GlobalMethods.buildFlutterToast(
                              message: "You can't choose less than 1 item",
                              state: ToastStates.WARNING);
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBuilder(
                      AppLocalizations.of(context)!.discount,
                      isHeader: true,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      itemModel.discP.toString() + "%",
                      isHeader: true,
                      fontSize: 16,
                    ),
                  ],
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
                      fontSize: 16,
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
