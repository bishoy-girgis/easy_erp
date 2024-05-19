import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/main.dart';
import 'package:easy_erp/presentation/Login/views/login_view.dart';
import 'package:easy_erp/presentation/Settings/views/widgets/choose_print_model_section.dart';
import 'package:easy_erp/presentation/Settings/views/widgets/company_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/host_url_section.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  TextBuilder(
          AppLocalizations.of(context)!.settings,
          color: Colors.white,
          isHeader: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppConstants.updateSettingValues();
              debugPrint("supmiitttteeeddddddddddddddddddddddddddddddddddd");
              debugPrint(AppConstants.branchName);
              debugPrint(AppConstants.branchAddress);
              debugPrint(AppConstants.taxNumber);
              debugPrint(AppConstants.notes);
              debugPrint(AppConstants.baseUrl);
              debugPrint(
                  "${SharedPref.get(key: "logoPath")}  IMAGE LOGOOOO PATHHH");
              SharedPref.remove(key: "accessToken");
              navigatorKey.currentState!
                  .pushNamedAndRemoveUntil(AppRouters.kLogin, (route) => false);
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(slivers: [
            HostUrlSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            const ChoosePrintModelSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            const CompanyInfoSection(),
          ]),
        ),
      )),
    );
  }
}
