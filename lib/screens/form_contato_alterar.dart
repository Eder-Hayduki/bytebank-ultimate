import 'package:bytebank_ultimate/database/dao/contato_dao.dart';
import 'package:bytebank_ultimate/models/contato.dart';
import 'package:bytebank_ultimate/screens/lista_contatos.dart';
import 'package:flutter/material.dart';

class ContactFormAlterar extends StatefulWidget {
  final Contato contatoAlterado;

  ContactFormAlterar({required this.contatoAlterado});

  @override
  _ContactFormAlterarState createState() {
    return _ContactFormAlterarState(contatoAlterado);
  }
}

class _ContactFormAlterarState extends State<ContactFormAlterar> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _dao = ContatoDao();
  final Contato contatoAlterado;

  _ContactFormAlterarState(this.contatoAlterado);

  //Preenchendo os valores no formulario
  void initState() {
    super.initState();
    _nomeController =
        new TextEditingController(text: '${contatoAlterado.nome}');
    _numeroContaController =
        new TextEditingController(text: '${contatoAlterado.numeroConta}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            TextField(
              controller: _numeroContaController,
              decoration: InputDecoration(
                labelText: 'Numero da Conta',
              ),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => _alterarContato(context),
                  child: Text('Alterar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _alterarContato(BuildContext context) {
    final nome = _nomeController.text;
    final conta = int.tryParse(_numeroContaController.text);

    final contatoEditado = Contato(contatoAlterado.id, nome, conta!);

    _dao.alterar(contatoEditado).then((id) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ListaContatos())));
  }
}
