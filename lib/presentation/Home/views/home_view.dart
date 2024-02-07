import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Login/views/widgets/change_language_section.dart';
import 'widgets/category_widget.dart';
import 'widgets/home_view_header_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    final List<CategoryWidget> categories = [
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
          icon: Icons.attach_money,
          categoryName: l.invoises,
          onTap: () {
            GlobalMethods.goRouterNavigateTO(
              context: context,
              router: AppRouters.kInvoices,
            );
          }),
      CategoryWidget(
          icon: Icons.people_rounded,
          categoryName: l.customers,
          onTap: () {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kCustomers);
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
    var name = SharedPref.get(key: 'userName');
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomeViewHeaderCard(name: name)),
            const SliverToBoxAdapter(child: const GapH(h: 3)),
            SliverGrid.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return categories[index];
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                childAspectRatio: 1.9.r,
                mainAxisSpacing: 20.h,
              ),
            ),
            const SliverToBoxAdapter(child: GapH(h: 3)),
            SliverToBoxAdapter(
              child: CategoryWidget(
                categoryName: l.close_shift,
                icon: Icons.access_time_filled_rounded,
              ),
            ),
            const SliverToBoxAdapter(child: GapH(h: 5)),
            const SliverToBoxAdapter(child: ChangeLanguagesSection()),
          ],
        ),
      )),
    );
  }
}
