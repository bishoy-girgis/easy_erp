import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_colors.dart';
import 'app_name_and_menu_button_section.dart';
import 'menu_bar_section.dart';
import 'welcome_mr_section.dart';

class HomeViewHeaderCard extends StatefulWidget {
  const HomeViewHeaderCard({
    super.key,
    required this.name,
  });
  final String name;

  @override
  State<HomeViewHeaderCard> createState() => _HomeViewHeaderCardState();
}

class _HomeViewHeaderCardState extends State<HomeViewHeaderCard> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(10.sp),
      margin:  EdgeInsets.all(10.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: AppColors.whiteColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
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
                const Divider(
                  thickness: 2,
                  // color: AppColors.primaryColorBlue,
                ),
                WelcomeMrSection(
                  name: widget.name,
                )
              ],
            ),
          ),
          MenuBarSection(isMenuOpen: isMenuOpen),
        ],
      ),
    );
  }
}
