import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel6/modules/users_table/presentation/controllers/user_controller.dart';

class CustomAppBar extends GetView<UserController>
    implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      titleSpacing: 5,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Obx(
                () => DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(10),
                  value: controller.countryValue.value,
                  isExpanded: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  items: controller.countryList.map(
                    (value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.countryValue.value = value.toString();
                  },
                ),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Obx(
                () => DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: false,
                  value: controller.genderValue.value,
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  items: controller.genderList.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.genderValue.value = value.toString();
                    controller.currentUsers.value = controller.users.where(
                      (user) {
                        return user.gender == value.toString().toLowerCase();
                      },
                    ).toList();
                  },
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: () {
                  controller.currentUsers.value = controller.users;
                  controller.genderValue.value = 'Male';
                  controller.countryValue.value = 'United States';
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);
}
