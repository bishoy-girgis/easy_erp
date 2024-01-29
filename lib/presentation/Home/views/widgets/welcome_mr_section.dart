import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';

class WelcomeMrSection extends StatelessWidget {
  const WelcomeMrSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBuilder(
          AppLocalizations.of(context)!.welcome,
          color: AppColors.secondColorOrange,
          fontSize: 16.sp,
          isHeader: true,
        ),
        TextBuilder(
          "User Name",
          isHeader: true,
          color: AppColors.blackColor,
          fontSize: 20.sp,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
