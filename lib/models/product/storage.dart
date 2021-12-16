import 'product.dart';

class Storage {
  final int? id;
  final int? productId;
  final int? quantityOnhand;
  final int? quantityReserved;
  final Product? product;

  const Storage({
    this.id,
    this.productId,
    this.quantityOnhand,
    this.quantityReserved,
    this.product,
  });

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
        id: json['id'] as int?,
        productId: json['product_id'] as int?,
        quantityOnhand: json['quantity_onhand'] as int?,
        quantityReserved: json['quantity_reserved'] as int?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'quantity_onhand': quantityOnhand,
        'quantity_reserved': quantityReserved,
        'product': product?.toJson(),
      };
}
