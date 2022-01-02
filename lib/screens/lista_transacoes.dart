import 'package:bytebank_ultimate/components/mensagem_centralizada.dart';
import 'package:bytebank_ultimate/components/progress.dart';
import 'package:bytebank_ultimate/http/webclient/transacao_webclient.dart';
import 'package:bytebank_ultimate/models/transacao.dart';
import 'package:flutter/material.dart';

class ListaTransacoes extends StatelessWidget {
//  final List<Transacao> transacoes = [];

final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
//    transacoes.add(Transacao(100.0, Contato(0, 'Anderson', 5632)));
//    transacoes.add(Transacao(200.0, Contato(0, 'Anderson', 6632)));
//    transacoes.add(Transacao(300.0, Contato(0, 'Anderson', 7632)));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: FutureBuilder<List<Transacao>>(
          future:
              Future.delayed(Duration(seconds: 1)).then((value) => _webClient.buscarWeb()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:

                if (snapshot.hasData){
                  final List<Transacao>? transacoes = snapshot.data;
                  if (transacoes!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transacao transacao = transacoes[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transacao.valor.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transacao.contato.numeroConta.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transacoes.length,
                    );
                  }

                }


                return MensagemCentralizada(
                  'Nenhuma transação encontrada!',
                   Icons.warning,
                );
            }
            return Text('Erro desconhecido!');
          }),
    );
  }
}
