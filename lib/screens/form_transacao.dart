import 'dart:async';

import 'package:bytebank_ultimate/components/progress.dart';
import 'package:bytebank_ultimate/components/response_dialog.dart';
import 'package:bytebank_ultimate/components/transaction_auth_dialog.dart';
import 'package:bytebank_ultimate/http/webclient/transacao_webclient.dart';
import 'package:bytebank_ultimate/models/contato.dart';
import 'package:bytebank_ultimate/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contato contato;

  const TransactionForm(this.contato, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _transactionWebClient = TransactionWebClient();

  final String transactionId = Uuid().v4();
  bool _carregando = false;

  @override
  Widget build(BuildContext context) {
    print('Transação ID API $transactionId');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                child: Progress(mensagem: 'Aguarde um momento...'),
                visible: _carregando,
              ),
              Text(
                widget.contato.nome,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numeroConta.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  //
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'valor',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transferir'),
                    onPressed: () {
                      final value = double.tryParse(_valueController.text);
                      final transacaoCriada =
                          Transacao(transactionId, value, widget.contato);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            //o nome desse contexto foi alterado para evitar
                            // conflito com outros contexts
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transacaoCriada, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transacao transacaoCriada,
    String password,
    BuildContext context,
  ) async {
    // await Future.delayed(Duration(seconds: 1));
    Transacao? transacao = await _send(transacaoCriada, password, context);

    _showSuccessfulMessage(transacao, context);
  }

  Future<void> _showSuccessfulMessage(
      Transacao? transacao, BuildContext context) async {
    if (transacao != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação salva com sucesso');
          });
      Navigator.pop(context);
    }
  }

  Future<Transacao?> _send(
      Transacao transacaoCriada, String password, BuildContext context) async {
    setState(() {
      _carregando = true;
    });

    final Transacao? transacao = await _transactionWebClient
        .salvar(transacaoCriada, password)
        .catchError((e) {
      _showFailureMessage(context, message: 'Tempo excedido');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context, message: 'Erro Desconhecido');
    }).whenComplete(() {
      setState(() {
        _carregando = false;
      });
    });
    return transacao;
  }

  void _showFailureMessage(BuildContext context, {required String message}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
