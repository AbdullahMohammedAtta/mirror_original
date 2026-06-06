import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/admin/view/add_product_page.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdminCubit(),
      child: BlocConsumer<AdminCubit,AdminStates>(
          listener: (context, state) {},
          builder: (context, state) {

            return Scaffold(
              backgroundColor: const Color(0xffF5F7FA),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => AdminCubit(),
                        child: AddProductScreen(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
              ),
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

                      const SizedBox(height: 25),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: const [
                          DashboardCard(
                            title: "Products",
                            value: "128",
                            icon: Icons.shopping_bag,
                          ),
                          DashboardCard(
                            title: "Orders",
                            value: "54",
                            icon: Icons.receipt_long,
                          ),
                          DashboardCard(
                            title: "Users",
                            value: "320",
                            icon: Icons.people,
                          ),
                          DashboardCard(
                            title: "Revenue",
                            value: "\$12K",
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
                            child: ActionButton(
                              title: "Products",
                              icon: Icons.shopping_bag,
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
                            child: ActionButton(
                              title: "Users",
                              icon: Icons.people,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ActionButton(
                              title: "Categories",
                              icon: Icons.category,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Recent Products",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [

                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://picsum.photos/200",
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        "Nike Air Max",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(height: 5),

                                      Text("\$180"),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),

                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
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
      ),
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