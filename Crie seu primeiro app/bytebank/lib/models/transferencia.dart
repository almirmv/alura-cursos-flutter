class Transferencia {
  final double valor;
  final int numeroConta;

  //construtor
  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numero conta: $numeroConta}';
  }
}
