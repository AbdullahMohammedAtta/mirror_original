import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/admin/view_model/admin_cubit.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';
import 'package:mirror_original/features/home/model/product_model.dart';



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
  final stockController = TextEditingController();
  final sizesController = TextEditingController();
  final colorsController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state) {
          if (state is AdminAddProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Added Successfully'),
              ),
            );
          }

          if (state is AdminAddProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

      },
      builder: (context, state) {
        var adminCubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Product"),
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildImagesSection(adminCubit),

                  const SizedBox(height: 20),

                  buildSectionCard(
                    title: "Product Information",
                    children: [
                      buildField(
                        titleController,
                        "Title",
                      ),
                      buildField(
                        descriptionController,
                        "Description",
                        maxLines: 4,
                      ),
                      buildField(
                        brandController,
                        "Brand",
                      ),
                      DropdownButtonFormField<String>(
                        value: adminCubit.selectedCategoryId,
                        hint: Text('Select Category'),
                        items: adminCubit.categories.map((category) {
                          return DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          adminCubit.selectedCategoryId = value;
                          adminCubit.changeCategory();
                        },
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  buildSectionCard(
                    title: "Pricing",
                    children: [
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
                    ],
                  ),

                  const SizedBox(height: 16),

                  buildSectionCard(
                    title: "Inventory",
                    children: [
                      buildField(
                        stockController,
                        "Stock",
                        type: TextInputType.number,
                      ),
                      buildField(
                        sizesController,
                        "Sizes (40,41,42)",
                      ),
                      buildField(
                        colorsController,
                        "Colors (Black,White)",
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: state is AdminAddProductLoadingState
                          ? null
                          : (){
                          if(formKey.currentState!.validate())
                            {
                              adminCubit.addProduct(
                                ProductModel(
                                    id: '',
                                    title: titleController.text.trim(),
                                    description: descriptionController.text.trim(),
                                    brand: brandController.text.trim(),
                                    categoryId: adminCubit.selectedCategoryId ?? '',
                                    price: double.tryParse(priceController.text,) ?? 0,
                                    oldPrice: oldPriceController.text.isEmpty ? null : double.tryParse(oldPriceController.text,),
                                    discount: int.tryParse(discountController.text,) ?? 0,
                                    mainImage: '',
                                    images: [],
                                    rating: 0,
                                    reviewsCount: 0,
                                    stock: int.tryParse(stockController.text,) ?? 0,
                                    isAvailable: true,
                                  sizes: sizesController.text
                                      .split(',')
                                      .map((e) => int.tryParse(e.trim()) ?? 0)
                                      .toList(),
                                    colors: colorsController.text
                                        .split(',')
                                        .map((e) => e.trim())
                                        .where((e) => e.isNotEmpty)
                                        .toList(),
                                    isFeatured: false,
                                    isFavorite: false,
                                    soldCount: 0,
                                )
                              );
                            }
                      },
                      icon: state is AdminAddProductLoadingState
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(Icons.save),
                      label: Text(
                        state is AdminAddProductLoadingState
                            ? "Saving..."
                            : "Save Product",
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImagesSection(AdminCubit adminCubit) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Images",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: adminCubit.pickMainImage,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: adminCubit.mainImage == null
                    ? const Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Select Main Image",
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius:
                  BorderRadius.circular(
                      15),
                  child: Image.file(
                    adminCubit.mainImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: adminCubit.pickGalleryImages,
              icon:
              const Icon(Icons.photo_library),
              label: const Text(
                "Add Gallery Images",
              ),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: adminCubit.galleryImages.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                      child: Image.file(
                        adminCubit.galleryImages[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                            adminCubit.removeImageFromGalleryImagesList(index);
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.all(
                              4),
                          decoration:
                          const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
        TextInputType type =
            TextInputType.text,
      }) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        validator: (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return "$hint is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}