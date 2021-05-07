import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/view_models/number_trivia_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../injection_container.dart';

final numberTriviaProvider = ChangeNotifierProvider((_) => NumberTriviaViewModel(sl<GetConcreteNumberTrivia>(), sl<GetRandomNumberTrivia>()));