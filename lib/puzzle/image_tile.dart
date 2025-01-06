import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imagePath;

  const ImageTile({required this.imagePath});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
    );
  }
}

