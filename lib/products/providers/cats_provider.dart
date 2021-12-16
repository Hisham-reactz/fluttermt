import 'package:fluttermt/api.dart';
import 'package:riverpod/riverpod.dart';

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
