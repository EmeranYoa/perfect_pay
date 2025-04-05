import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/bloc.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/event.dart';

class ActionButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ink(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 0.1,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(15.r),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(label),
      ],
    );
  }
}

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            iconPath: 'assets/images/send.png',
            label: 'Send',
            onPressed: () {
              // TODO: handle Send action
            },
          ),
          ActionButton(
            iconPath: 'assets/images/received.png',
            label: 'Received',
            onPressed: () {
              // TODO: handle Received action
            },
          ),
          ActionButton(
            iconPath: 'assets/images/history.png',
            label: 'History',
            onPressed: () {
              context.read<NavigationBloc>().add(BottomNavItemSelected(1));
            },
          ),
          ActionButton(
            iconPath: 'assets/images/Chek balance.png',
            label: 'A/c Balance',
            onPressed: () {
              // TODO: handle A/c Balance action
            },
          ),
        ],
      ),
    );
  }
}
