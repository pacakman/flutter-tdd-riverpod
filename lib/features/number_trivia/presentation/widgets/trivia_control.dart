import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/core/util/providers.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/view_models/number_trivia_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TriviaControl extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    var inputStr = '';
    var viewModel = useProvider(numberTriviaProvider);

    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete(inputStr, viewModel);
          },
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: Text('Search'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: (){
                  if (inputStr != '') {
                    dispatchConcrete(inputStr, viewModel);
                  }
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: Text('Get random trivia'),
                onPressed: (){
                  dispatchRandom(viewModel);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete(String number, NumberTriviaViewModel viewModel) {
    viewModel.getTriviaForConcreteNumber(int.parse(number));
  }

  void dispatchRandom(NumberTriviaViewModel viewModel) {
    viewModel.getTriviaForRandomNumber();
  }
}
