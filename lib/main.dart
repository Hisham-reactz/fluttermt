import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermt/products/views/product_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MtApp(),
    ),
  );
}

class MtApp extends StatelessWidget {
  const MtApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsPage(),
    );
  }
}
