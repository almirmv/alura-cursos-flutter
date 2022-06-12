import 'dart:ffi';

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

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

  void _criaDeposito(BuildContext context) {
    final double? valor = double.tryParse(_controladorCampoValor.text);
    final bool depositoValido = _validaDeposito(valor);
    if (depositoValido) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito(valor) {
    final campoPreechido = valor != null;
    return campoPreechido;
  }

  _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}