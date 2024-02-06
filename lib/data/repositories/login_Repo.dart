import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../models/user/user_model.dart';

abstract class LoginRepo {
  Future<Either<Failures, UserModel>> userLogin(
      {required String userName, required String password});
}
