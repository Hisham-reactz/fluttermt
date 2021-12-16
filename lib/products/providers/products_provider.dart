import 'package:fluttermt/api.dart';
import 'package:fluttermt/models/product/product.dart';
import 'package:riverpod/riverpod.dart';

/// An object that controls a list of [Product].
class ProductList extends StateNotifier<List<dynamic>> {
  ProductList([List<dynamic>? initialTasks]) : super(initialTasks ?? []);

  final _apiservice = ApiService();
  int page = 0;
  bool productLoading = true;

  void filterCat(int id) async {
    state = state.where((prod) => prod.category!.parentId == id).toList();
  }

  void filtersubCat(int id) async {
    state = state.where((prod) => prod.categoryId == id).toList();
  }

  //fetch product
  void fetchProducts(int? cat, int? subcat) async {
    await _apiservice.fetchProducts(_getUrlparams(cat, subcat)).then(
      (data) {
        state = data;
        productLoading = false;
      },
    ).onError(
      (error, stackTrace) {
        state = [];
        productLoading = false;
      },
    );
  }

  //scroll pagination
  void nextPage(bool top, int? cat, int? subcat) async {
    if (top && page > 0 || !top) {
      top ? page-- : page++;
      productLoading = true;

      fetchProducts(cat, subcat);
    }
  }

  //url set
  String _getUrlparams(int? cat, int? subcat) {
    String urlParams = '''offset=$page
        ${cat != null ? '&parent_category_id=' : ''}
        ${cat ?? ''}
        ${subcat != null ? '&category_id=' : ''}
        ${subcat ?? ''}''';
    return urlParams.replaceAll(' ', '').replaceAll('\n', '');
  }
}
