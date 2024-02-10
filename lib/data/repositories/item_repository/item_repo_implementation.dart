import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';

import '../../../core/api_services/api_service.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helper/app_constants.dart';
import 'item_repo.dart';

class ItemRepoImplementation extends ItemRepo {
  ApiService apiService;
  ItemRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, List<ItemModel>>> getItems() async {
    try {
      print("DATA IN Customer REPO IMP ✨✨");
      var data = await apiService.get(
        endPoint: AppConstants.GET_ITEMS,
      );

      List<ItemModel> items = [];
      for (var item in data) {
        items.add(ItemModel.fromJson(item));
      }
      return right(items);
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}