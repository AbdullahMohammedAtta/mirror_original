import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var adminCubit = AdminCubit.get(context);

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
                            adminCubit.deleteProduct(adminCubit.products[index].id);
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
        },
    );
  }
}
