import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://sta.farawlah.sa';

  Future fetchProducts(url) async {
    final response = await http.get(
      Uri.parse(url),
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
