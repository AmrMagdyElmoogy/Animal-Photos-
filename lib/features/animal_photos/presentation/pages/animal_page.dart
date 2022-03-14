import 'package:animal_photos/features/animal_photos/data/model/animal_model.dart';
import 'package:animal_photos/features/animal_photos/presentation/bloc/animal_bloc.dart';
import 'package:animal_photos/features/animal_photos/presentation/widgets/error_view.dart';
import 'package:animal_photos/features/animal_photos/presentation/widgets/loading_view.dart';
import 'package:animal_photos/features/animal_photos/presentation/widgets/loaded_view.dart';
import 'package:animal_photos/features/animal_photos/presentation/widgets/upper_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/dependency_injection/di.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({Key? key}) : super(key: key);

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  TextEditingController controller = TextEditingController();
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Animal Photos',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: double.infinity,
            child: Column(children: [
              BlocBuilder<AnimalBloc, AnimalState>(
                builder: (context, state) {
                  AnimalBloc bloc = BlocProvider.of<AnimalBloc>(context);
                  return UpperView(controller: controller, bloc: bloc);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<AnimalBloc, AnimalState>(
                  builder: (context, state) {
                    if (state is Error) {
                      return ErrorView(message: state.message);
                    } else if (state is Loaded) {
                      return LoadedView(
                          length: state.entity.urls.length,
                          entity: state.entity);
                    } else {
                      final list1 =
                          sharedPreferences.getStringList('CachedBirds');
                      final list2 =
                          sharedPreferences.getStringList('CachedDogs');
                      if (list1 != null) {
                        return LoadedView(
                          length: list1.length,
                          entity: AnimalModel.fromJson(list1),
                        );
                      } else if (list2 != null) {
                        return LoadedView(
                          length: list2.length,
                          entity: AnimalModel.fromJson(list2),
                        );
                      } else {
                        return const LoadingView();
                      }
                    }
                  },
                ),
              ),
            ]),
          )),
    );
  }
}
