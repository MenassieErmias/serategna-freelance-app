import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final String text, value;
  const UsersList({Key key, this.text, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(text), Text(value)],
    );
  }
}
