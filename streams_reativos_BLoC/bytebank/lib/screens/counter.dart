import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//O Cubit é aquele que mantém a informação e a entrega ao Container por meio de
// um Provider, e a View ouve o Container para alterar a informação visual!

//exemplo de contador utilizando Bloc
//em duas variações

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); //metoso construtor inicializa state com 0
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CounterContainer extends StatelessWidget {
  const CounterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CounterCubit(), child: CounterView());
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),
      body: Center(
        //é notificado quando tiver que fazer um rebuild
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Text("$state", style: textTheme.headline2);
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            //abordage 1 de como acessar o bloc
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
