class CartSummaries {
  final int? quantity;

  const CartSummaries({this.quantity});

  factory CartSummaries.fromJson(Map<String, dynamic> json) => CartSummaries(
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
      };
}
