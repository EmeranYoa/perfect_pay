import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/brand_text.dart';
import 'package:perfect_pay/src/bankscreen/view/bank_screen.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/bloc.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/event.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/state.dart';
import 'package:perfect_pay/src/historyscreen/view/history_screen.dart';
import 'package:perfect_pay/src/homescreen/view/home_screen.dart';
import 'package:perfect_pay/src/settings/settings_screen.dart';

// Import your NavigationBloc-related files
// import 'navigation_bloc.dart'; // Example: 'path/to/navigation_bloc.dart'

class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    HistoryScreen(),
    BankScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconItemColor = Colors.grey.withOpacity(0.5);

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: BrandText(
              fontSize: 23.48.sp,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Boxicons.bx_bell,
                  color: Kolor.kPrimary,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              // Use the currentIndex from the bloc state to select the page
              _pages[state.currentIndex],

              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: RPSCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.4,
                        child: FloatingActionButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Kolor.kPrimary,
                          child: const Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<NavigationBloc>()
                                    .add(BottomNavItemSelected(0));
                              },
                              icon: Icon(
                                Boxicons.bxs_home_circle,
                                color: state.currentIndex == 0
                                    ? Kolor.kPrimary
                                    : iconItemColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<NavigationBloc>()
                                    .add(BottomNavItemSelected(1));
                              },
                              icon: Icon(
                                Boxicons.bx_transfer_alt,
                                color: state.currentIndex == 1
                                    ? Kolor.kPrimary
                                    : iconItemColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.20,
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<NavigationBloc>()
                                    .add(BottomNavItemSelected(2));
                              },
                              icon: Icon(
                                Boxicons.bxs_bank,
                                color: state.currentIndex == 2
                                    ? Kolor.kPrimary
                                    : iconItemColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<NavigationBloc>()
                                    .add(BottomNavItemSelected(3));
                              },
                              icon: Icon(
                                Boxicons.bxs_user,
                                color: state.currentIndex == 3
                                    ? Kolor.kPrimary
                                    : iconItemColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0006250, size.height * 0.9925000);
    path_0.lineTo(size.width * 0.0006250, size.height * -0.0350000);
    path_0.quadraticBezierTo(
      size.width * -0.0025000,
      size.height * 0.2129000,
      size.width * 0.0631250,
      size.height * 0.2167000,
    );
    path_0.cubicTo(
      size.width * 0.1484375,
      size.height * 0.2180000,
      size.width * 0.2840625,
      size.height * 0.2103000,
      size.width * 0.3756250,
      size.height * 0.2142000,
    );
    path_0.cubicTo(
      size.width * 0.4300000,
      size.height * 0.2193000,
      size.width * 0.4264125,
      size.height * 0.5761000,
      size.width * 0.5000000,
      size.height * 0.5913000,
    );
    path_0.cubicTo(
      size.width * 0.5753125,
      size.height * 0.5824000,
      size.width * 0.5693750,
      size.height * 0.2330000,
      size.width * 0.6262500,
      size.height * 0.2169000,
    );
    path_0.cubicTo(
      size.width * 0.7157875,
      size.height * 0.2057000,
      size.width * 0.8525000,
      size.height * 0.2219000,
      size.width * 0.9381250,
      size.height * 0.2219000,
    );
    path_0.quadraticBezierTo(
      size.width * 0.9993750,
      size.height * 0.2193000,
      size.width * 1.0006250,
      size.height * -0.0350000,
    );
    path_0.lineTo(size.width * 1.0006250, size.height * 0.9900000);
    path_0.lineTo(size.width * 0.0006250, size.height * 0.9925000);
    path_0.close();

    // Draw shadow
    canvas.drawShadow(path_0, Colors.black, 20, false);

    // Draw main shape
    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
