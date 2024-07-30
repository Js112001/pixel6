import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

abstract class UsersApiService {
  Future<Response<dynamic>?> fetchUsers({int? skip});
}

class UsersApiServiceImpl extends UsersApiService {
  @override
  Future<Response<dynamic>?> fetchUsers({int? skip}) async {
    try {
      final dio = Get.find<Dio>();
      final response = await dio.get(
        'https://dummyjson.com/users',
        queryParameters: {'limit': 20, 'skip': skip},
      );
      return response;
    } catch (e) {
      log('Error in fetching users: $e');
      return null;
    }
  }
}
