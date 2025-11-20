import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/circle_button/label_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatelessWidget {
  final bool inRow;
  const Keyboard({super.key, this.inRow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
            flex: inRow ? 5 : 7,
            child: LayoutBuilder(
              builder: (context, numberConstraints) {
                return numberButtonGrid(context, numberConstraints, inRow);
              },
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: inRow ? 1 : 2,
            child: LayoutBuilder(
              builder: (context, actionConstraints) {
                return actionButtonGrid(context, actionConstraints, inRow);
              },
            ),
          ),
        ],
      ),
    );
  }

  GridView actionButtonGrid(BuildContext context, actionConstraints, inRow) {
    final AppLocalizations l = AppLocalizations.of(context)!;

    final actionColumn = [
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
      labelButton(
        context: context,
        label: l.icon,
        handleOnPressed: () => context.read<ConverterProvider>().switchLanguage(context),
        secondary: true,
      ),
    ];

    final crossAxisCount = 1;
    final double mainAxisSpacing = inRow ? 8 : 12;

    return GridView.count(
      shrinkWrap: !inRow,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 0,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: inRow
          ? getGridChildRatioFromConstraints(crossAxisCount, mainAxisSpacing, actionColumn.length, actionConstraints)
          : getGridChildRatioDefaultWithHeightPadding(
              1,
              crossAxisCount,
              mainAxisSpacing,
              actionColumn.length,
              actionConstraints,
              heightPadding: 0.2,
            ),
      padding: EdgeInsets.zero,
      children: actionColumn,
    );
  }
}

GridView numberButtonGrid(BuildContext context, numberConstraints, inRow) {
  void handleOnPressedNumber(String number) {
    context.read<ConverterProvider>().addNumber(number);
  }

  final buttonsLabels = Iterable.generate(9, (i) => '${i + 1}').followedBy(['00', '0', '.']);

  final numberButtons = buttonsLabels
      .map(
        (label) => labelButton(
          context: context,
          label: label,
          fontSize: 30,
          handleOnPressed: () => handleOnPressedNumber(label),
        ),
      )
      .toList();

  final crossAxisCount = 3;
  final double mainAxisSpacing = 8;

  return GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: crossAxisCount,
    crossAxisSpacing: 4,
    mainAxisSpacing: mainAxisSpacing,
    childAspectRatio: getGridChildRatioFromConstraints(
      crossAxisCount,
      mainAxisSpacing,
      numberButtons.length,
      numberConstraints,
    ),
    padding: EdgeInsets.zero,
    children: numberButtons,
  );
}
