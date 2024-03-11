abstract class ProfileRepo {
  Future<void> updateUserData(
      {required String email,
      required String name,
      required String num,
      required String role});
}
