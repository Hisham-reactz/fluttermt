class Inventory {
  final int? id;
  final int? productId;
  final int? criticalPoint;
  final int? isSalableNstocks;

  const Inventory({
    this.id,
    this.productId,
    this.criticalPoint,
    this.isSalableNstocks,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json['id'] as int?,
        productId: json['product_id'] as int?,
        criticalPoint: json['critical_point'] as int?,
        isSalableNstocks: json['Is_salable_nstocks'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'critical_point': criticalPoint,
        'Is_salable_nstocks': isSalableNstocks,
      };
}
