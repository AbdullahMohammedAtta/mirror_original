import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage(AdminCubit this.adminCubit,{super.key});

  final AdminCubit adminCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: adminCubit.products.length,
          separatorBuilder: (context, index) => myDivider(),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
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
                      "${adminCubit.products[index].mainImage}",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${adminCubit.products[index].title}",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text("${adminCubit.products[index].price}"),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.edit),
                  ),

                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Delete Product',
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
                                  adminCubit.deleteProduct(adminCubit.products[index].id);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
