import 'package:flutter/foundation.dart';
import 'package:freelance_task/utils/fast_access.dart';

abstract class Failure {
  final String message;
  Failure([this.message = '']) {
    if (kDebugMode) {
      logger.e(message);
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
