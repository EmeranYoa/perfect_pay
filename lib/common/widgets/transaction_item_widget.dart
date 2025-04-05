import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';

import '../models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(transaction.date);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon based on transaction type
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: transaction.isSent
                  ? Kolor.kAccent.withOpacity(0.1)
                  : Kolor.kSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              transaction.isSent
                  ? Boxicons.bx_arrow_from_left
                  : Boxicons.bx_arrow_from_right,
              color: transaction.isSent ? Kolor.kAccent : Kolor.kSecondary,
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            '${transaction.isSent ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: transaction.isSent ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
