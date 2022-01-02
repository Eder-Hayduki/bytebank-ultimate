import 'package:bytebank_ultimate/models/contato.dart';
import 'package:flutter/material.dart';

class ContactDeleteDialog extends StatefulWidget {
  @override
  _ContactDeleteDialogState createState() => _ContactDeleteDialogState();
}

class _ContactDeleteDialogState extends State<ContactDeleteDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Você tem certeza que deseja excluir esse contato?',
        style: TextStyle(
          color: Colors.redAccent[700],
          fontSize: 20,
        ),
      ),
      content: Text('a ação é irreversível?'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'NÃO',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'SIM',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
