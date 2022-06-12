import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  final _titulo = 'Últimas Transferências';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                return ItemTransferencia(transferencias.transferencias[indice]);
              });
        }),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListaTransferencias();
            }));
          },
          child: const Text('Transferências'),
        ),
      ],
    );
  }
}
