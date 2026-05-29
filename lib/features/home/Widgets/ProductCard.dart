import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

import '../../../core/widgets/myDivider.dart';

Widget buildProductCard(ProductModel product,context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade200,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),


      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: product.mainImage.isNotEmpty
                      ? Image.network(product.mainImage,fit: BoxFit.cover,)
                      : const Center(
                    child: Icon(
                      Icons.snowshoeing,
                      size: 70,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            ),
            if (!product.isAvailable)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(170, 170, 170, 0.5),
                  ),
                  child: const Center(
                    child: Text(
                      'OUT OF STOCK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  if (product.discount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 0.5019607843137255),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        '-${product.discount}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(
                        143, 141, 141, 0.5),
                    radius: 15,
                    child:IconButton(onPressed: (){}, icon:  Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : Colors.black,
                      size: 20,
                    ), padding: EdgeInsets.zero,),
                  ),

                ],
              ),
            ),
          ],
        ),

        myDivider(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
          child: Row(
            children: [
              Text(
                product.brand,
                style: const TextStyle(color: Color.fromRGBO(99, 96, 96, 0.5), fontSize: 16),
              ),
              Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviewsCount})',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
          child: Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${product.price} Egp',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 6),
            if (product.oldPrice != null)
              Text(
                '${product.oldPrice}',
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13,
                ),
              ),
          ],
        ),

        Spacer(),

      ],
    ),
  );
}
