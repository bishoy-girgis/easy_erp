// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../view_models/item_cubit/item_cubit.dart';

class AddItemsView extends StatelessWidget {
  AddItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetItemCubit, GetItemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        List<ItemModel> items = [];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Select items'),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.goRouterPOP(context);
                },
                icon: Icon(
                  Icons.done,
                ),
              ),
            ],
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
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: AppColors.whiteColor,
                  ),
                  child: state is GetItemsLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : state is GetItemsSuccessState
                          ? GridView.builder(
                              padding: const EdgeInsets.all(20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 0.38.r,
                              ),
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                return AddItemWidget(
                                  items: items,
                                  itemModel: state.items[index],
                                  onItemSelectionChanged: (item) {
                                    // Update the items list in the parent view
                                    if (items.contains(item)) {
                                      items.remove(item);
                                    } else {
                                      items.add(item);
                                    }
                                  },
                                );
                              },
                            )
                          : TextBuilder(
                              "There is Error , we will Solve it,try again"),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final ItemModel itemModel;
  final Function(ItemModel) onItemSelectionChanged;
  final List<ItemModel> items;
  const AddItemWidget({
    Key? key,
    required this.itemModel,
    required this.items,
    required this.onItemSelectionChanged,
  }) : super(key: key);

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  void toggleSelection(ItemModel item) {
    setState(() {
      if (widget.items.contains(item)) {
        widget.items.remove(item);
      } else {
        print(item.itmcode);
        print(item.itmename);
        print(item.itmename);
        widget.items.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var priceController =
        TextEditingController(text: widget.itemModel.salesprice.toString());
    var quantityController = TextEditingController(text: "1");
    var discountController = TextEditingController(text: "0");
    // bool isSelected = BlocProvider.of<AddItemCubit>(context).isSelected;
    bool isSelected = false;

    return BlocBuilder<AddItemCubit, AddItemState>(
      builder: (context, state) {
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
                child: CheckboxListTile(
                  title: TextBuilder(
                    widget.itemModel.unitname ?? "",
                    // isHeader: true,
                  ),
                  value: BlocProvider.of<AddItemCubit>(context)
                      .addedItems
                      .contains(widget.itemModel),
                  onChanged: (bool? isChecked) {
                    BlocProvider.of<AddItemCubit>(
                      context,
                    ).getAddedItems(widget.itemModel);
                  },
                ),
              ),
              TextBuilder(
                (widget.itemModel.itmname != null &&
                        widget.itemModel.itmname!.isNotEmpty)
                    ? widget.itemModel.itmname!
                    : "",
                isHeader: true,
                fontSize: 20,
              ),
              TextBuilder(
                (widget.itemModel.itmename != null &&
                        widget.itemModel.itmename!.isNotEmpty)
                    ? widget.itemModel.itmename!
                    : "",
                isHeader: true,
                fontSize: 20,
              ),
              TextBuilder(
                "Price",
                isHeader: true,
                fontSize: 16,
              ),
              Flexible(
                child: CustomTextFormField(
                  labelText: priceController.text,
                  keyboardType: TextInputType.number,
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
                "Quantity",
                isHeader: true,
                fontSize: 16,
                // color: Colors.,
              ),
              Flexible(
                child: CustomTextFormField(
                  labelText: quantityController.text,
                  backgroundOfTextFeild: Colors.blueGrey,
                  centerContent: true,
                  contentSize: 20,
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  isContentBold: true,
                  onChange: (value) {
                    quantityController.text = value;
                  },
                ),
              ),
              const TextBuilder(
                "Discount",
                isHeader: true,
                fontSize: 16,
                // color: Colors.,
              ),
              Flexible(
                child: CustomTextFormField(
                  labelText: discountController.text,
                  backgroundOfTextFeild: Colors.blueGrey,
                  contentSize: 20,
                  centerContent: true,
                  controller: discountController,
                  keyboardType: TextInputType.number,
                  isContentBold: true,
                  onChange: (value) {
                    discountController.text = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
