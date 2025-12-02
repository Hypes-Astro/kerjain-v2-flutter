import 'package:flutter/material.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/features/Presentation/Pages/History/HistoryView.dart';
import 'package:kerjain/features/Presentation/Pages/Home/HomeView.dart';

class BottomNavigationComp extends StatefulWidget {
  const BottomNavigationComp({super.key});

  @override
  State<BottomNavigationComp> createState() => _BottomNavigationCompState();
}

class _BottomNavigationCompState extends State<BottomNavigationComp> {
  int myCurrentIndex = 0;

  final List<Widget> pages = const [HomeView(), HistoryView()];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const navWidth = 220.0; // lebar yang kamu mau
    final horizontalPadding = (screenWidth - navWidth) / 2;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[myCurrentIndex],
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.white,
                currentIndex: myCurrentIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                onTap: (index) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    label: '',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: myCurrentIndex == 0
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.home_outlined,
                        size: 22,
                        color: myCurrentIndex == 0
                            ? Colors.black
                            : AppColors.black,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: myCurrentIndex == 1
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.all_inbox_outlined,
                        size: 22,
                        color: myCurrentIndex == 1
                            ? Colors.black
                            : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
