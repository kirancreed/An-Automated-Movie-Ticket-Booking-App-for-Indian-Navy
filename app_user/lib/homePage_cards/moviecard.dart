import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final Function onTap;

  const MovieCard({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 300,
        width: MediaQuery.of(context).size.width - 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
