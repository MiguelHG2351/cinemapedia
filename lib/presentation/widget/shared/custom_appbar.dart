import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon( Icons.movie_outlined, color: colors.primary, ),
            const SizedBox(width: 5,),
            Text('Cinemapedia', style: textStyles.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
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