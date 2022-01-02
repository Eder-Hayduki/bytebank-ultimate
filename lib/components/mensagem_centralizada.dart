import 'package:flutter/material.dart';

class MensagemCentralizada extends StatelessWidget {
  final String mensagem;
  final IconData icone;
  final double iconSize;
  final double fontSize;

  MensagemCentralizada(this.mensagem, this.icone,
      {this.iconSize = 64, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(
              icone,
              size: iconSize,
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            mensagem,
            style: TextStyle(fontSize: fontSize),
          ),)
        ],
      ),
    );
  }
}
