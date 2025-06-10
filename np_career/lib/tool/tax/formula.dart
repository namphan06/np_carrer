import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/tool/courses/providers/FormulaProvider.dart';
import 'package:provider/provider.dart';

class TaxCalculatorScreen extends StatefulWidget {
  const TaxCalculatorScreen({super.key});

  @override
  State<TaxCalculatorScreen> createState() => _TaxCalculatorScreenState();
}

class _TaxCalculatorScreenState extends State<TaxCalculatorScreen> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _dependentController = TextEditingController();
  double taxResult = 0.0;
  final numberFormat = NumberFormat('#,###', 'en_US');

  void _calculateTax(FormulaProvider provider) {
    if (_incomeController.text.isEmpty || _dependentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all information.')),
      );
      return;
    }

    final rawIncome = _incomeController.text.replaceAll(RegExp(r'[^\d]'), '');
    final income = int.tryParse(rawIncome) ?? 0;
    final dependents = int.tryParse(_dependentController.text) ?? 0;

    print('income: $income, dependents: $dependents');

    final deductionPerDependent =
        double.tryParse(provider.deductions[1]['value'].toString()) ?? 0.0;
    final personalDeduction =
        double.tryParse(provider.deductions[0]['value'].toString()) ?? 0.0;

    double adjustedIncome = income - (dependents * deductionPerDependent);

    if (adjustedIncome <= personalDeduction) {
      setState(() => taxResult = 0.0);
      return;
    }

    adjustedIncome -= personalDeduction;
    double result = 0.0;

    for (var c in provider.rows) {
      final min = int.tryParse(c['min'].toString()) ?? 0;
      final max = int.tryParse(c['max'].toString()) ?? 0;
      final rate = int.tryParse(c['value'].toString()) ?? 0;

      print('Bracket: min=$min, max=$max, rate=$rate');
      print('Deduction: $deductionPerDependent, Personal: $personalDeduction');

      if (adjustedIncome > max) {
        result += (max - min) * (rate / 100);
      } else if (adjustedIncome > min) {
        result += (adjustedIncome - min) * (rate / 100);
        break;
      }
    }

    setState(() => taxResult = double.parse(result.toStringAsFixed(2)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormulaProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Income Tax Calculator'),
            centerTitle: true,
            backgroundColor: AppColor.orangePrimaryColor,
            foregroundColor: Colors.white,
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _incomeController,
                        builder: (context, value, _) {
                          String input =
                              value.text.replaceAll(RegExp(r'[^\d]'), '');
                          int? raw = int.tryParse(input);
                          String formatted = '';
                          if (raw != null) {
                            int calculated = raw * 1000000;
                            formatted =
                                '${numberFormat.format(calculated)} VND';
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _incomeController,
                                decoration: const InputDecoration(
                                    labelText: 'Total Income (in million)'),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 4),
                              if (formatted.isNotEmpty)
                                Text(
                                  formatted,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _dependentController,
                        decoration: const InputDecoration(
                            labelText: 'Number of Dependents'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _calculateTax(provider),
                        child: const Text('Calculate Tax'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Calculated Tax: ${numberFormat.format((taxResult * 1000000).toInt())} VND',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 32),
                      const Text(
                        'Deductions:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DataTable(
                          columnSpacing: 15,
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Value')),
                          ],
                          rows: provider.deductions
                              .map<DataRow>((deduction) => DataRow(
                                    cells: [
                                      DataCell(
                                          Text(deduction['title'].toString())),
                                      DataCell(
                                        Text(
                                            '${numberFormat.format((double.tryParse(deduction['value'].toString()) ?? 0) * 1000000)} VND'),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Income Tax Brackets:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 50,
                            columns: const [
                              DataColumn(label: Text('From')),
                              DataColumn(label: Text('To')),
                              DataColumn(label: Text('Tax Rate')),
                            ],
                            rows: provider.rows
                                .map<DataRow>((row) => DataRow(
                                      cells: [
                                        DataCell(Text(
                                            '${numberFormat.format((int.tryParse(row['min'].toString()) ?? 0) * 1000000)} VND')),
                                        DataCell(Text(
                                            '${numberFormat.format((int.tryParse(row['max'].toString()) ?? 0) * 1000000)} VND')),
                                        DataCell(Text('${row['value']}%')),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
