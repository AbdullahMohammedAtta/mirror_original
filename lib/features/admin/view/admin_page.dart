import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/core/widgets/myButton.dart';
import 'package:mirror_original/features/admin/view/admin_category_page.dart';
import 'package:mirror_original/features/admin/view/admin_products_page.dart';
import 'package:mirror_original/features/admin/view/users_page.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';
import 'package:mirror_original/features/home/view/home_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdminCubit()..getProducts()..getUsers()..getCategories(),
      child: BlocConsumer<AdminCubit,AdminStates>(
          listener: (context, state) {},
          builder: (context, state) {
              var adminCubit = AdminCubit.get(context);
            return Scaffold(
              backgroundColor: const Color(0xffF5F7FA),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Admin Dashboard",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Manage your store efficiently",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        decoration: InputDecoration(
                          hintText: "Search products...",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      myButton('Go to store',context,HomePage()),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          ConditionalBuilder(
                            condition: state is! GetProductsLoadingState,
                            fallback: (context) => Center(child: CircularProgressIndicator(),),
                            builder: (context) {
                              return DashboardCard(
                                title: "Products",
                                value: '${adminCubit.products.length}',
                                icon: Icons.shopping_bag,
                              );
                            },
                          ),

                          DashboardCard(
                            title: "Orders",
                            value: "0",
                            icon: Icons.receipt_long,
                          ),

                          ConditionalBuilder(
                              condition: state is! GetUsersLoadingState,
                             fallback: (context) => Center(child: CircularProgressIndicator(),),
                              builder: (context) {
                                return DashboardCard(
                                  title: "Users",
                                  value: "${adminCubit.users.length}",
                                  icon: Icons.people,
                                );
                              },
                          ),

                          DashboardCard(
                            title: "Revenue",
                            value: "\$0",
                            icon: Icons.attach_money,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: GestureDetector(
                              onTap: ()
                              {
                                navigateTo(context, AdminProductsPage(adminCubit));
                              },
                              child: ActionButton(

                                title: "Products",
                                icon: Icons.shopping_bag,

                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ActionButton(
                              title: "Orders",
                              icon: Icons.receipt,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(context, UsersPage(adminCubit: adminCubit,));
                              },
                              child: ActionButton(
                                title: "Users",
                                icon: Icons.people,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                navigateTo(context, AdminCategoryPage(adminCubit: adminCubit,));
                              },
                              child: ActionButton(
                                title: "Categories",
                                icon: Icons.category,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),



                    ],
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}


class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Icon(
                  icon,
                  size: 35,
                ),

                Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

                Text(title),
              ],
        )
      );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 35,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}