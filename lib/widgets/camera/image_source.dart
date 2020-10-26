import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent/widgets/slide_bar.dart';

class ImageSourcePicker extends StatelessWidget {
  final ScrollController scrollController;

  ImageSourcePicker({this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF202020),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SlideBar(),
            ListTile(
              title: Text(
                'Kamera',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              leading: Icon(
                Icons.camera_alt,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              title: Text(
                'Galerie',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              leading: Icon(
                Icons.photo,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
