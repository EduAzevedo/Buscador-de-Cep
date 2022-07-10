import 'package:buscador_de_cep/components/modal_info.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'models/cidade.dart';

void main() => runApp(
      ResponsiveSizer(builder: (context, orientation, screenType) {
        return const MaterialApp(
          home: Home(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Cidade? cidade;
  TextEditingController value = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "BUSCAR\nCEP",
                      style: TextStyle(
                          fontSize: 32.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 40,
                    ),
                    TextFormField(
                      controller: value,
                      maxLength: 9,
                      validator: (cepInput) {
                        final cep = cepInput ?? '';
                        if (cep.isEmpty || cep.length < 8) {
                          return 'Informe um CEP válido!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          labelText: 'Insira o CEP (Ex: 49400-000)',
                          labelStyle: TextStyle(color: Colors.black45)),
                    ),
                    Container(
                      height: 10,
                    ),
                    SizedBox(
                      width: 80.w,
                      child: ElevatedButton(
                        onPressed: () {
                          if (value.text.length == 9) {
                            showModalBottomSheet(
                              elevation: 5,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              context: context,
                              builder: (_) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: InfoCep(
                                      value.value.text,
                                      cidade: cidade,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("ERRO"),
                                      content:
                                          const Text("Insira um CEP válido!"),
                                      actions: [
                                        TextButton(
                                          onPressed: (() =>
                                              Navigator.pop(context)),
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.black),
                                          child: const Text("Fechar"),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 12,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(14),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        child: const Text("BUSCAR"),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Lottie.asset("assets/anim/brazil_anim")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
