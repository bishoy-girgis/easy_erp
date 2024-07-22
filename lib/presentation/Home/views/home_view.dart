import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';
import '../../Login/views/widgets/change_language_section.dart';
import '../view_models/categories/categories.dart';
import 'widgets/home_view_header_card.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? version;

  @override
  void initState() {
    super.initState();
    _initializeVersion();
  }

  Future<void> _initializeVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      debugPrint("VERSION Is  $version");
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      onUpdate: () => true,
      upgrader: Upgrader(
        debugLogging: true,
        debugDisplayAlways: true,
        durationUntilAlertAgain: const Duration(days: 1),
        minAppVersion: version,
        debugDisplayOnce: true,
      ),
      dialogStyle: UpgradeDialogStyle.material,
      showIgnore: false,
      showLater: false,
      showReleaseNotes: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: HomeViewHeaderCard(name: AppConstants.userName)),
                const SliverToBoxAdapter(child: GapH(h: 5)),
                SliverGrid.builder(
                  itemCount: CategoriesViewModel.getCategories(context).length,
                  itemBuilder: (context, index) {
                    return CategoriesViewModel.getCategories(context)[index];
                  },
                  gridDelegate: GlobalMethods.isLandscape(context)
                      ? SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18.w,
                          childAspectRatio: 2.3.r,
                          mainAxisSpacing: 22.h,
                        )
                      : SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14.w,
                          childAspectRatio: 1.34.r,
                          mainAxisSpacing: 22.h,
                        ),
                ),
                // const SliverToBoxAdapter(child: GapH(h: 3)),
                // SliverToBoxAdapter(
                //   child: CategoryWidget(
                //     categoryName: l.close_shift,
                //     icon: Icons.access_time_filled_rounded,
                //   ),
                // ),
                const SliverToBoxAdapter(child: GapH(h: 15)),
                const SliverToBoxAdapter(child: ChangeLanguagesSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
