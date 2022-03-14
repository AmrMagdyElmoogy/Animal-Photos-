import 'package:equatable/equatable.dart';

class AnimalEntity extends Equatable {
  final List<String> urls;

  const AnimalEntity({required this.urls});

  @override
  List<Object?> get props => [urls];
}
