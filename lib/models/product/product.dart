import 'cart_summaries.dart';
import 'category.dart';
import 'inventory.dart';
import 'offers.dart';
import 'price.dart';
import 'storage.dart';

class Product {
  final String? name;
  final int? id;
  final String? nameArabic;
  final int? categoryId;
  final dynamic brandId;
  final String? rating;
  final int? isInWishListCount;
  final int? ratingsCount;
  final int? sortPrice;
  final Category? category;
  final Offers? offers;
  final CartSummaries? cartSummaries;
  final Price? price;
  final Inventory? inventory;
  final List<dynamic>? images;
  final List<dynamic>? tags;
  final Storage? storage;

  const Product({
    this.name,
    this.id,
    this.nameArabic,
    this.categoryId,
    this.brandId,
    this.rating,
    this.isInWishListCount,
    this.ratingsCount,
    this.sortPrice,
    this.category,
    this.offers,
    this.cartSummaries,
    this.price,
    this.inventory,
    this.images,
    this.tags,
    this.storage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] as String?,
        id: json['id'] as int?,
        nameArabic: json['name_arabic'] as String?,
        categoryId: json['category_id'] as int?,
        brandId: json['brand_id'] as dynamic,
        rating: json['rating'] as String?,
        isInWishListCount: json['is_in_wish_list_count'] as int?,
        ratingsCount: json['ratings_count'] as int?,
        sortPrice: json['sort_price'] as int?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        offers: json['offers'] == null
            ? null
            : Offers.fromJson(json['offers'] as Map<String, dynamic>),
        cartSummaries: json['cart_summaries'] == null
            ? null
            : CartSummaries.fromJson(
                json['cart_summaries'] as Map<String, dynamic>),
        price: json['price'] == null
            ? null
            : Price.fromJson(json['price'] as Map<String, dynamic>),
        inventory: json['inventory'] == null
            ? null
            : Inventory.fromJson(json['inventory'] as Map<String, dynamic>),
        images: json['images'] as List<dynamic>?,
        tags: json['tags'] as List<dynamic>?,
        storage: json['storage'] == null
            ? null
            : Storage.fromJson(json['storage'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'name_arabic': nameArabic,
        'category_id': categoryId,
        'brand_id': brandId,
        'rating': rating,
        'is_in_wish_list_count': isInWishListCount,
        'ratings_count': ratingsCount,
        'sort_price': sortPrice,
        'category': category?.toJson(),
        'offers': offers?.toJson(),
        'cart_summaries': cartSummaries?.toJson(),
        'price': price?.toJson(),
        'inventory': inventory?.toJson(),
        'images': images,
        'tags': tags,
        'storage': storage?.toJson(),
      };
}
