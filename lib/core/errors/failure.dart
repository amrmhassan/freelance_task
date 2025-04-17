import 'package:flutter/foundation.dart';

abstract class Failure {
  final String message;
  Failure([this.message = '']) {
    if (kDebugMode) {
      throw message;
    }
  }
}

class ServerFailure extends Failure {
  ServerFailure([super.message]);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('No internet connection');
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure([super.message]);
}
