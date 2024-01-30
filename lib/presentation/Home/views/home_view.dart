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
      CategoryWidget(categoryName: l.exchange),
      CategoryWidget(categoryName: l.invoises),
      CategoryWidget(categoryName: l.items),
      CategoryWidget(categoryName: l.exchange),
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
              GapH(h: 3),
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
              Expanded(
                child: GridView(
                  // itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      childAspectRatio: 2.r,
                      mainAxisSpacing: 20.h),
                  children: categories,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
