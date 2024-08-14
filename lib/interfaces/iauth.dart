interface class IAuthRepository {
  Future<bool> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }
}
