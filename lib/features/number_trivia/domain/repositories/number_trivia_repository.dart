import 'package:dartz/dartz.dart';
import 'package:flutter_app_tdd_riverpod/core/error/failures.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}