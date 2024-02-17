import 'package:easy_erp/data/models/invoice_type_model/invoice_type_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceTypeViewModel {
  static List<InvoiceTypeModel> getInvoiceType(context) {
    return [
      InvoiceTypeModel(
        id: 0,
        invoiceTypeName: AppLocalizations.of(context)!.cash,
      ),
      InvoiceTypeModel(
        id: 2,
        invoiceTypeName: AppLocalizations.of(context)!.credit,
      ),
    ];
  }
}
