import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Login/views/widgets/change_language_section.dart';
import '../view_models/categories/categories.dart';
import 'widgets/category_widget.dart';
import 'widgets/home_view_header_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    final List<CategoryWidget> categories =
        CategoriesViewModel.getCategories(context);
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
