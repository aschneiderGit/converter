import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<CircleButton> numberButtons = List.generate(9, (index) {
      int i = index + 1;
      return CircleButton(label: i.toString());
    });
    List<CircleButton> lastRow = [
      CircleButton(label: '00'),
      CircleButton(label: '0'),
      CircleButton(label: '.'),
    ];

    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [...numberButtons, ...lastRow],
        ),
      ),
    );
  }
}
