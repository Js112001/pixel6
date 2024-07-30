import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel6/modules/users_table/presentation/bindings/users_binding.dart';
import 'package:pixel6/modules/users_table/presentation/views/users_screen.dart';
import 'package:pixel6/user.dart';
import 'package:pixel6/users_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialBinding: UsersBinding(),
      home: const UsersScreen(),
    );
  }
}
