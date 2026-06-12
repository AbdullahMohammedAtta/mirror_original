import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/auth/view/login_page.dart';
import 'package:mirror_original/features/auth/view_model/auth_cubit.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState)
          {
            navigateAndFinish(context, LoginPage(),);
            showToast(message: 'Logout successfully', state: ToastState.success);
          }
        },
        builder: (context, state) {
          var authCubit = AuthCubit.get(context);
          return Container(
            color: const Color(0xFFF8F9FB), // Light off-white background
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Picture & Edit Badge
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage('https://www.acres4dogs.co.uk/wp-content/uploads/2024/12/Doggy-Day-Care-Right-for-Your-Pupp.webp')
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Name and Email
                    const Text(
                      'Abu Mousa',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D1B2A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'abumousa.style@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    // Stats Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard('12', 'Orders'),
                          const SizedBox(width: 12),
                          _buildStatCard('4', 'Saved'),
                          const SizedBox(width: 12),
                          _buildStatCard('2.4k', 'Points'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Menu Items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          _buildMenuItem(Icons.shopping_bag_outlined, 'My Orders'),
                          _buildMenuItem(Icons.location_on_outlined, 'My Addresses'),
                          _buildMenuItem(Icons.credit_card_outlined, 'Payment Methods'),
                          _buildMenuItem(Icons.settings_outlined, 'Settings'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
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
                                    },
                                    child: const Text(
                                      'Logout',
                                    ),
                                  ),
                                ],
                              ),
                          );

                        },
                        icon: const Icon(Icons.logout, color: Color(0xFFD32F2F)),
                        label: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFFD32F2F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD32F2F), width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Version Text
                    const Text(
                      'Version 1.0.0 (2026)',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }

  // Helper Widget for Stats (Orders, Saved, Points)
  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5FB), // Soft grey-blue
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Menu List Tiles
  Widget _buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9), // Very light teal/green
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF00695C), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0D1B2A),
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}