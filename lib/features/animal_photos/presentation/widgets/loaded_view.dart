import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:animal_photos/features/animal_photos/presentation/bloc/animal_bloc.dart';
import 'package:flutter/material.dart';

class LoadedView extends StatefulWidget {
  int length;
  AnimalEntity entity;
  LoadedView({Key? key, required this.length, required this.entity})
      : super(key: key);

  @override
  State<LoadedView> createState() => _LoadedViewState();
}

class _LoadedViewState extends State<LoadedView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 5,
      ),
      itemCount: widget.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 120,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(widget.entity.urls[index].toString()),
                fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
