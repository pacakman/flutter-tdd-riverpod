import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/core/error/failures.dart';
import 'package:flutter_app_tdd_riverpod/core/usecases/usecase.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}