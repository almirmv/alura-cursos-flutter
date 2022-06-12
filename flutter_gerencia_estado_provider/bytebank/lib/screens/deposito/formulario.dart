import 'package:bytebank/components/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormularioDeposito extends StatelessWidget {
  final String _tituloAppBar = 'Receber Depósito';
  final String _dicaCampoValor = '0.00';
  final String _rotuloCampoValor = 'Valor';
  final String _textoBotaoConfirmar = 'Comfirmar';
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              dica: _dicaCampoValor,
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () => _criaDeposito(context),
            ),
          ],
        ),
      ),
    );
  }

  _criaDeposito(BuildContext context) {
    Navigator.pop(context);
  }
}
