import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title, data;
  const DetailRow({Key key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      Text(
        data,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      )
    ]);
  }
}
