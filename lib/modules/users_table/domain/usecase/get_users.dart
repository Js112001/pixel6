import 'dart:developer';

import 'package:pixel6/core/usecase/usecase.dart';
import 'package:pixel6/modules/users_table/data/model/user_model.dart';
import 'package:pixel6/modules/users_table/domain/repository/users_repository.dart';

class GetUsersUseCase extends UseCase<List<User>?, int?> {
  final UsersRepository _usersRepository;

  GetUsersUseCase(this._usersRepository);

  @override
  Future<List<User>?> call({int? params}) {
    log('IN USECASE');
    return _usersRepository.getUser(skip: params);
  }
}