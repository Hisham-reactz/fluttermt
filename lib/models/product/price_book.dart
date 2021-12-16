class PriceBook {
  final int? id;
  final String? name;
  final String? nameArabic;
  final dynamic description;
  final dynamic descriptionArabic;
  final int? isActive;
  final String? validFrom;
  final String? validTo;
  final String? file;
  final int? isAvailableOfflineCustomer;
  final String? discountType;
  final String? type;
  final int? createdBy;
  final int? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  const PriceBook({
    this.id,
    this.name,
    this.nameArabic,
    this.description,
    this.descriptionArabic,
    this.isActive,
    this.validFrom,
    this.validTo,
    this.file,
    this.isAvailableOfflineCustomer,
    this.discountType,
    this.type,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PriceBook.fromJson(Map<String, dynamic> json) => PriceBook(
        id: json['id'] as int?,
        name: json['name'] as String?,
        nameArabic: json['name_arabic'] as String?,
        description: json['description'] as dynamic,
        descriptionArabic: json['description_arabic'] as dynamic,
        isActive: json['IS_active'] as int?,
        validFrom: json['valid_from'] as String?,
        validTo: json['valid_to'] as String?,
        file: json['file'] as String?,
        isAvailableOfflineCustomer:
            json['IS_available_offline_customer'] as int?,
        discountType: json['discount_type'] as String?,
        type: json['type'] as String?,
        createdBy: json['created_by'] as int?,
        updatedBy: json['updated_by'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_arabic': nameArabic,
        'description': description,
        'description_arabic': descriptionArabic,
        'IS_active': isActive,
        'valid_from': validFrom,
        'valid_to': validTo,
        'file': file,
        'IS_available_offline_customer': isAvailableOfflineCustomer,
        'discount_type': discountType,
        'type': type,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };
}
