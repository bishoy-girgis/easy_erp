import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/utils.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Login/views/widgets/change_language_section.dart';
import 'widgets/app_name_and_menu_button_section.dart';
import 'widgets/category_widget.dart';
import 'widgets/home_view_header_card.dart';
import 'widgets/welcome_mr_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    final List<CategoryWidget> categories = [
      CategoryWidget(icon: Icons.category_rounded, categoryName: l.items),
      CategoryWidget(icon: Icons.attach_money, categoryName: l.invoises),
      CategoryWidget(icon: Icons.people_rounded, categoryName: l.customers),
      CategoryWidget(
          icon: Icons.keyboard_return_rounded, categoryName: l.returns),
      CategoryWidget(icon: Icons.receipt_long, categoryName: l.recceipt),
      CategoryWidget(icon: Icons.payments_rounded, categoryName: l.exchange),
    ];
    var name = SharedPref.get(key: 'userName');
    var size = Utils(context: context).screenSize;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              HomeViewHeaderCard(name: name),
              const GapH(h: 3),
              // HomeViewHeaderCard(name: name),
              // SizedBox(
              //   height: size.height * .5,
              //   child: GridView.builder(
              //     itemCount: 6,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 20.w,
              //         childAspectRatio: 1.6.r,
              //         mainAxisSpacing: 20.h),
              //     itemBuilder: (context, index) {
              //       return CategoryWidget();
              //     },
              //   ),
              // ),
              SizedBox(
                height: size.height * .40,
                child: GridView(
                  // itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      childAspectRatio: 1.9.r,
                      mainAxisSpacing: 20.h),
                  children: categories,
                ),
              ),
              const GapH(h: 2),
              CategoryWidget(
                categoryName: l.close_shift,
                icon: Icons.access_time_filled_rounded,
              ),
              const Spacer(),
              const ChangeLanguagesSection(),
            ],
          ),
        ),
      )),
    );
  }
}
