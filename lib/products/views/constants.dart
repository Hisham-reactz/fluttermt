import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermt/products/providers/cats_provider.dart';
import 'package:fluttermt/products/providers/products_provider.dart';
import 'package:fluttermt/products/providers/sub_cats_provider.dart';

class Contstants {
  final productListProvider =
      StateNotifierProvider<ProductList, List<dynamic>>((ref) {
    return ProductList([]);
  });

  final subcatListProvider =
      StateNotifierProvider<SubcatList, List<dynamic>>((ref) {
    return SubcatList([]);
  });

  final catListProvider = StateNotifierProvider<CatList, List<dynamic>>((ref) {
    return CatList([]);
  });
}
