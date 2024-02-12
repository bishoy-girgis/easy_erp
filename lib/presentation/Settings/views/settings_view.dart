import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Settings/views/widgets/choose_print_model_section.dart';
import 'package:easy_erp/presentation/Settings/views/widgets/company_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/host_url_section.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          "Settings",
          color: Colors.white,
          isHeader: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref.remove(key: "accessToken");
              SystemNavigator.pop();
            },
            icon: Icon(Icons.done),
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(slivers: [
            HostUrlSection(),
            SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            ChoosePrintModelSection(),
            SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            CompanyInfoSection(),
          ]),
        ),
      )),
    );
  }
}
