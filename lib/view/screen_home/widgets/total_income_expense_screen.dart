import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/controller/transaction_controller.dart';
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
          Color(0xFFB2DFDB),
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
              offset: const Offset(3, 3),
            ),
          ],
        ),
        width: double.infinity,
        height: 175,
        child: Column(
          children: [
            // Current Balance Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.balance_rounded),
                SizedBox(width: 5),
                Text(
                  "Current Balance",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2F2F2F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Consumer<TransactionProvider>(
              builder: (context, value, child) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      const Icon(Icons.currency_rupee),
                      Text(
                        value.currentBalance.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Income & Expense Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Income Section (Shifted More Left)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IncomeText(
                      icon: Icons.arrow_circle_up_outlined,
                      iconcolor: Color(0xFF388E3C),
                    ),
                    const SizedBox(height: 5),
                    Consumer<TransactionProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            const Icon(Icons.currency_rupee_sharp, size: 18),
                            Text(
                              value.totalIncome.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const ExpenseText(
                      icon: Icons.arrow_circle_down_outlined,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 5),
                    Consumer<TransactionProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            const Icon(Icons.currency_rupee_sharp, size: 18),
                            Text(
                              value.totalExpense.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(20),
    //   margin: const EdgeInsets.all(20),
    //   width: double.infinity,
    //   height: 220,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16),
    //     gradient: const LinearGradient(colors: [
    //       Color(0xFFB2DFDB),
    //       Color(0xFF80CBC4),
    //     ]),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2),
    //         spreadRadius: 2,
    //         blurRadius: 10,
    //         offset: const Offset(0, 4),
    //       ),
    //     ],
    //   ),
    //   child: Container(
    //     padding: const EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //         color: Colors.white.withOpacity(0.1),
    //         borderRadius: BorderRadius.circular(16),
    //         boxShadow: [
    //           BoxShadow(
    //               color: Colors.black.withOpacity(0.02),
    //               spreadRadius: 1,
    //               blurRadius: 5,
    //               offset: const Offset(
    //                 3,
    //                 3,
    //               )),
    //         ]),
    //     width: double.infinity,
    //     height: 175,
    //     child: Column(
    //       children: [
    //         const Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(Icons.balance),
    //             Text(
    //               "Current Balance",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   color: Color(0xFF2F2F2F),
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 5,
    //         ),
    //         Consumer<TransactionProvider>(
    //           builder: (context, value, child) {
    //             return Expanded(
    //               child: FittedBox(
    //                 fit: BoxFit.scaleDown,
    //                 child: Row(
    //                   children: [
    //                     const Icon(Icons.currency_rupee),
    //                     Text(
    //                       value.currentBalance.toString(),
    //                       style: const TextStyle(
    //                           fontSize: 20,
    //                           color: Color(0xFF212121),
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         const Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             IncomeText(
    //                 icon: Icons.arrow_circle_up_outlined,
    //                 iconcolor: Color(0xFF388E3C)),
    //             ExpenseText(
    //               icon: Icons.arrow_circle_down_outlined,
    //               color: Colors.red,
    //             ),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 5,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Consumer<TransactionProvider>(
    //               builder: (context, value, child) {
    //                 return Expanded(
    //                   child: FittedBox(
    //                     fit: BoxFit.scaleDown,
    //                     child: Row(
    //                       children: [
    //                         const Icon(Icons.currency_rupee_sharp),
    //                         Text(
    //                           value.totalIncome.toString(),
    //                           style: const TextStyle(
    //                             fontSize: 20,
    //                             color: Color(0xFF212121),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //             const SizedBox(
    //               width: 10,
    //             ),
    //             Consumer<TransactionProvider>(
    //               builder: (context, value, child) {
    //                 return Expanded(
    //                   child: FittedBox(
    //                     fit: BoxFit.scaleDown,
    //                     child: Row(
    //                       children: [
    //                         const Icon(Icons.currency_rupee_sharp),
    //                         Text(
    //                           value.totalExpense.toString(),
    //                           style: const TextStyle(
    //                             fontSize: 20,
    //                             color: Color(0xFF212121),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
