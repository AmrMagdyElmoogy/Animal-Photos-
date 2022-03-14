import 'package:animal_photos/features/animal_photos/presentation/bloc/animal_bloc.dart';
import 'package:flutter/material.dart';

class UpperView extends StatefulWidget {
  TextEditingController controller;
  AnimalBloc bloc;
  UpperView({Key? key, required this.controller, required this.bloc})
      : super(key: key);

  @override
  State<UpperView> createState() => _UpperViewState();
}

class _UpperViewState extends State<UpperView> {
  String value = "";
  @override
  void initState() {
    widget.controller.addListener(_addToValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          autofocus: true,
          keyboardType: TextInputType.number,
          controller: widget.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 5,
                color: Colors.black,
              ),
            ),
            hintText: 'Enter Number between 1 to 100',
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: value.isEmpty
                    ? null
                    : () {
                        widget.bloc
                            .add(GetBirdsPhotosEvent(numberOfPhotos: value));
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                child: const Text(
                  'Birds',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  elevation: 1,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: value.isEmpty
                    ? null
                    : () {
                        widget.bloc
                            .add(GetDogsPhotosEvent(numberOfPhotos: value));
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                child: const Text(
                  'Dogs',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  elevation: 1,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addToValue() {
    setState(() {
      value = widget.controller.text;
    });
  }
}
