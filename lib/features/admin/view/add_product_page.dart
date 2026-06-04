import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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

  File? mainImage;
  List<File> galleryImages = [];

  bool isLoading = false;

  Future<void> pickMainImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        mainImage = File(image.path);
      });
    }
  }

  Future<void> pickGalleryImages() async {
    final picker = ImagePicker();

    final images = await picker.pickMultiImage(
      imageQuality: 85,
    );

    if (images.isNotEmpty) {
      setState(() {
        galleryImages.addAll(
          images.map((e) => File(e.path)),
        );
      });
    }
  }

  Future<void> saveProduct() async {
    if (!formKey.currentState!.validate()) return;

    if (mainImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select main image"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      /// Upload Main Image
      /// final mainImageUrl = await uploadImage(mainImage!);

      /// Upload Gallery Images
      /// List<String> galleryUrls = [];

      /// for (var image in galleryImages) {
      ///   galleryUrls.add(await uploadImage(image));
      /// }

      /// Save To Firestore

      await Future.delayed(
        const Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product Added Successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              buildImagesSection(),

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
                  buildField(
                    categoryController,
                    "Category",
                  ),
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
                  onPressed: isLoading
                      ? null
                      : saveProduct,
                  icon: isLoading
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
                    isLoading
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
  }

  Widget buildImagesSection() {
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
              onTap: pickMainImage,
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
                child: mainImage == null
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
                    mainImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: pickGalleryImages,
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
              itemCount: galleryImages.length,
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
                        galleryImages[index],
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
                          setState(() {
                            galleryImages
                                .removeAt(index);
                          });
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.all(
                              4),
                          decoration:
                          const BoxDecoration(
                            color: Colors.red,
                            shape:
                            BoxShape.circle,
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