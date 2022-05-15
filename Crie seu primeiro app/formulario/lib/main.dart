import 'package:flutter/material.dart';
import 'models/produto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorQuantidade = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrando produto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controladorNome,
                decoration: const InputDecoration(labelText: 'nome'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorQuantidade,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorValor,
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                    onPressed: onPressed, child: const Text('Cadastrar')),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    final String? nome = _controladorNome.text;
    final int? quantidade = int.tryParse(_controladorQuantidade.text);
    final double? valor = double.tryParse(_controladorValor.text);
    if (nome != null && quantidade != null && valor != null) {
      final Produto produtoNovo = Produto(nome, quantidade, valor);
      debugPrint('$produtoNovo');
    }
  }
}
