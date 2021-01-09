import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PictureDetailView extends StatefulWidget {
  final List<String> pictures;

  PictureDetailView({this.pictures});

  @override
  _PictureDetailViewState createState() => _PictureDetailViewState();
}

class _PictureDetailViewState extends State<PictureDetailView> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: widget.pictures.map((pictureLink) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: CachedNetworkImage(
                      imageUrl: pictureLink,
                      height: 180.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Icon(
                        Icons.error,
                        color: Theme.of(context).primaryColor,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.pictures == null
                ? [
                    Image(
                      image: AssetImage('assets/images/noimage.png'),
                      height: 180.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                    )
                  ]
                : widget.pictures.map((pictureLink) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: CachedNetworkImage(
                            imageUrl: pictureLink,
                            height: 180.0,
                            width: 180.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Icon(
                              Icons.error,
                              color: Theme.of(context).primaryColor,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
  */
}
