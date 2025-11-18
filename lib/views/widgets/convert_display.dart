import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_amount_filed.dart';
import 'package:converter/views/widgets/update_info/update_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvertDisplay extends StatefulWidget {
  final bool inRow;
  const ConvertDisplay({super.key, this.inRow = false});

  @override
  State<ConvertDisplay> createState() => _ConvertDisplayState();
}

class _ConvertDisplayState extends State<ConvertDisplay> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ConverterProvider>();
    final providerRead = context.read<ConverterProvider>();
    final ThemeData t = Theme.of(context);

    if (providerWatch.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final amounts = providerWatch.amounts;

    return Container(
      padding: EdgeInsets.only(top: 24),
      color: t.primary,
      child: Column(
        children: [
          Row(
            children: () {
              final childrenArray = [
                Flexible(
                  flex: 6,
                  child: Column(
                    children: [
                      CurrencyAmountField(context: context, position: FieldType.top, amounts: amounts),
                      SizedBox(height: 16),
                      CurrencyAmountField(context: context, position: FieldType.bottom, amounts: amounts),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: iconButton(
                      icon: Icons.swap_vert,
                      secondary: true,
                      size: 75,
                      iconSize: 60,
                      handleOnPressed: providerRead.toggleAmount,
                    ),
                  ),
                ),
              ];
              return widget.inRow ? childrenArray.reversed.toList() : childrenArray;
            }(),
          ),
          Expanded(child: UpdateInfo()),
        ],
      ),
    );
  }
}
