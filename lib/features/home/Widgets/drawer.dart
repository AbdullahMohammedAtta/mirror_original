import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/admin/view/admin_page.dart';
import 'package:mirror_original/features/auth/view_model/auth_cubit.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';

import '../../../core/utils/functions.dart';
import '../../auth/view/login_page.dart';

Widget buildDrawer(BuildContext context) {
  return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var authCubit= AuthCubit.get(context);
        return Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Image.asset('assets/img/LOGO.png'),
                const SizedBox(height: 20),
                const Text(
                  'ABU MOUSA',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(width: 80, height: 2, color: Colors.black),
                const Spacer(),
                if(authCubit.userModel!.isAdmin)
                  TextButton.icon(
                    onPressed: () {
                      navigateTo(context, AdminPage());
                    },
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Text('Admin Dashboard'),
                  ),
                ConditionalBuilder(
                  condition: FirebaseAuth.instance.currentUser != null,
                  fallback: (context) {
                    return TextButton.icon(
                      onPressed: () {
                        AlertDialog(
                          title: const Text(
                            'Do you want to Logout',
                          ),
                          content: const Text(
                            'Are you sure?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                authCubit.logout();
                                navigateAndFinish(context, LoginPage());
                              },
                              child: const Text(
                                'Logout',
                              ),
                            ),
                          ],
                        );
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Logout'),
                    );
                  },
                  builder: (context) {
                    return TextButton.icon(
                      onPressed: () {
                        navigateTo(context, LoginPage());
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
  );
}
