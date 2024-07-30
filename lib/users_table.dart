import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixel6/user.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  final ScrollController _scrollController = ScrollController();
  bool sort = true;
  bool isLoading = true;
  int sortColumnIndex = 0;
  List<User> users = [];
  List<User> currentUsers = [];
  final genderList = const [
    'Male',
    'Female',
  ];
  final countryList = const ['United States', 'INDIA'];
  var genderValue = 'Male';
  var countryValue = 'United States';

  Future<void> fetchUsers({int? skip = 0}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await Dio().get(
        'https://dummyjson.com/users',
        queryParameters: {'limit': 20, 'skip': skip},
      );
      final data = response.data['users'] as List<dynamic>;

      setState(() {
        users.addAll(data.map((user) => User.fromJson(user)).toList());
        debugPrint('data ${users.first.id}');
        currentUsers = users;
        isLoading = false;
      });
      debugPrint('CURRENT USERS:: ${currentUsers.length}');
    } catch (e) {
      // Handle errors here
      debugPrint('Error fetching users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    genderValue = genderList.first;
    countryValue = countryList.first;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 500 && !isLoading) {
      fetchUsers(skip: currentUsers.length);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const rowHeight = 50.0;
    var tableHeight = rowHeight * (currentUsers.length + 1);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // const Text('User Table'),
            Flexible(
              child: DropdownButton(
                isExpanded: true,
                value: countryValue,
                items: countryList.map(
                  (value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    countryValue = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: DropdownButton(
                isExpanded: true,
                value: genderValue,
                items: genderList.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    genderValue = value!;
                    currentUsers = users.where(
                      (user) {
                        return user.gender == value.toLowerCase();
                      },
                    ).toList();
                  });
                },
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    currentUsers = users;
                  });
                },
                icon: const Icon(Icons.restart_alt),
              ),
            ),
          ],
        ),
      ),
      body: currentUsers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: tableHeight,
                  maxHeight: tableHeight,
                ),
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    SliverToBoxAdapter(
                      child: DataTable(
                        sortColumnIndex: sortColumnIndex,
                        sortAscending: sort,
                        columns: [
                          DataColumn(
                            label: const Text('Id'),
                            numeric: true,
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                sort = ascending;
                                sortColumnIndex = columnIndex;
                                currentUsers.sort((a, b) => ascending
                                    ? a.id!.compareTo(b.id!)
                                    : b.id!.compareTo(a.id!));
                              });
                            },
                          ),
                          const DataColumn(label: Text('Image')),
                          DataColumn(
                            label: const Text('Full Name'),
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                sort = ascending;
                                sortColumnIndex = columnIndex;
                                currentUsers.sort((a, b) {
                                  final aFullName =
                                      '${a.firstName} ${a.lastName}';
                                  final bFullName =
                                      '${b.firstName} ${b.lastName}';
                                  return ascending
                                      ? aFullName.compareTo(bFullName)
                                      : bFullName.compareTo(aFullName);
                                });
                              });
                            },
                          ),
                          DataColumn(
                              label: const Text('Demography'),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = ascending;
                                  sortColumnIndex = columnIndex;
                                  currentUsers.sort((a, b) {
                                    return ascending
                                        ? a.age!.compareTo(b.age!)
                                        : b.age!.compareTo(a.age!);
                                  });
                                });
                              }),
                          const DataColumn(label: Text('Department')),
                          const DataColumn(label: Text('Location')),
                        ],
                        rows: currentUsers.map((user) {
                          return DataRow(cells: [
                            DataCell(Text('${user.id}')),
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
                            DataCell(
                                Text('${user.firstName} ${user.lastName}')),
                            DataCell(Text(
                                '${user.gender == 'male' ? 'M' : 'F'}/${user.age}')),
                            DataCell(Text('${user.company?.department}')),
                            DataCell(Text(
                                '${user.address?.state}, ${user.address?.country}')),
                          ]);
                        }).toList(),
                      ),
                    ),
                    if (isLoading)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
