import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';

class WelcomeMrSection extends StatelessWidget {
  const WelcomeMrSection({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextBuilder(
          AppLocalizations.of(context)!.welcome,
          color: AppColors.secondColorOrange,
          fontSize: 16.sp,
          isHeader: true,
        ),
        TextBuilder(
          name,
          isHeader: true,
          color: Colors.blueGrey,
          fontSize: 20.sp,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
