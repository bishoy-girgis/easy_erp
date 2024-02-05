import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_text_form_field.dart';

class SearchOnCustomerNameSection extends StatelessWidget {
  const SearchOnCustomerNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.person,
      labelText: "Customer name",
      hintText: "search on customer name",
      isLabelBold: true,
    );
  }
}
