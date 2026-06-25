import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';

class AdminCategoryPage extends StatelessWidget {
  const AdminCategoryPage({super.key, required this.adminCubit});
  final AdminCubit adminCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
        centerTitle: true,
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
