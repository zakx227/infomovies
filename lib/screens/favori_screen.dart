import 'package:flutter/material.dart';
import 'package:infomovis/utils/constants.dart';

class FavoriScreen extends StatelessWidget {
  const FavoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            'FavoriteFilms',
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
