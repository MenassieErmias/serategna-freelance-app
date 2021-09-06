import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final String text, value;
  const UsersList({Key key, this.text, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [Text(text), Text(value)],
      ),
    );
  }
}
