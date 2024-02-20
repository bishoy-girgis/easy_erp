import 'package:equatable/equatable.dart';

class AddCustomerResponseModel extends Equatable {
  final String? massage;
  final int? customercode;

  const AddCustomerResponseModel({this.massage, this.customercode});

  factory AddCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerResponseModel(
      massage: json['massage'] as String?,
      customercode: json['customercode'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'massage': massage,
        'customercode': customercode,
      };

  @override
  List<Object?> get props => [massage, customercode];
}
