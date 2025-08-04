import 'package:converter/providers/amount_provider.dart';
import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/circle_button/label_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key, TextEditingController? activeController});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(flex: 7, child: numberButtonGrid(context)),
            Flexible(
              flex: 2,
              child: Padding(padding: const EdgeInsets.only(left: 8, top: 16), child: actionButtonGrid()),
            ),
          ],
        ),
      ),
    );
  }

  GridView actionButtonGrid() {
    List<CircleButton> actionColumn = [
      iconButton(icon: Icons.arrow_back, secondary: true),
      labelButton(label: 'AC'),
      iconButton(icon: Icons.settings, secondary: true),
    ];
    return GridView.count(crossAxisCount: 1, crossAxisSpacing: 8, mainAxisSpacing: 8, children: [...actionColumn]);
  }

  GridView numberButtonGrid(BuildContext context) {
    void handleOnPressedNumber(String number) {
      context.read<AmountProvider>().addNumber(number);
    }

    List<CircleButton> numberButtons = List.generate(9, (index) {
      String i = (index + 1).toString();
      return labelButton(label: i, handleOnPressed: () => handleOnPressedNumber(i));
    });
    List<CircleButton> lastRow = [labelButton(label: '00'), labelButton(label: '0'), labelButton(label: '.')];
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 16,
      children: [...numberButtons, ...lastRow],
    );
  }
}
