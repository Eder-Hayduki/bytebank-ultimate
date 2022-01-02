import 'package:flutter/material.dart';

class ContactDeleteFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Senha Inválida'),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Icon(
          Icons.warning,
          color: Colors.redAccent,
          size: 50,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Center(
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[700],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
