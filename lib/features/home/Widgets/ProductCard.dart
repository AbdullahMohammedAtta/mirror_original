import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

Widget buildProductCard(ProductModel product,context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade200,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (product.discount > 0)
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
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
                ),
              Spacer(),
              IconButton(onPressed: (){}, icon:  Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: product.isFavorite ? Colors.red : Colors.black,
                size: 20,
              ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height*0.12,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(20),
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
              if (!product.isAvailable)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(99, 96, 96, 0.49411764705882355),
                      borderRadius: BorderRadius.circular(20),
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
            ],
          ),


          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                product.brand,
                style: const TextStyle(color: Color.fromRGBO(99, 96, 96, 0.49411764705882355), fontSize: 16),
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

          const SizedBox(height: 4),

          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 6),
              if (product.oldPrice != null)
                Text(
                  '\$${product.oldPrice}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 13,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 5),

          Row(
            children: product.colors.take(3).map((color) {
              return Container(
                margin: const EdgeInsets.only(right: 6),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color.toLowerCase() == 'black'
                      ? Colors.black
                      : color.toLowerCase() == 'white'
                      ? Colors.white
                      : color.toLowerCase() == 'blue'
                      ? Colors.blue
                      : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
