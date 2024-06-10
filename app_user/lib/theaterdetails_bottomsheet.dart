import 'package:flutter/material.dart';

class TheaterDetailBottomSheet extends StatelessWidget {
  TheaterDetailBottomSheet();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                'Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 20, right: 20, bottom: 10),
              child: Text(
                'Naval Base Theatre, Willingdon Island, Kochi, Kerala 682003',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Theater Photos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPhotoContainer(context, 'assets/pic3.jpg'),
                  _buildPhotoContainer(context, 'assets/pic2.jpg'),
                  _buildPhotoContainer(context, 'assets/pic1.jpg'),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.asset(imagePath),
        );
      },
    );
  }

  Widget _buildPhotoContainer(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, imagePath);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            width: 150,
            height: 150,
            fit: BoxFit.fill, // or BoxFit.contain based on your preference
          ),
        ),
      ),
    );
  }
}
