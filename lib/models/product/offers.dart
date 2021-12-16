import 'price_book.dart';

class Offers {
  final int? productId;
  final int? discount;
  final int? retailprice;
  final int? pricebookId;
  final int? maxUnit;
  final String? discountType;
  final PriceBook? priceBook;

  const Offers({
    this.productId,
    this.discount,
    this.retailprice,
    this.pricebookId,
    this.maxUnit,
    this.discountType,
    this.priceBook,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        productId: json['product_id'] as int?,
        discount: json['discount'] as int?,
        retailprice: json['retailprice'] as int?,
        pricebookId: json['pricebook_id'] as int?,
        maxUnit: json['max_unit'] as int?,
        discountType: json['discount_type'] as String?,
        priceBook: json['price_book'] == null
            ? null
            : PriceBook.fromJson(json['price_book'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'discount': discount,
        'retailprice': retailprice,
        'pricebook_id': pricebookId,
        'max_unit': maxUnit,
        'discount_type': discountType,
        'price_book': priceBook?.toJson(),
      };
}
