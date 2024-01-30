import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon( Icons.movie_outlined ),
            const SizedBox(width: 5,),
            const Text('Cinemapedia'),
            const Spacer(),
            IconButton(onPressed: () {

            }, 
            icon: const Icon(Icons.search))
          ],
        ),
      ),
    );
  }
}