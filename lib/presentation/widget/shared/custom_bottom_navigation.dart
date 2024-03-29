import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {

    void onItemTapped(BuildContext context, int index) {
      switch (index) {
        case 0:
          context.go('/home/0');
          break;
        case 1:
          context.go('/home/0');
          break;
        case 2:
          context.go('/home/2');
          break;
        default:
          context.go('/home/0');
          break;
      }
    }
    
    return BottomNavigationBar(
      elevation: 0,
      onTap: (value) => onItemTapped(context, value),
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos'
        ),
      ],
    );
  }
}