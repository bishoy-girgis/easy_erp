// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:easy_erp/presentation/Home/views/widgets/category_widget.dart';

import '../../../../core/helper/app_routing.dart';
import '../../../../core/helper/global_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helper/locator.dart';

class CategoriesViewModel {
  // BuildContext context;
  // CategoriesViewModel({
  //   required this.context,
  // });
  static List<CategoryWidget> getCategories(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    return [
      CategoryWidget(
        icon: Icons.category_rounded,
        categoryName: l.items,
        onTap: () {
          GlobalMethods.goRouterNavigateTO(
            context: context,
            router: AppRouters.kItems,
          );
        },
      ),
      CategoryWidget(
          icon: Icons.people_rounded,
          categoryName: l.customers,
          onTap: () {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kCustomers);
          }),
      CategoryWidget(
          icon: Icons.attach_money,
          categoryName: l.invoises,
          onTap: () {
            GlobalMethods.goRouterNavigateTO(
              context: context,
              router: AppRouters.kInvoices,
              // extraObject: [
              //   InvoiceModel(
              //     items: getIt.get<AddItemCubit>().addedItems,
              //   ),
              //   InvoiceModel(
              //     items: getIt.get<AddItemCubit>().addedItems,
              //   ),
              // ],
            );
          }),
      CategoryWidget(
          icon: Icons.keyboard_return_rounded,
          categoryName: l.returns,
          onTap: () {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kReturns);
          }),
      CategoryWidget(icon: Icons.receipt_long, categoryName: l.recceipt),
      CategoryWidget(icon: Icons.payments_rounded, categoryName: l.exchange),
    ];
  }
}
