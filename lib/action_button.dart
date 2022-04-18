import 'package:flutter/material.dart';
import 'game.dart';

class ActionButton extends StatelessWidget {
  final Function onClickedFunction;
  final Icon buttonIcon;
  final LastButtonPressed nextAction;

  const ActionButton(this.onClickedFunction, this.buttonIcon, this.nextAction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            onClickedFunction(nextAction);
          },
          // color: Colors.blue,
          child: buttonIcon,
        ),
      ),
    );
  }
}
