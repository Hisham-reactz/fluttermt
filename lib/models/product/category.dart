class Category {
  final int? id;
  final int? parentId;
  final dynamic offers;

  const Category({this.id, this.parentId, this.offers});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        parentId: json['parent_id'] as int?,
        offers: json['offers'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'offers': offers,
      };
}
