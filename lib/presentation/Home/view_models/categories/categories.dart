// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_erp/presentation/Home/views/widgets/category_widget.dart';
import '../../../../core/helper/app_routing.dart';
import '../../../../core/helper/global_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesViewModel {
  static List<CategoryWidget> getCategories(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    return [
      CategoryWidget(
        icon: Icons.category_rounded,
        categoryName: l.items,
        onTap: () async {
          GlobalMethods.goRouterNavigateTO(
            context: context,
            router: AppRouters.kItems,
          );
          // await GetItemCubit.get(context).getItems();
        },
      ),
      CategoryWidget(
          icon: Icons.people_rounded,
          categoryName: l.customers,
          onTap: () async {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kCustomers);
            // await CustomerCubit.get(context).getCustomers();
            //  await CustomerCubit.get(context).getCustomerGroups();
          }),
      CategoryWidget(
          icon: Icons.attach_money,
          categoryName: l.invoises,
          onTap: () async {
            GlobalMethods.goRouterNavigateTO(
              context: context,
              router: AppRouters.kInvoices,
            );
            //  await InvoiceCubit.get(context).getInvoices();
          }),
      CategoryWidget(
          icon: Icons.keyboard_return_rounded,
          categoryName: l.returns,
          onTap: () async {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kReturns);
            await Returncubit.get(context).getReturns();
          }),
      CategoryWidget(icon: Icons.receipt_long, categoryName: l.recceipt),
      CategoryWidget(icon: Icons.payments_rounded, categoryName: l.exchange),
    ];
  }
}
