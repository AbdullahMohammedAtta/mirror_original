import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final brandController = TextEditingController();

  final categoryController = TextEditingController();

  final priceController = TextEditingController();

  final oldPriceController = TextEditingController();

  final discountController = TextEditingController();

  final mainImageController = TextEditingController();

  final stockController = TextEditingController();

  final sizesController = TextEditingController();

  final colorsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              buildField(
                titleController,
                "Title",
              ),

              buildField(
                descriptionController,
                "Description",
                maxLines: 3,
              ),

              buildField(
                brandController,
                "Brand",
              ),

              buildField(
                categoryController,
                "Category",
              ),

              buildField(
                priceController,
                "Price",
                type: TextInputType.number,
              ),

              buildField(
                oldPriceController,
                "Old Price",
                type: TextInputType.number,
              ),

              buildField(
                discountController,
                "Discount %",
                type: TextInputType.number,
              ),

              buildField(
                stockController,
                "Stock",
                type: TextInputType.number,
              ),

              buildField(
                mainImageController,
                "Main Image URL",
              ),

              buildField(
                sizesController,
                "Sizes (40,41,42)",
              ),

              buildField(
                colorsController,
                "Colors (Black,White)",
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()
                  {

                    // FirebaseFirestore.instance
                    //     .collection('products')
                    //     .add(product.toJson());

                  },
                  child: const Text(
                    "Save Product",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
        TextInputType type = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}