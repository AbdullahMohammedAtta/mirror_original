import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Row(
          children: [
            Text('WishList',),
            SizedBox(width: 5,),
            Icon(Icons.list_alt_outlined),
          ],
        ),
      ),
      body:   const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.favorite_border_rounded,size: 250,weight: 0.3,),
              ],
            ),
            Text(
              'No products in the wishlist !',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
