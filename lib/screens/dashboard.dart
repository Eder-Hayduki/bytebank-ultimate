import 'package:bytebank_ultimate/screens/lista_contatos.dart';
import 'package:bytebank_ultimate/screens/lista_transacoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //Horizontal
        crossAxisAlignment: CrossAxisAlignment.start, //Vertical
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
         SizedBox(
           height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                /*
                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                          builder: (context) => ListaContatos(),
                        ));
                      },
                      child: Container(
                        width: 150,
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Text(
                              'Transferências',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListaContatos(),
                            ));
                      },
                      child: Container(
                        width: 150,
                        height: 100,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Text(
                              'Tela de Transação',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                )
                */
                _Item(
                  'Transferencia',
                  Icons.monetization_on,
                  onClick: () => _showListaContatos(context),
                ),
                _Item(
                  'Transações',
                  Icons.description,
                  onClick: () => _showListaTransacoes(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showListaContatos(BuildContext context) {
    Navigator.of(context).push(
      (MaterialPageRoute(
        builder: (context) => ListaContatos(),
      )),
    );
  }

  void _showListaTransacoes(BuildContext context) {
    Navigator.of(context).push(
      (MaterialPageRoute(
        builder: (context) => ListaTransacoes(),
      )),
    );
  }
}

class _Item extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Function onClick;

  const _Item(this.nome, this.icone, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          /*{
            Navigator.of(context).push(
              (MaterialPageRoute(
                builder: (context) => ListaContatos(),
              )),
            );
          },*/

          child: Container(
            width: 150,
            height: 100,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icone,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  nome,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
