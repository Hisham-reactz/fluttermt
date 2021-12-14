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
  //init data fetch
  void getData() async {
    _cats = await apiservice.fetchCats();
    _products = await apiservice.fetchProducts(getUrl());
    setState(() {
      _cats = _cats;
      _products = _products;
      _catLoading = false;
      _productLoading = false;
    });
  }

  //set category action
  void _setCat(cat) async {
    setState(() {
      _catLoading = true;
      _productLoading = true;
    });
    _subcats = await apiservice.fetchsubCats(cat);
    _products = await apiservice.fetchProducts(getUrl());
    setState(() {
      _selectCat = cat;
      _selectsubCat = null;
      _page = 0;
      _subcats = _subcats;
      _products = _products;
      _catLoading = false;
      _productLoading = false;
    });
  }

  //set sub category action
  void _setsubCat(cat) async {
    setState(() {
      _productLoading = true;
    });
    _products = await apiservice.fetchProducts(getUrl());
    setState(() {
      _selectsubCat = cat;
      _page = 0;
      _products = _products;
      _productLoading = false;
    });
  }

  //scroll pagination
  void nextPage(top) async {
    if (top && _page > 0 || !top) {
      setState(() {
        top ? _page-- : _page++;
        _productLoading = true;
      });
      _products = await apiservice.fetchProducts(getUrl());
      setState(() {
        _products = _products;
        _productLoading = false;
      });
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
          child: Column(
            children: _catLoading
                ? const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    )
                  ]
                : [
                    ListTile(
                      leading: Icon(
                        Icons.grid_on,
                        color: Colors.red.shade900,
                      ),
                      minLeadingWidth: 0.0,
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        //scrollable category widget
                        child: catRow(_cats, _selectCat, _setCat),
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
                        child: subcatRow(_subcats, _selectsubCat, _setsubCat),
                      ),
                    ),
                  ],
          ),
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            115,
          ),
        ),
      ),
      body: _productLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              controller: _scrlcrtl,
              itemBuilder: (context, index) {
                final product = _products[index];
                //product Listtile
                return productTile(product);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: _products.length,
            ),
    );
  }
}
