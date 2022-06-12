import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo(this.valor);

  void adiciona(double valor) {
    this.valor += valor;
  }

  @override
  String toString() {
    return 'R\$ $valor';
  }
}
