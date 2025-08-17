import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AmountField extends StatefulWidget {
  final FieldType position;
  final String value;
  const AmountField({super.key, required this.position, required this.value});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    focusNode.addListener(_focusListener);
  }

  void _focusListener() {
    if (widget.position != context.read<ConverterProvider>().selectedField) {
      context.read<ConverterProvider>().changeSelectedField(widget.position);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.value;
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

  @override
  void dispose() {
    controller.dispose();
    focusNode.removeListener(_focusListener);
    super.dispose();
  }
}
