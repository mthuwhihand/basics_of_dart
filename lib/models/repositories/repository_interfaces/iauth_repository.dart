interface class IAuthRepository {
  Future<dynamic> getUserByEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
