import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';

class AdminCategoryPage extends StatelessWidget {
  AdminCategoryPage({super.key, required this.adminCubit});
  final AdminCubit adminCubit;
  var formKey = GlobalKey<FormState>();


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
          // scaffoldKey.currentState!.showBottomSheet((context) =>
          //     Container(
          //       color: Colors.grey[100],
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Form(
          //           key: formKey,
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               TextFormField(),
          //               TextFormField(),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   elevation: 20,
          // );
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Pick Image
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // child: adminCubit.categoryImage == null
                          //     ? const Icon(
                          //   Icons.add_a_photo,
                          //   size: 40,
                          // )
                          //     : ClipRRect(
                           // borderRadius: BorderRadius.circular(15),
                            // child: Image.file(
                            //  // adminCubit.categories[index].image,
                            //   fit: BoxFit.cover,
                            // ),
                          //),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          //controller: categoryNameController,
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                            prefixIcon: Icon(Icons.category),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter category name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Upload Image
                            // Save Category
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Category'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Category'),
      ),
      body: ListView.separated(
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
    );
  }
}
