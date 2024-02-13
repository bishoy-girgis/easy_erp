import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';

class InvoiceModel {
  final CustomerModel customer;
  final String address;
  // final String name;
  final List<ItemModel> items;
  InvoiceModel({
    required this.customer,
    required this.address,
    required this.items,
    // required this.name,
  });
  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.salesprice!);
  }
}

class LineItem {
  final String description;
  final double cost;

  LineItem(this.description, this.cost);
}
