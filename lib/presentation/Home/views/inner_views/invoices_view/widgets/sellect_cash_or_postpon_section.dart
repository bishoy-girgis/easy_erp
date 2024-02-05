import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/text_builder.dart';

class SellectCashOrPostponeSection extends StatefulWidget {
  const SellectCashOrPostponeSection({super.key});

  @override
  State<SellectCashOrPostponeSection> createState() =>
      _SellectCashOrPostponeSectionState();
}

class _SellectCashOrPostponeSectionState
    extends State<SellectCashOrPostponeSection> {
  String selectedOption = 'In-Cash';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        child: DropdownButton<String>(
          value: selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: <String>[
            'In-Cash',
            'Postpone',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextBuilder(
                value,
                isHeader: true,
                fontSize: 14,
                color: Colors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
