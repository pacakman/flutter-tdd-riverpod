import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/core/error/exceptions.dart';
import 'package:flutter_app_tdd_riverpod/core/error/failures.dart';
import 'package:flutter_app_tdd_riverpod/core/network/data_connection_checker.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();
class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
