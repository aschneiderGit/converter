import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AmountField extends StatefulWidget {
  final FieldType position;
  const AmountField({super.key, required this.position});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (widget.position != context.read<ConverterProvider>().selectedField) {
        context.read<ConverterProvider>().changeSelectedField(widget.position);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now access the provider to set the initial text
    controller.text = widget.position == FieldType.top
        ? context.watch<ConverterProvider>().topAmount ?? ''
        : context.watch<ConverterProvider>().bottomAmount ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
    super.dispose();
  }
}
