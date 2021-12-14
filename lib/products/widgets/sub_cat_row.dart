import 'package:flutter/material.dart';

Row catRow(
  _cats,
  _selectCat,
  _setCat,
) {
  return Row(
    children: [
      for (var cat in _cats)
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ActionChip(
            backgroundColor: _selectCat == cat['id']
                ? Colors.green.shade400
                : Colors.blueGrey.shade100,
            label: Text(
              '${cat['name']}',
            ),
            onPressed: () {
              _setCat(
                cat['id'],
              );
            },
          ),
        )
    ],
  );
}
