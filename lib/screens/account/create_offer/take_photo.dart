import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';

class TakePhoto extends StatefulWidget {
  final Offer offer;
  final CameraDescription camera;

  const TakePhoto({Key key, this.offer, this.camera}) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Positioned(
              left: 5.0,
              child: FloatingActionButton(
                child: Icon(
                  Feather.arrow_left,
                  color: Colors.purple,
                ),
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              // left: MediaQuery.of(context).size.width / 2,
              left: 0.0,
              right: 0.0,
              child: FloatingActionButton(
                child: Icon(
                  Icons.camera,
                  color: Colors.purple,
                ),
                backgroundColor: Colors.black,
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final path = join(
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );
                    await _controller.takePicture(path);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                            offer: widget.offer, imagePath: path),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CameraPreview(_controller),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // cameraToggle(),
                          cameraControl(context),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera_alt),
      //   onPressed: () async {
      //     try {
      //       await _initializeControllerFuture;
      //       final path = join(
      //         (await getTemporaryDirectory()).path,
      //         '${DateTime.now()}.png',
      //       );
      //       await _controller.takePicture(path);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>
      //               DisplayPictureScreen(offer: widget.offer, imagePath: path),
      //         ),
      //       );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      // ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Offer offer;

  const DisplayPictureScreen({Key key, this.imagePath, this.offer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.file(File(imagePath),
                height: 200, width: 300, fit: BoxFit.cover),
          ),
          RaisedButton(
            onPressed: () =>
                ApiOfferService().addImage(offer: offer, imagePath: imagePath),
            child: Text('Bild hinzufügen.'),
          )
        ],
      ),
    );
  }
}
