import 'dart:convert';
import 'package:bytebank_ultimate/models/transacao.dart';
import 'package:http/http.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transacao>> buscarWeb() async {
    final Response response = await client.get(Uri.parse(baseURL));
    final List<dynamic> listaDecodeJson = jsonDecode(response.body);
    return listaDecodeJson
        .map((dynamic json) => Transacao.fromJson(json))
        .toList();
  }

  // List<Transacao> _toTransactions(Response response) {
  //   final List<dynamic> listaDecodeJson = jsonDecode(response.body);
  //   final List<Transacao> transacoes = listaDecodeJson
  //       .map((dynamic json) => Transacao.fromJson(json))
  //       .toList();
  //   return transacoes;
  // }

  Future<Transacao?> salvar(Transacao transacao, String password) async {
    // Map<String, dynamic> transacaoMap = _toMap(transacao);
    final String transacaoJson = jsonEncode(transacao.toJson());

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(Uri.parse(baseURL),
        headers: {
          'Content-Type': 'application/json',
          'password': password,
        },
        body: transacaoJson);

    //throw Exception();

    if (response.statusCode == 200) {
      return Transacao.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
    // throw HttpException(_getMessage(500));
  }

  String? _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Erro desconhecido!';
  }

  // void _throwHttpError(int statusCode) =>
  //     throw Exception(_statusCodeResponses[statusCode]);

  static final Map<int, String> _statusCodeResponses = {
    400: 'Ocorreu um erro ao enviar a transação!',
    401: 'Falha na Autenticação!',
    409: 'Transação já existente!',
  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
