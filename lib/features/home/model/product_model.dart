class ProductModel {
  final String id;

  // Basic Info
  final String title;
  final String description;
  final String brand;
  final String category;

  // Pricing
  final double price;
  final double? oldPrice;
  final int discount;

  // Images
  final String mainImage;
  final List<String> images;

  // Rating
  final double rating;
  final int reviewsCount;

  // Stock
  final int stock;
  final bool isAvailable;

  // Shoe Details
  final List<int> sizes;
  final List<String> colors;

  // Extra
  final bool isFeatured;
  final bool isFavorite;
  final int soldCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.brand,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.mainImage,
    required this.images,
    required this.rating,
    required this.reviewsCount,
    required this.stock,
    required this.isAvailable,
    required this.sizes,
    required this.colors,
    required this.isFeatured,
    required this.isFavorite,
    required this.soldCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['oldPrice'] != null
          ? (json['oldPrice']).toDouble()
          : null,
      discount: json['discount'] ?? 0,
      mainImage: json['mainImage'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      stock: json['stock'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      sizes: List<int>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      isFeatured: json['isFeatured'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      soldCount: json['soldCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'brand': brand,
      'category': category,
      'price': price,
      'oldPrice': oldPrice,
      'discount': discount,
      'mainImage': mainImage,
      'images': images,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'stock': stock,
      'isAvailable': isAvailable,
      'sizes': sizes,
      'colors': colors,
      'isFeatured': isFeatured,
      'isFavorite': isFavorite,
      'soldCount': soldCount,
    };
  }
}