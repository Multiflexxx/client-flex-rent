import 'package:flexrent/widgets/slideIns/slide_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SlideIn extends StatelessWidget {
  /// Widget list that is contained in the slidein widget
  final List<Widget> widgetList;

  /// Boolean toggle for the top command in the safe area component
  final bool top;
  SlideIn({this.top, this.widgetList});

  @override
  Widget build(BuildContext context) {
    this.widgetList.insert(0, SlideBar());
    return Material(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        top: top ?? true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widgetList,
        ),
      ),
    );
  }
}
