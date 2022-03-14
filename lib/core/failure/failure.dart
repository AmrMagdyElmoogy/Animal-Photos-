import 'package:dartz/dartz.dart';

abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class InvaildFormatInteger extends Failure {}
