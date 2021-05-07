import 'package:dartz/dartz.dart';
import 'package:flutter_app_tdd_riverpod/core/error/failures.dart';
import 'package:flutter_app_tdd_riverpod/core/usecases/usecase.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}