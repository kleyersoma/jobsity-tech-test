import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/utils/bloc_observers/simple_bloc_observer.dart';

import 'src/app.dart';

void main() async {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const TVMazeApp());
}
