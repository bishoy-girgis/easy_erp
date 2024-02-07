import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../data/providers/localization/localization_provider.dart';

class ChangeLanguagesSection extends StatelessWidget {
  const ChangeLanguagesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: LinearBorder.bottom()),
          onPressed: () {
            Provider.of<LanguageProvider>(context, listen: false)
                .setLocale('en');
          },
          child: Text(AppLocalizations.of(context)!.enLanguage),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: LinearBorder.bottom(
                  // size: .5,
                  )),
          onPressed: () {
            Provider.of<LanguageProvider>(context, listen: false)
                .setLocale('ar');
          },
          child: Text(AppLocalizations.of(context)!.arLanguage),
        ),
      ],
    );
  }
}
