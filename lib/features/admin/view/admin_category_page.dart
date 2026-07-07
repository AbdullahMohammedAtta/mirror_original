import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';

class AdminCategoryPage extends StatelessWidget {
  AdminCategoryPage({super.key, required this.adminCubit});
  final AdminCubit adminCubit;
  var formKey = GlobalKey<FormState>();
  var categoryNameController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: BlocBuilder<AdminCubit, AdminStates>(
                  bloc: adminCubit,
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          GestureDetector(
                            onTap: () {
                              adminCubit.pickCategoryImage();
                            },
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: adminCubit.categoryImage == null
                                  ? const Icon(
                                Icons.add_a_photo,
                                size: 45,
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  adminCubit.categoryImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextFormField(
                            controller: categoryNameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Enter category name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Category Name",
                              prefixIcon: Icon(Icons.category),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () async {

                                if (!formKey.currentState!.validate()) return;

                                if (adminCubit.categoryImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please select image"),
                                    ),
                                  );
                                  return;
                                }

                                await adminCubit.addCategory(
                                  name: categoryNameController.text.trim(),
                                );

                                categoryNameController.clear();

                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add Category"),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Category"),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height*0.9,
        child: ListView.separated(
            separatorBuilder: (context, index) => myDivider(),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                          child: Image.network(adminCubit.categories[index].image,fit: BoxFit.cover,)),
                      SizedBox(width: 20,),
                      Text(adminCubit.categories[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                          Spacer(),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: adminCubit.categories.length,
        ),
      ),
    );
  }
}
