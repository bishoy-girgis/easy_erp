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

import 'widgets/app_name_and_menu_button_icon.dart';
import 'widgets/home_view_header_card.dart';
import 'widgets/welcome_mr_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var name = SharedPref.get(key: 'userName');
    var size = Utils(context: context).screenSize;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              HomeViewHeaderCard(name: name),
              GapH(h: 3),
              // HomeViewHeaderCard(name: name),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.home_max,
                        // textDirection: TextDirection.RTL,
                      ),
                      GapH(h: 1),
                      TextBuilder(
                        "Category",
                        isHeader: true,
                        // fontSize: ,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
