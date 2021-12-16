class Tax {
  final int? id;
  final String? name;
  final String? nameArabic;
  final int? rate;
  final int? isPriceInclude;

  const Tax({
    this.id,
    this.name,
    this.nameArabic,
    this.rate,
    this.isPriceInclude,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json['id'] as int?,
        name: json['name'] as String?,
        nameArabic: json['name_arabic'] as String?,
        rate: json['rate'] as int?,
        isPriceInclude: json['IS_price_include'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_arabic': nameArabic,
        'rate': rate,
        'IS_price_include': isPriceInclude,
      };
}
