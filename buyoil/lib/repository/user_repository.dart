import '../api/user_api.dart';
import '../model/user_request.dart';

class UserRepository {
  final UserApi api;

  UserRepository(this.api);

  Future<void> createUser(UserRequest request) async {
    await api.createUser(request.toJson());
  }
}
