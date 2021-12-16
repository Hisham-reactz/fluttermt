import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://sta.farawlah.sa';

  Future fetchProducts(url) async {
    final prodUrl = '''$baseUrl/api/mobile/products?
        store_id=2
        &limit=20
        &sort_by=sale_price
        &sort_type=DESC
        &$url''';
    final response = await http.get(
      Uri.parse(
        prodUrl.replaceAll(' ', '').replaceAll('\n', ''),
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future fetchCats() async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/mobile/categories',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cats');
    }
  }

  Future fetchsubCats(_selectCat) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/mobile/subcategories?parent_id=$_selectCat',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load sub cats');
    }
  }
}
