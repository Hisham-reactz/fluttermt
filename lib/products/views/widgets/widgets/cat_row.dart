import 'package:flutter/material.dart';

Row catRow(_cats, _catNot, _subCatNot) {
  return Row(
    children: [
      for (final cat in _cats)
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: ActionChip(
            backgroundColor: _catNot.selectCat == cat['id']
                ? Colors.green.shade400
                : Colors.blueGrey.shade100,
            label: Text(
              '${cat['name']}',
            ),
            onPressed: () {
              _catNot.setCat(cat['id']);
              _subCatNot.getsubCats(cat['id']);
            },
          ),
        ),
    ],
  );
}
