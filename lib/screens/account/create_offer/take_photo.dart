import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/screens/account/create_offer/upload_image.dart';

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

  void _captureImage(context) async {
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await _controller.takePicture(path);
      pushNewScreen(
        context,
        screen: DisplayImageScreen(
          offer: widget.offer,
          imagePath: path,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Stack(
                children: <Widget>[
                  CameraPreview(_controller),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 80.0,
                      padding: EdgeInsets.all(20.0),
                      color: Color.fromRGBO(00, 00, 00, 0.7),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  child: Icon(
                                    Feather.arrow_left,
                                    color: Colors.purple,
                                    size: 36.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                onTap: () {
                                  _captureImage(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.purple,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}

class DisplayImageScreen extends StatefulWidget {
  final String imagePath;
  final Offer offer;

  const DisplayImageScreen({Key key, this.imagePath, this.offer})
      : super(key: key);

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  bool _visible;

  @override
  void initState() {
    super.initState();
    _visible = true;
  }

  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () => _toggleVisibility(),
              child: Image.file(File(widget.imagePath)),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 50.0,
                color: Color.fromRGBO(00, 00, 00, 1),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              child: Icon(
                                Feather.arrow_left,
                                color: Colors.purple,
                                size: 36.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () => pushNewScreen(
                              context,
                              screen: UploadImageScreen(
                                offer: widget.offer,
                                imagePath: widget.imagePath,
                              ),
                            ),
                            child: Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.purple,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
