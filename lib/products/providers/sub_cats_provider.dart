import 'package:fluttermt/api.dart';
import 'package:fluttermt/models/product/category.dart';
import 'package:riverpod/riverpod.dart';

/// An object that controls a list of [Category].
class SubcatList extends StateNotifier<List<dynamic>> {
  SubcatList([List<dynamic>? initialsubCats]) : super(initialsubCats ?? []);

  final _apiservice = ApiService();
  bool subcatLoading = true;
  int? selectsubCat;

  void getsubCats(int cat) async {
    await _apiservice.fetchsubCats(cat).then((data) {
      state = data;
      subcatLoading = false;
    });
  }

  //set sub category action
  void setsubCat(int subcat) async {
    selectsubCat = subcat;
  }
}
