import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class StandardSliverAppBarList extends StatelessWidget {
  final String title;
  final Widget bodyWidget;
  final List<Widget> actions;

  StandardSliverAppBarList({this.title, this.bodyWidget, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                return;
              },
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: Icon(Feather.arrow_left),
                iconSize: 30.0,
                color: Theme.of(context).primaryColor,
                onPressed: () => Navigator.pop(context),
              ),
              actions: actions,
              expandedHeight: 0.3 * MediaQuery.of(context).size.height,
              backgroundColor: Theme.of(context).backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                title: SafeArea(
                  child: SizedBox(
                    // 0.3 * 0.65 = 0.195
                    height: 0.195 * MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  bodyWidget,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
