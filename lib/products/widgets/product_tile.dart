import 'package:flutter/material.dart';

ListTile productTile(product) {
  final imgUrl = product['offers'] == null
      ? product['images'][0]['image_url']
      : product['offers']['price_book']['file'];

  return ListTile(
    isThreeLine: true,
    leading: Image.network(
      'https://sta.farawlah.sa/storage/$imgUrl',
      width: 100,
    ),
    minLeadingWidth: 0.0,
    title: Text(
      '${product['name']}',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: Text(
      '${product['price']['sale_price']} SAR',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.green.shade400,
      ),
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.favorite_rounded,
          color: Colors.red.shade900,
        ),
        Icon(
          Icons.add_circle,
          color: Colors.green.shade400,
        ),
      ],
    ),
  );
}
