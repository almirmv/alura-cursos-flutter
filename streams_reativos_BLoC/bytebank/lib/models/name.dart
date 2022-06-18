import 'package:flutter_bloc/flutter_bloc.dart';

//o estado é uma unica string
//poderia ser um perfil com diversos valores
class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);
  void change(String name) => emit(name);
}
