
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/view/profuct_details.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

Widget buildSearchItem(HomeCubit homeCubit)
{
  return ListView.separated(
    shrinkWrap:true,
    physics: NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) => myDivider(),
    itemBuilder: (context, index) {
      final product = homeCubit.searchProducts[index];

      return InkWell(
        onTap:(){
          navigateTo(context, ProductDetailPage(product));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.network(product.mainImage,fit: BoxFit.cover,)
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.categoryId,style: TextStyle(),),
                    Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(product.brand,style: TextStyle(color: Color.fromRGBO(
                        90, 90, 90, 1.0),fontSize: 15,),),
                    Text(product.price.toString(),style: TextStyle(color: Color.fromRGBO(208, 30, 30, 1.0),fontSize: 15,),),
                  ],
                ),
                Spacer(),
                Icon(CupertinoIcons.right_chevron,)
              ],
            ),
          ),
        ),
      );
    },
    itemCount: homeCubit.searchProducts.length,
  );
}