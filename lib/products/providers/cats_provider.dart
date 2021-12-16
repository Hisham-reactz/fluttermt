import 'package:fluttermt/api.dart';
import 'package:fluttermt/models/product/category.dart';
import 'package:riverpod/riverpod.dart';

/// An object that controls a list of [Category].
class CatList extends StateNotifier<List<dynamic>> {
  CatList([List<dynamic>? initialCats]) : super(initialCats ?? []);

  final _apiservice = ApiService();
  bool catLoading = true;
  int? selectCat;

  void getCats() async {
    await _apiservice.fetchCats().then((data) {
      state = data;
      catLoading = false;
    });
  }

  //set category action
  void setCat(int cat) async {
    selectCat = cat;
  }
}
