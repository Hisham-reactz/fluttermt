import 'package:flutter/material.dart';
import 'package:fluttermt/api.dart';
import 'package:fluttermt/products/widgets/cat_row.dart';
import 'package:fluttermt/products/widgets/product_tile.dart';
import 'package:fluttermt/products/widgets/sub_cat_row.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int? _selectCat;
  int _page = 0;
  int? _selectsubCat;
  List _cats = [];
  List _subcats = [];
  List _products = [];
  bool _productLoading = true;
  bool _catLoading = true;
  final apiservice = ApiService();
  final ScrollController _scrlcrtl = ScrollController();

  //show snackbar
  void showSnackbar(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  //init data fetch
  void getData() async {
    await apiservice.fetchCats().then((data) => {
          setState(() {
            _cats = data;
            _catLoading = false;
          }),
        });

    fetchProducts();
  }

  //fetch product
  void fetchProducts() async {
    await apiservice
        .fetchProducts(getUrl())
        .then(
          (data) => {
            setState(() {
              _products = data;
              _productLoading = false;
            })
          },
        )
        .onError(
          (error, stackTrace) => {
            setState(() {
              _products = [];
              _productLoading = false;
            }),
            showSnackbar(error.toString()),
          },
        );
  }

  //set category action
  void _setCat(cat) async {
    setState(() {
      _catLoading = true;
      _productLoading = true;
      _selectCat = cat;
      _selectsubCat = null;
      _page = 0;
    });
    await apiservice.fetchsubCats(_selectCat).then((data) => {
          setState(() {
            _subcats = data;
            _catLoading = false;
          }),
        });

    fetchProducts();
  }

  //set sub category action
  void _setsubCat(cat) async {
    setState(() {
      _productLoading = true;
      _selectsubCat = cat;
      _page = 0;
    });

    fetchProducts();
  }

  //scroll pagination
  void nextPage(top) async {
    if (top && _page > 0 || !top) {
      setState(() {
        top ? _page-- : _page++;
        _productLoading = true;
      });

      fetchProducts();
    }
  }

  //url set
  String getUrl() {
    String catstring = _selectCat != null ? 'parent_category_id=' : '';
    String subcatstring = _selectsubCat != null ? 'category_id=' : '';
    String url = '''${apiservice.baseUrl}/api/mobile/products?
        $catstring${_selectCat ?? ''}
        &$subcatstring${_selectsubCat ?? ''}
        &store_id=2&offset=$_page
        &limit=20&sort_by=sale_price&sort_type=DESC''';
    return url;
  }

  @override
  void initState() {
    super.initState();
    getData();
    //data fetch as per scroll pos
    _scrlcrtl.addListener(() {
      if (_scrlcrtl.position.atEdge) {
        if (_scrlcrtl.position.pixels == 0) {
          // You're at the top.
          nextPage(true);
        } else {
          // You're at the bottom.
          nextPage(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Colors.red.shade900,
        ),
        title: Icon(
          Icons.shop_2_rounded,
          color: Colors.red.shade900,
        ),
        actions: [
          Icon(
            Icons.search_rounded,
            color: Colors.red.shade900,
          ),
          const SizedBox(
            width: 20,
          )
        ],
        elevation: 0.5,
        centerTitle: true,
        bottom: PreferredSize(
          child: Visibility(
            visible: _catLoading,
            child: Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            replacement: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.grid_on,
                    color: Colors.red.shade900,
                  ),
                  minLeadingWidth: 0.0,
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    //scrollable category widget
                    child: catRow(
                      _cats,
                      _selectCat,
                      _setCat,
                    ),
                  ),
                ),
                ListTile(
                  minLeadingWidth: 0.0,
                  leading: Icon(
                    Icons.filter_alt,
                    color: Colors.red.shade900,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    //scrollable sub category widget
                    child: subcatRow(
                      _subcats,
                      _selectsubCat,
                      _setsubCat,
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            115,
          ),
        ),
      ),
      body: Visibility(
        visible: !_productLoading,
        child: Visibility(
          visible: _products.isNotEmpty,
          child: ListView.separated(
            controller: _scrlcrtl,
            itemBuilder: (context, index) {
              final product = _products[index];
              //product listtile
              return productTile(product);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _products.length,
          ),
          replacement: const Center(
            child: Text('No Products'),
          ),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
