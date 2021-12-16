import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermt/products/views/constants.dart';
import 'package:fluttermt/products/views/widgets/widgets/cat_row.dart';
import 'package:fluttermt/products/views/widgets/widgets/product_tile.dart';
import 'package:fluttermt/products/views/widgets/widgets/sub_cat_row.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrlcrtl = ScrollController();
    final contsants = Contstants();

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
          child: Consumer(
            builder: (context, ref, child) {
              final productNot = ref.watch(
                contsants.productListProvider.notifier,
              );
              final catProvider = ref.watch(contsants.catListProvider);
              final catProviderNot = ref.watch(
                contsants.catListProvider.notifier,
              );
              catProviderNot.getCats();
              final subcatProvider = ref.watch(contsants.subcatListProvider);
              final subcatProviderNot = ref.watch(
                contsants.subcatListProvider.notifier,
              );
              productNot.fetchProducts(
                catProviderNot.selectCat,
                subcatProviderNot.selectsubCat,
              );

              _scrlcrtl.addListener(() {
                if (_scrlcrtl.position.atEdge) {
                  if (_scrlcrtl.position.pixels == 0) {
                    // You're at the top.
                    productNot.nextPage(
                      true,
                      catProviderNot.selectCat,
                      subcatProviderNot.selectsubCat,
                    );
                  } else {
                    // You're at the bottom.
                    productNot.nextPage(
                      false,
                      catProviderNot.selectCat,
                      subcatProviderNot.selectsubCat,
                    );
                  }
                }
              });

              return Visibility(
                visible: catProviderNot.catLoading,
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
                          catProvider,
                          catProviderNot,
                          subcatProviderNot,
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
                          subcatProvider,
                          subcatProviderNot,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            115,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final productProvider = ref.watch(contsants.productListProvider);
          final productNot = ref.watch(contsants.productListProvider.notifier);

          return Visibility(
            visible: !productNot.productLoading,
            child: Visibility(
              visible: productProvider.isNotEmpty,
              child: ListView.separated(
                controller: _scrlcrtl,
                itemBuilder: (context, index) {
                  final product = productProvider[index];
                  //product listtile
                  return productTile(product);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: productProvider.length,
              ),
              replacement: const Center(
                child: Text('No Products'),
              ),
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
