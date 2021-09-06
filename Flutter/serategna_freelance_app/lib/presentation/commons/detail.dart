import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title, data;
  const DetailRow({Key key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
        Text(
          data,
          // softWrap: true,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}
