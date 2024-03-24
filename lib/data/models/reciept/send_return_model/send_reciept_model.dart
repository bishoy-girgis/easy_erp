import 'package:equatable/equatable.dart';

class SendRecieptModel extends Equatable {
  final String? massage;
  final int? recNo;
  final int? recId;

  const SendRecieptModel({this.massage, this.recNo, this.recId});

  factory SendRecieptModel.fromJson(Map<String, dynamic> json) {
    return SendRecieptModel(
      massage: json['massage'] as String?,
      recNo: json['rec_no'] as int?,
      recId: json['rec_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'massage': massage,
        'rec_no': recNo,
        'rec_id': recId,
      };

  @override
  List<Object?> get props => [massage, recNo, recId];
}
