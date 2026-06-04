import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,size: 200,),
          const SizedBox(height: 10),
          const Text('   Your cart is empty now\nThank you for choosing us!',style: TextStyle(fontSize: 16),),
          const SizedBox(height: 15,),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.black,
            ),
            child: MaterialButton(
              onPressed: (){

              },
              child: const Text(
                'Shop Now',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
