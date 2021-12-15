import 'package:flutter/material.dart';

Row subcatRow(
  _subcats,
  _selectsubCat,
  _setsubCat,
) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      for (final subcat in _subcats)
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: ActionChip(
            backgroundColor: _selectsubCat == subcat['id']
                ? Colors.green.shade400
                : Colors.blueGrey.shade100,
            label: Text(
              '${subcat['name']}',
            ),
            onPressed: () {
              _setsubCat(subcat['id']);
            },
          ),
        ),
    ],
  );
}
