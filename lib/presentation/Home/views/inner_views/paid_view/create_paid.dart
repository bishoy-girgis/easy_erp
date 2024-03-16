import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/widgets/voucher_valu_paid.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/notes_image_widget.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/reciept_main_data.dart';
import 'package:flutter/material.dart';

class CreatePaid extends StatelessWidget {
  const CreatePaid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildCreatePaidBody(),
    );
  }

  _buildCreatePaidBody() {
    return Container(
      color: const Color.fromARGB(255, 4, 90, 136),
      child: SafeArea(
          child: CustomScrollView(
        slivers: [
          const RecieptMainData(),
          const SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          VoucherValuepaid(),
          const SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          NotesImageWidget(),
        ],
      )),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: const TextBuilder(
        "Create Paid Voucher",
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      leading: IconButton(
          onPressed: () {
            GlobalMethods.navigatePOP(context);
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        IconButton(
          onPressed: () async {
            GlobalMethods.showAlertAdressDialog(
              context,
              title: "Save Return ?",
              titleButton1: "Save",
              titleButton2: "No",
              onPressedButton1: () async {},
              onPressedButton2: () {
                GlobalMethods.navigatePOP(context);
              },
            );
          },
          icon: const Icon(
            Icons.done,
          ),
        )
      ],
    );
  }
}
