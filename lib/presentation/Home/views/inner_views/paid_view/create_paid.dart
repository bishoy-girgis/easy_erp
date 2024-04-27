import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/widgets/voucher_valu_paid.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/notes_image_widget.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/reciept_main_data.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_cubit.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      color: AppColors.primaryColorBlue,
      child: const SafeArea(
          child: CustomScrollView(
        slivers: [
          RecieptMainData(),
          SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          VoucherValuepaid(),
          SliverToBoxAdapter(
            child: GapH(h: 1.5),
          ),
          NotesImageWidget(),
        ],
      )),
    );
  }

  bool checkChoosePayer() {
    if ((SharedPref.get(key: 'PayerChartId') == null ||
        SharedPref.get(key: 'PayerChartId') == 0)) {
      GlobalMethods.buildFlutterToast(
          message: 'Cant save reciept  please choose your Payer to Save',
          state: ToastStates.ERROR);
      return false;
    }
    return true;
  }

  bool checkVoucherValue() {
    if ((SharedPref.get(key: 'paidVoucher') == null ||
        SharedPref.get(key: 'paidVoucher') == 0)) {
      GlobalMethods.buildFlutterToast(
          message: 'Cant save Paid  please Add Voucher Value',
          state: ToastStates.ERROR);
      return false;
    }
    return true;
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.create_paid_voucher,
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      leading: IconButton(
          onPressed: () {
            GlobalMethods.navigatePOP(context);
            SharedPref.remove(key: "notesVoucher");
            SharedPref.remove(key: "paidVoucher");
            SharedPref.remove(key: 'PayerChartId');
            SharedPref.remove(key: 'PayerChartName');
            SharedPref.remove(key: 'paymebtTypeName');
            SharedPref.remove(key: 'taxVoucher');
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        BlocConsumer<PaidCubit, PaidState>(
          listener: (context, state) {
            if (state is PaidSavedSuccess) {
              debugPrint("=============================");
              debugPrint(state.sendPaidModel.massage);
              debugPrint("${state.sendPaidModel.payId}");
              GlobalMethods.buildFlutterToast(
                  message: state.sendPaidModel.massage!,
                  state: ToastStates.SUCCESS);
              PaidCubit.get(context).getPaids();

              GlobalMethods.goRouterNavigateTOAndReplacement(
                  context: context, router: AppRouters.kPaid);
            } else if (state is PaidNotSave) {
              GlobalMethods.navigatePOP(context);
              GlobalMethods.buildFlutterToast(
                  message: state.error, state: ToastStates.ERROR);
              debugPrint(state.error);
            } else {
              debugPrint("=============================");
              debugPrint('Dont Know');
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                checkChoosePayer() && checkVoucherValue()
                    ? GlobalMethods.showAlertAddressDialog(
                        context,
                        title: "Save Paid ?",
                        titleButton1: "Save",
                        titleButton2: "No",
                        onPressedButton1: () async {
                          await BlocProvider.of<PaidCubit>(context)
                              .savePaid(context);
                          SharedPref.remove(key: "notesVoucher");
                          SharedPref.remove(key: "paidVoucher");
                          SharedPref.remove(key: 'PayerChartId');
                          SharedPref.remove(key: 'PayerChartName');
                          SharedPref.remove(key: 'paymebtTypeName');
                          SharedPref.remove(key: 'taxVoucher');
                        },
                        onPressedButton2: () {
                          GlobalMethods.navigatePOP(context);
                        },
                      )
                    : Container();
              },
              icon: const Icon(
                Icons.done,
              ),
            );
          },
        ),
      ],
    );
  }
}
