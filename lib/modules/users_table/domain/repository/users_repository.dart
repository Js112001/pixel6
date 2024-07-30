import 'package:pixel6/modules/users_table/data/model/user_model.dart';

abstract class UsersRepository {
  Future<List<User>?> getUser({int? skip});
}