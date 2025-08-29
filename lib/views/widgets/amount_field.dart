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

    // Value bound directly from provider
    final value = provider.amounts[position]?.value ?? '';

    // Create controller each build (stateless)
    final controller = TextEditingController(text: value);

    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus && position != context.read<ConverterProvider>().selectedField) {
        context.read<ConverterProvider>().changeSelectedField(position);
      }
    });

    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: Theme.of(context).textStyle.copyWith(fontSize: 30),
      keyboardType: TextInputType.none,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).secondary, width: 2)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).secondary, width: 2)),
        labelText: 'Enter your amount',
        labelStyle: Theme.of(context).textStyle,
      ),
    );
  }
}
