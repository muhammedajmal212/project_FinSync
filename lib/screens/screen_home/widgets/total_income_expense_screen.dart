import 'package:flutter/material.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/widgets/expense_text.dart';
import 'package:week5/widgets/income_text.dart';

class TotalIncomeExpenseScreen extends StatefulWidget {
  const TotalIncomeExpenseScreen({super.key});

  @override
  State<TotalIncomeExpenseScreen> createState() =>
      _TotalIncomeExpenseScreenState();
}

class _TotalIncomeExpenseScreenState extends State<TotalIncomeExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [
        
          // Color(0xFFCCE5E3), // Soft Teal
          //   Color(0xFFFEE1B6),
         Color(0xFFB2DFDB),  // Light teal
      Color(0xFF80CBC4), 
          
           
         
          ]),
         boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
          
          ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset:const  Offset(3, 3, ))
            ]),
        width: double.infinity,
        height: 175,
        child: Column(
          children: [
            const Text(
              "Current Balance",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF2F2F2F),
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ValueListenableBuilder(
              valueListenable: TransactionDb.instance.currentBalance,
              builder: (context, value, child) {
                return Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      TransactionDb.instance.currentBalance.value.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomeText(
                  icon: Icons.arrow_circle_up_outlined,
                  iconcolor:Color(0xFF388E3C)
                ),
                ExpenseText(
                  icon: Icons.arrow_circle_down_outlined,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: TransactionDb.instance.totalIncome,
                  builder: (context, value, child) {
                    return Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          TransactionDb.instance.totalIncome.value.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color:Color(0xFF212121),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ValueListenableBuilder(
                  valueListenable: TransactionDb.instance.totalExpense,
                  builder: (context, value, child) {
                    return Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          TransactionDb.instance.totalExpense.value.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
