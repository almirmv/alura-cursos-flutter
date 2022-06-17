import 'package:bytebank/screens/counter.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/theme.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const BytebankApp()),
    blocObserver: AppBlocObserver(),
  );
  runApp(const BytebankApp());
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //evitar usar Log em produção. para não vazar informaçoes
    //Bloc.observer = LogObserver();

    return MaterialApp(
      theme: bytebankTheme,
      home: const DashboardContainer(),
    );
  }
}
