import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel6/modules/users_table/presentation/controllers/user_controller.dart';
import 'package:pixel6/modules/users_table/presentation/widgets/app_bar.dart';

class UsersScreen extends GetView<UserController> {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: const CustomAppBar(),
      body: Obx(
        () => controller.currentUsers.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Employees',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: controller.tableHeight.value,
                        maxHeight: controller.tableHeight.value,
                      ),
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: [
                          SliverToBoxAdapter(
                            child: DataTable(
                              sortColumnIndex: controller.sortColumnIndex.value,
                              sortAscending: controller.sort.value,
                              headingRowColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.tertiary,
                              ),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Id',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  numeric: true,
                                  onSort: (columnIndex, ascending) {
                                    controller.sort.value = ascending;
                                    controller.sortColumnIndex.value =
                                        columnIndex;
                                    controller.currentUsers.sort((a, b) =>
                                        ascending
                                            ? a.id!.compareTo(b.id!)
                                            : b.id!.compareTo(a.id!));
                                  },
                                ),
                                DataColumn(
                                    label: Text(
                                  'Image',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                )),
                                DataColumn(
                                  label: Text(
                                    'Full Name',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  onSort: (columnIndex, ascending) {
                                    controller.sort.value = ascending;
                                    controller.sortColumnIndex.value =
                                        columnIndex;
                                    controller.currentUsers.sort((a, b) {
                                      final aFullName =
                                          '${a.firstName} ${a.lastName}';
                                      final bFullName =
                                          '${b.firstName} ${b.lastName}';
                                      return ascending
                                          ? aFullName.compareTo(bFullName)
                                          : bFullName.compareTo(aFullName);
                                    });
                                  },
                                ),
                                DataColumn(
                                    label: Text(
                                      'Demography',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      controller.sort.value = ascending;
                                      controller.sortColumnIndex.value =
                                          columnIndex;
                                      controller.currentUsers.sort(
                                        (a, b) {
                                          return ascending
                                              ? a.age!.compareTo(b.age!)
                                              : b.age!.compareTo(a.age!);
                                        },
                                      );
                                    }),
                                DataColumn(
                                    label: Text(
                                  'Department',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                )),
                              ],
                              rows: controller.currentUsers.map((user) {
                                return DataRow(cells: [
                                  DataCell(Text(
                                    '${user.id}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )),
                                  DataCell(Image.network(
                                    '${user.image}',
                                    fit: BoxFit.contain,
                                    height: 50,
                                    width: 50,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return child;
                                    },
                                  )),
                                  DataCell(Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )),
                                  DataCell(Text(
                                    '${user.gender == 'male' ? 'M' : 'F'}/${user.age}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )),
                                  DataCell(Text(
                                    '${user.company?.department}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )),
                                  DataCell(Text(
                                    '${user.address?.state}, ${user.address?.country}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )),
                                ]);
                              }).toList(),
                            ),
                          ),
                          if (controller.isLoading.value)
                            SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
