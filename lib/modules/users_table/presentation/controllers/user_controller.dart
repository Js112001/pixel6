import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel6/modules/users_table/data/model/user_model.dart';
import 'package:pixel6/modules/users_table/domain/usecase/get_users.dart';

class UserController extends GetxController {
  final GetUsersUseCase getUsersUseCase;

  UserController(this.getUsersUseCase);

  RxList<User> users = RxList<User>();
  ScrollController scrollController = ScrollController();
  var sort = true.obs;
  var isLoading = true.obs;
  var sortColumnIndex = 0.obs;
  var currentUsers = <User>[].obs;
  final genderList = const ['Male', 'Female'];
  final countryList = const ['United States', 'INDIA'];
  var genderValue = 'Male'.obs;
  var countryValue = 'United States'.obs;
  var rowHeight = 50.0;
  var tableHeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    tableHeight.value = rowHeight * (currentUsers.length + 1);
    scrollController.addListener(_onScroll);
  }

  void fetchUsers({int? skip=0}) async {
    try {
      isLoading.value = true;
      List<User> fetchedUsers = await getUsersUseCase(params: skip) ?? [];
      users.addAll(fetchedUsers);
      currentUsers.value = users;
      tableHeight.value = rowHeight * (currentUsers.length + 1);
      currentUsers.refresh();
      users.refresh();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _onScroll() async {
    if (scrollController.position.extentAfter < 700 && !isLoading.value) {
      fetchUsers(skip: users.length);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

