import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/widgets/slide_bar.dart';
class DescriptionBox extends StatelessWidget {
  final description;
 final title;
  DescriptionBox({this.description, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AutoSizeText(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            height: 1.35,
            fontWeight: FontWeight.w300,
          ),
          minFontSize: 16.0,
          maxLines: 6,
          overflowReplacement: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  height: 1.25,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              GestureDetector(
                onTap: () => showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    barrierColor: Colors.black45,
                    builder: (context, scrollController) => Material(
                          color: Color(0xFF202020),
                          child: SafeArea(
                            top: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SlideBar(),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            height: 1.35,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        description,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          height: 1.35,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        )
                    //     ProductDescription(
                    //   offer: widget.rentProduct,
                    //   scrollController: scrollController,
                    // ),
                    ),
                child: Text(
                  "Show more",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}