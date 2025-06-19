import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:week5/controller/transaction_controller.dart';

class AllStatiticsWidget extends StatefulWidget {
  const AllStatiticsWidget({super.key});

  @override
  State<AllStatiticsWidget> createState() => _AllStatiticsWidgetState();
}

class _AllStatiticsWidgetState extends State<AllStatiticsWidget> {
  Map<String, double> dataMap = {};
  @override
  void initState() {
    dataMap = {
      "Income":Provider.of<TransactionProvider>(context,listen: false).totalIncome.toDouble(),
      "Expense":Provider.of<TransactionProvider>(context,listen: false).totalExpense.toDouble(),
      // "Income": TransactionDb.instance.totalIncome.value.toDouble(),
      // "Expense": TransactionDb.instance.totalExpense.value.toDouble()
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: PieChart(
        
          chartRadius: 250,
          animationDuration: const Duration(seconds: 2),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesOutside: true,
            showChartValueBackground: false,
            showChartValuesInPercentage: true,
          ),
          legendOptions: const LegendOptions(
            showLegends: true,
            showLegendsInRow: false,
            legendPosition: LegendPosition.bottom,
          ),
          colorList: const [Color.fromARGB(255, 211, 31, 181), Colors.blue],
          dataMap: dataMap),
    );
  }
}
