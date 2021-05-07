import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/core/usecases/usecase.dart';
import 'package:flutter_app_tdd_riverpod/core/util/request_status.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';

class NumberTriviaViewModel extends ChangeNotifier {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaViewModel(this.getConcreteNumberTrivia, this.getRandomNumberTrivia){
    getTriviaForRandomNumber();
  }

  RequestStatus requestStatus = RequestStatus.empty;
  NumberTrivia numberTrivia;

  void getTriviaForConcreteNumber(int number) async {
    requestStatus = RequestStatus.loading;
    var response = await getConcreteNumberTrivia.call(Params(number: number));
    response.fold((failure) {
      requestStatus = RequestStatus.error;
      notifyListeners();
    }, (numberTrivia) {
      requestStatus = RequestStatus.loaded;
      this.numberTrivia = numberTrivia;
      notifyListeners();
    });
  }

  void getTriviaForRandomNumber() async {
    requestStatus = RequestStatus.loading;
    var response = await getRandomNumberTrivia.call(NoParams());
    response.fold((failure) {
      requestStatus = RequestStatus.error;
      notifyListeners();
    }, (numberTrivia) {
      requestStatus = RequestStatus.loaded;
      this.numberTrivia = numberTrivia;
      notifyListeners();
    });
  }
}