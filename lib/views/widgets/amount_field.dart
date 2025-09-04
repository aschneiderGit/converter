import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AmountField extends StatelessWidget {
  final FieldType position;

  const AmountField({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    final value = provider.amounts[position]?.value ?? '';

    final controller = TextEditingController(text: value);

    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus && position != context.read<ConverterProvider>().selectedField) {
        context.read<ConverterProvider>().changeSelectedField(position);
      }
    });

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: t.textStyle.copyWith(fontSize: 40),
        keyboardType: TextInputType.none,
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary, width: 2)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary, width: 2)),
          labelText: l.enterAmount,
          labelStyle: t.textStyle,
        ),
      ),
    );
  }
}
