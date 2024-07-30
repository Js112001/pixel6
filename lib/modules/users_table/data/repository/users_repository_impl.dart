import 'package:pixel6/modules/users_table/data/data_sources/remote/users_api_service.dart';
import 'package:pixel6/modules/users_table/data/model/user_model.dart';
import 'package:pixel6/modules/users_table/domain/repository/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersApiService _usersApiService;

  UsersRepositoryImpl(this._usersApiService);

  @override
  Future<List<User>?> getUser({int? skip}) async {
    final response = await _usersApiService.fetchUsers(skip: skip ?? 0);
    final data = response?.data['users'] as List<dynamic>?;

    if (data == null) {
      return null;
    } else {
      List<User> users = [];
      users.addAll(data.map((user) => User.fromJson(user)).toList());
      return users;
    }
  }
}
