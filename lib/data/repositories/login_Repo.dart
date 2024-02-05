abstract class LoginRepo {
  Future<Either<Failures, List<BookModel>>> fetchNewstBooks();
      {required String category});
}
