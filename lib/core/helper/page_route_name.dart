class AppRouters {
  static const kLogin = "/loginView";
  static const kSplash = "/";
  static const kHome = "/home";
  static const kSettings = "/settings";
  static const kItems = "$kHome/items";
  static const kCustomers = "$kHome/customers";
  static const kReturns = "$kHome/returns";
  static const kCreateReturn = "$kReturns/createReturn";
  static const kReciept = "$kHome/reciept";
  static const kCreateReciept = "$kReciept/createReciept";
  static const kPaid = "$kHome/paid";
  static const kCreatePaid = "$kPaid/createPaid";
  static const kInvoices = "$kHome/invoices";
  static const kCreateInvoice = "$kInvoices/createInvoice";
  static const kAddItemsIntoInvoice =
      "$kHome/invoices/createInvoice/addItemsIntoInvoice";
  static const kInvoicePreviewPDFView = "$kHome/invoices/invoiceShowDetailsPDF";
  static const kCreateNewCustomer = "$kCustomers/createNewCustomer";
}
