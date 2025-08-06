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
              child: Padding(padding: const EdgeInsets.only(left: 8, top: 16), child: actionButtonGrid(context)),
            ),
          ],
        ),
      ),
    );
  }

  GridView actionButtonGrid(BuildContext context) {
    List<CircleButton> actionColumn = [
      iconButton(
        icon: Icons.arrow_back,
        secondary: true,
        handleOnPressed: () => context.read<AmountProvider>().removeLastNumber(),
      ),
      labelButton(label: 'AC', handleOnPressed: () => context.read<AmountProvider>().eraseAmount()),
      iconButton(icon: Icons.settings, secondary: true),
    ];
    return GridView.count(crossAxisCount: 1, crossAxisSpacing: 8, mainAxisSpacing: 8, children: [...actionColumn]);
  }

  GridView numberButtonGrid(BuildContext context) {
    void handleOnPressedNumber(String number) {
      context.read<AmountProvider>().addNumber(number);
    }

    Iterable<String> buttonsLabels = Iterable.generate(9, (index) {
      return (index + 1).toString();
    }).followedBy(['00', '0', '.']);
    Iterable<CircleButton> numberButtons = buttonsLabels.map(
      (label) => labelButton(label: label, handleOnPressed: () => handleOnPressedNumber(label)),
    );
    return GridView.count(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 16, children: [...numberButtons]);
  }
}
