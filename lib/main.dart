import 'package:animal_photos/features/animal_photos/presentation/bloc/animal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:animal_photos/core/dependency_injection/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_photos/core/dependency_injection/di.dart';
import 'features/animal_photos/presentation/pages/animal_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AnimalBloc>(),
            child: const AnimalPage(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.orange.shade600),
          home: const AnimalPage(),
        ));
  }
}
