import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/notes_image_widget.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/reciept_main_data.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/voucher_value_widget.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_cubit.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateReciept extends StatelessWidget {
  const CreateReciept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildCreateRecieptBody(),
    );
  }

  _buildCreateRecieptBody() {
    return Container(
      color: AppColors.primaryColorBlue,
      child: const SafeArea(
          child: CustomScrollView(
        slivers: [
          RecieptMainData(),
          SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          VoucherValuWidget(),
          SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          NotesImageWidget()
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
    if ((SharedPref.get(key: 'recieptVoucher') == null ||
        SharedPref.get(key: 'recieptVoucher') == 0)) {
      GlobalMethods.buildFlutterToast(
          message: 'Cant save reciept  please Add Voucher Value',
          state: ToastStates.ERROR);
      return false;
    }
    return true;
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.create_reciept_vouchers,
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      leading: IconButton(
          onPressed: () {
            GlobalMethods.navigatePOP(context);
            SharedPref.remove(key: "notesVoucher");
            SharedPref.remove(key: "recieptVoucher");
            SharedPref.remove(key: 'PayerChartId');
            SharedPref.remove(key: 'PayerChartName');
            SharedPref.remove(key: 'paymebtTypeName');
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        BlocConsumer<Recieptcubit, RecieptState>(
          listener: (context, state) {
            if (state is RecieptSavedSuccess) {
              debugPrint("=============================");
              debugPrint(state.sendRecieptModel.massage);
              debugPrint("${state.sendRecieptModel.recId}");
              GlobalMethods.buildFlutterToast(
                  message: state.sendRecieptModel.massage!,
                  state: ToastStates.SUCCESS);
              Recieptcubit.get(context).getReciepts();

              GlobalMethods.goRouterNavigateTOAndReplacement(
                  context: context, router: AppRouters.kReciept);
            } else if (state is RecieptNotSave) {
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
                    ? GlobalMethods.showAlertAdressDialog(
                        context,
                        title: "Save Reciept ?",
                        titleButton1: "Save",
                        titleButton2: "No",
                        onPressedButton1: () async {
                          await BlocProvider.of<Recieptcubit>(context)
                              .saveReciept(context);
                          SharedPref.remove(key: "notesVoucher");
                          SharedPref.remove(key: "recieptVoucher");
                          SharedPref.remove(key: 'PayerChartId');
                          SharedPref.remove(key: 'PayerChartName');
                          SharedPref.remove(key: 'paymebtTypeName');
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
