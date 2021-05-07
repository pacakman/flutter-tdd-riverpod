import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/core/util/providers.dart';
import 'package:flutter_app_tdd_riverpod/core/util/request_status.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/view_models/number_trivia_view_model.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/widgets/trivia_control.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NumberTriviaPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = useProvider(numberTriviaProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    children: <Widget>[
                      numberWidget(viewModel),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: textWidget(viewModel),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TriviaControl(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textWidget(NumberTriviaViewModel viewModel) {
    if (viewModel.requestStatus == RequestStatus.loaded) {
      return Text(
        '${viewModel.numberTrivia.text}',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      );
    }
    return CircularProgressIndicator();
  }

  Widget numberWidget(NumberTriviaViewModel viewModel) {
    if (viewModel.requestStatus == RequestStatus.loaded) {
      return Text(
        '${viewModel.numberTrivia.number}',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return CircularProgressIndicator();
  }
}
