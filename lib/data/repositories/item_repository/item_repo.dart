import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../models/item_model/item_model.dart';

abstract class ItemRepo {
  Future<Either<Failures, List<ItemModel>>> getItems(int? invoId);
}
