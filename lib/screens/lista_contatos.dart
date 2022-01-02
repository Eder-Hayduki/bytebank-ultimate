import 'package:bytebank_ultimate/components/progress.dart';
import 'package:bytebank_ultimate/database/dao/contato_dao.dart';
import 'package:bytebank_ultimate/models/contato.dart';
import 'package:flutter/material.dart';

import 'form_contato.dart';
import 'form_contato_alterar.dart';
import 'form_transacao.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

//  final List<Contato> contatos = []; // List() foi substituido por: []
  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
//    contatos.add(Contato(0,'Eduardo',1000));
//    contatos.add(Contato(0,'Jose',1001));
//    contatos.add(Contato(0,'Alfredo',1002));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferencias'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: const [],
        future: Future.delayed(const Duration(seconds: 1))
            .then((value) => _dao.buscar()),
//        future: buscar(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            //Quando o Future ainda não foi executado
//            case ConnectionState.none:
//              break;
            //Verificando se o Future ainda esta rodando e não foi finalizado
            case ConnectionState.waiting:
              return Progress();
            //Quando nosso snapshot possui dado disponível mas o Future ainda
            // não finalizou.
//            case ConnectionState.active:
//              break;
            //
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = contatos[index];
                  return _ItemContato(contato, onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionForm(contato),
                      ),
                    );
                  });
                },
                itemCount: contatos.length,
              );
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
          return const Text('Erro ao carregar Lista!!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ),
            //).then((novoContato) => debugPrint(novoContato.toString()),);
          )
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ItemContato extends StatelessWidget {
  final Contato contato;
  final ContatoDao dao = ContatoDao();
  final Function onClick;

  _ItemContato(this.contato, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => onClick(),
          title: Text(
            contato.nome,
            style: const TextStyle(fontSize: 24.0),
          ),
          subtitle: Text(
            contato.numeroConta.toString(),
            style: const TextStyle(fontSize: 16.0),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    final contatoAlterado =
                        Contato(contato.id, contato.nome, contato.numeroConta);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactFormAlterar(
                                contatoAlterado: contatoAlterado)));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Excluir contato:'),
                        content: Text('Você deseja realmente excluir o '
                            'contato? ${contato.nome}? A ação é irreversível.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('CANCELAR'),
                          ),
                          TextButton(
                            onPressed: () {
                              dao.apagar(contato.id);
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ListaContatos()));
                            },
                            child: Text('CONFIRMAR'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
