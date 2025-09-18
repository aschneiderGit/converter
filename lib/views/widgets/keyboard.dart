import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/circle_button/label_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
      child: Row(
        children: [
          Flexible(flex: 7, child: numberButtonGrid(context)),
          Flexible(
            flex: 2,
            child: Padding(padding: EdgeInsets.only(left: 8, top: 16), child: actionButtonGrid(context)),
          ),
        ],
      ),
    );
  }

  GridView actionButtonGrid(BuildContext context) {
    List<CircleButton> actionColumn = [
      iconButton(
        icon: Icons.arrow_back,
        secondary: true,
        handleOnPressed: () => context.read<ConverterProvider>().removeLastNumber(),
      ),
      labelButton(
        context: context,
        label: 'AC',
        handleOnPressed: () => context.read<ConverterProvider>().eraseAmount(),
      ),
      iconButton(icon: Icons.settings, secondary: true),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [...actionColumn],
    );
  }

  GridView numberButtonGrid(BuildContext context) {
    void handleOnPressedNumber(String number) {
      context.read<ConverterProvider>().addNumber(number);
    }

    Iterable<String> buttonsLabels = Iterable.generate(9, (index) {
      return (index + 1).toString();
    }).followedBy(['00', '0', '.']);
    Iterable<CircleButton> numberButtons = buttonsLabels.map(
      (label) => labelButton(
        context: context,
        label: label,
        fontSize: 30,
        handleOnPressed: () => handleOnPressedNumber(label),
      ),
    );
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [...numberButtons],
    );
  }
}
