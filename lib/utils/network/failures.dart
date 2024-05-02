import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}

class RequestFailure extends Failure {
  final String message;

  RequestFailure({required this.message});
}
