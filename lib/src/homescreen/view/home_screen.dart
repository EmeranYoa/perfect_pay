import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/blocs/balance/bloc.dart';
import 'package:perfect_pay/common/blocs/balance/event.dart';
import 'package:perfect_pay/common/blocs/balance/state.dart';
import 'package:perfect_pay/common/utils/helpers.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/recharge_bottom_sheet.dart';
import 'package:perfect_pay/common/widgets/transaction_item_widget.dart';
import 'package:perfect_pay/gen/assets.gen.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/bloc.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/event.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/state.dart';
import 'package:perfect_pay/src/homescreen/view/action_widget.dart';

import '../../../common/models/transaction_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      description: 'Sent to Alice',
      date: DateTime.now().subtract(const Duration(days: 1)),
      amount: 50.0,
      isSent: true,
    ),
    Transaction(
      id: '2',
      description: 'Received from Bob',
      date: DateTime.now().subtract(const Duration(days: 2)),
      amount: 75.0,
      isSent: false,
    ),
    Transaction(
      id: '3',
      description: 'Sent to Charlie',
      date: DateTime.now().subtract(const Duration(days: 3)),
      amount: 20.0,
      isSent: true,
    ),
    Transaction(
      id: '4',
      description: 'Received from Dave',
      date: DateTime.now().subtract(const Duration(days: 4)),
      amount: 100.0,
      isSent: false,
    ),
    Transaction(
      id: '5',
      description: 'Sent to Eve',
      date: DateTime.now().subtract(const Duration(days: 5)),
      amount: 40.0,
      isSent: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch balance as soon as the screen is initialized.
    // If you encounter a context-related error, use addPostFrameCallback instead.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BalanceBloc>().add(GetBalance());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<BalanceBloc, BalanceState>(
              listener: (context, state) {
                if (state.error != null && state.error!.isNotEmpty) {
                  showCustomSnackbar(context, state.error!,
                      backgroundColor: Colors.red);
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return SizedBox(
                    height: 1.sh,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Kolor.kSecondary,
                      ),
                    ),
                  );
                }
                final balance = state.balance;
                final currency = state.currency;

                return Column(
                  children: [
                    Container(
                      height: 0.30.sh,
                      width: 1.sw,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Stack(
                        children: [
                          Container(
                            height: 0.25.sh,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Assets.images.bg.keyName),
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.2),
                                  offset: const Offset(5, 5),
                                  blurRadius: 15,
                                  spreadRadius: 0.5,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 30.h,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Boxicons.bx_wallet,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                " PerfectPay",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                " Balance",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: balance.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " $currency",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // showModalBottomSheet(
                                          //   context: context,
                                          //   isScrollControlled: true,
                                          //   isDismissible: false,
                                          //   backgroundColor: Colors.transparent,
                                          //   builder: (_) {
                                          //     return const RechargeBottomSheet();
                                          //   },
                                          // );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Kolor.kAccent,
                                          ),
                                        ),
                                        iconSize: 24.w,
                                        icon: Image.asset(
                                          Assets.images.fiRrSignOut.keyName,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Kolor.kAccent,
                                          ),
                                        ),
                                        iconSize: 24.w,
                                        icon: Image.asset(
                                          Assets.images.qrCode21.keyName,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                      ),
                                      // Existing NavigationBloc usage
                                      BlocBuilder<NavigationBloc,
                                          NavigationState>(
                                        builder: (context, navState) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<NavigationBloc>()
                                                  .add(
                                                      BottomNavItemSelected(1));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Kolor.kAccent,
                                              ),
                                            ),
                                            iconSize: 24.w,
                                            icon: Image.asset(
                                              Assets
                                                  .images.fiRrTimePast1.keyName,
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.h,
                            left: 0.30.sw,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Kolor.kAccent,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Boxicons.bx_plus_circle,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Recharge Wallet',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) {
                                    return const RechargeBottomSheet();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            // action button
            const ActionWidget(),

            //   5 last history
            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<NavigationBloc>()
                          .add(BottomNavItemSelected(1));
                    },
                    child: Text(
                      'view more',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Scrollable Transaction History List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: SizedBox(
                // Adjust the height as needed based on your design
                height: 250.h, // Example height; modify as necessary
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return TransactionItem(transaction: transaction);
                  },
                ),
              ),
            ),

            SizedBox(height: 20.h), // Extra spacing at the bottom
          ],
        ),
      ),
    );
  }
}
