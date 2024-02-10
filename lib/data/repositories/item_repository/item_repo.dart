import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../models/customer_model/customer_model.dart';
import '../../models/item_model/item_model.dart';

abstract class ItemRepo {
  Future<Either<Failures, List<ItemModel>>> getItems();
}
