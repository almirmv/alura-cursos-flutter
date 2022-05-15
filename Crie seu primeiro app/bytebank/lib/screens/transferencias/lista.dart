//------------------TELA LISTA DAS TRANSFERENCIAS------------------------------
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencias/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia?> _transferencias = [];

  //@override
  //State<StatefulWidget> createState() {
  //  return ListaTransferenciasState();
  // }
  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    //widget._transferencias.add(Transferencia(45.55, 8888));
    //widget._transferencias.add(Transferencia(45.55, 8888));
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: ListView.builder(
        //o objeto widget acessa o statefulwidget
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia!);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            })).then(
              (transferenciaRecebida) => _atualiza(transferenciaRecebida),
            );
          }),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    //voltar tela sem dados ou dados errados a transferencia vem como null
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
