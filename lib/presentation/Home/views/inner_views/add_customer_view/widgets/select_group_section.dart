import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/data/models/group_model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/services/local/shared_pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../cubits/customer_cubit/customer_cubit.dart';

class ChooseGroup extends StatelessWidget {
  const ChooseGroup({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        if (state is GetCustomerGroupSuccess) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<GroupModel>(
              validator: (value) {
                if (value == null) {
                  print("pleaseee enteeeeeeeeeeerrrrr");
                  return "please enter group name";
                }
                return null;
              },
              items: state.groups,
              itemAsString: (GroupModel group) =>
                  group.custCategoryName ?? group.custCategoryEname ?? 'None',
              popupProps: PopupProps.menu(
                fit: FlexFit.loose, // << change this

                itemBuilder: (context, group, isSelected) {
                  return Container(
                      padding: const EdgeInsets.all(20),
                      // alignment: Alignment.center,
                      child: TextBuilder(
                        group.custCategoryName ??
                            group.custCategoryEname ??
                            'None',
                        textAlign: TextAlign.center,
                        color: isSelected
                            ? AppColors.secondColorOrange
                            : AppColors.primaryColorBlue,
                      ));
                },
              ),
              dropdownButtonProps: const DropdownButtonProps(
                color: AppColors.primaryColorBlue,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlign: TextAlign.center,
                baseStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlignVertical: TextAlignVertical.center,
                dropdownSearchDecoration: InputDecoration(
                    label: TextBuilder(
                      AppLocalizations.of(context)!.group,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
              onChanged: (GroupModel? data) {
                debugPrint(data!.custCategoryId.toString());
                debugPrint(data.custCategoryName);
                debugPrint(data.custCategoryEname);

                SharedPref.set(
                    key: "custCategoryId", value: data.custCategoryId);

                debugPrint(SharedPref.get(key: "custCategoryId").toString());
              },
            ),
          );
        } else if (state is GetCustomerGroupLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
