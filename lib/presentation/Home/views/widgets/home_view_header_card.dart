import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import 'app_name_and_menu_button_icon.dart';
import 'welcome_mr_section.dart';

class HomeViewHeaderCard extends StatefulWidget {
  const HomeViewHeaderCard({
    super.key,
  });

  @override
  State<HomeViewHeaderCard> createState() => _HomeViewHeaderCardState();
}

class _HomeViewHeaderCardState extends State<HomeViewHeaderCard> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ]),
      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                AppNameAndMenuButtonSection(
                  onMenuPressed: () {
                    setState(() {
                      isMenuOpen = !isMenuOpen;
                    });
                  },
                ),
                Divider(
                  thickness: 2,
                  color: AppColors.primaryColorBlue,
                ),
                WelcomeMrSection()
              ],
            ),
          ),
          if (isMenuOpen)
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.goRouterNavigateTO(
                      context: context,
                      router: AppRouters.kSettings,
                    );
                  },
                  icon: Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
