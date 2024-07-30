import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pixel6/modules/users_table/data/data_sources/remote/users_api_service.dart';
import 'package:pixel6/modules/users_table/data/repository/users_repository_impl.dart';
import 'package:pixel6/modules/users_table/domain/repository/users_repository.dart';
import 'package:pixel6/modules/users_table/domain/usecase/get_users.dart';
import 'package:pixel6/modules/users_table/presentation/controllers/user_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(
      () => Dio(),
    );
    Get.lazyPut<UsersApiService>(
      () => UsersApiServiceImpl(),
    );
    Get.lazyPut<UsersRepository>(
      () => UsersRepositoryImpl(
        Get.find<UsersApiService>(),
      ),
    );
    Get.lazyPut<GetUsersUseCase>(
      () => GetUsersUseCase(
        Get.find<UsersRepository>(),
      ),
    );
    Get.lazyPut<UserController>(
      () => UserController(
        Get.find<GetUsersUseCase>(),
      ),
    );
  }
}
