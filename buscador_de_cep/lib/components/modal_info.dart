import 'dart:convert';

import 'package:buscador_de_cep/models/cidade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InfoCep extends StatelessWidget {
  final String cep;
  Cidade? cidade;

  InfoCep(this.cep, {super.key, required this.cidade});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder(
        future: _fetchCep(),
        builder: (context, snapshot) {
          snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : Container();
          if (snapshot.hasData) {
            cidade = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      "${cidade!.cidade} - ${cidade!.uf}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "DDD: ${cidade!.ddd}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "CEP: ${cidade!.cep}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "Cidade: ${cidade!.cidade} - ${cidade!.uf}\nDDD: ${cidade!.ddd}\nCEP: ${cidade!.cep}"));
                          Fluttertoast.showToast(
                              msg: "Copiado!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 12,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(14),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        child: const Text("COPIAR"),
                      ))
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "CEP não encontrado!",
                style: TextStyle(color: Colors.black),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Cidade> _fetchCep() async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return Cidade.fromJson(json.decode(response.body));
    } else {
      throw Exception('Algo deu errado');
    }
  }
}
