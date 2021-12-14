import 'package:flutter/material.dart';
import 'package:fluttermt/products/products.dart';

void main() {
  runApp(
    const MtApp(),
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
      home: const ProductsPage(
        title: '',
      ),
    );
  }
}
