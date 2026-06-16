import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/admin_cubit.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key, required this.adminCubit});
  final AdminCubit adminCubit;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: adminCubit.users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final user = adminCubit.users[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: user.image.isNotEmpty
                    ? NetworkImage(user.image)
                    : null,
                child: user.image.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(user.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user.email),
                  Text(user.phone),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: user.isAdmin
                      ? Colors.green
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  user.isAdmin ? 'Admin' : 'User',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}