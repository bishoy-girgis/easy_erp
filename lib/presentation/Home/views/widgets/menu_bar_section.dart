import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_routing.dart';
import '../../../../core/helper/global_methods.dart';

class MenuBarSection extends StatelessWidget {
  const MenuBarSection({
    super.key,
    required this.isMenuOpen,
  });

  final bool isMenuOpen;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // opacity: isMenuOpen ? 1.0 : 0.0,
      width: isMenuOpen ? 55.w : 0,

      duration: Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isMenuOpen
            ? Column(
                children: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.goRouterNavigateTO(
                        context: context,
                        router: AppRouters.kSettings,
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      SharedPref.remove(key: "userName");
                      GlobalMethods.goRouterNavigateTOAndReplacement(
                        context: context,
                        router: AppRouters.kLogin,
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
