import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class RatingScreen extends StatelessWidget {
  final User lessor;
  final VoidCallback updateParentFunction;

  static String routeName = 'ratingScreen';

  RatingScreen({Key key, this.updateParentFunction, this.lessor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Produkt einstellen',
      bodyWidget: _RatingBody(
        updateParentFunction: updateParentFunction,
      ),
    );
  }
}

class _RatingBody extends StatefulWidget {
  final VoidCallback updateParentFunction;
  const _RatingBody({Key key, this.updateParentFunction}) : super(key: key);
  @override
  _RatingBodyState createState() => _RatingBodyState();
}

http.Response apiResult;

class _RatingBodyState extends State<_RatingBody> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _starController = TextEditingController();
  final _descriptionController = TextEditingController();

  AutovalidateMode _validateMode;
  @override
  void initState() {
    super.initState();
    _validateMode = AutovalidateMode.disabled;
  }

  void _createRating() async {
    setState(() {
      _validateMode = AutovalidateMode.always;
    });
    if (_key.currentState.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
        key: _key,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bewertung des Vermieters',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26.0,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Theme.of(context).accentColor),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ]),
          SizedBox(height: 16.0),
          Text(
            'Schreibe einen Titel zu deiner Bewertung',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              height: 1.35,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.0),
          FormFieldStyled(
            controller: _titleController,
            hintText: "Kurzfassung",
            autocorrect: true,
          ),
          SizedBox(height: 16.0),
          Text(
            'Schreibe deine Bewertung so ausführlich wie du möchtest. Du kannst den Kontakt und die Qulität des Produktes beschreiben.',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              height: 1.35,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.0),
          FormFieldStyled(
            controller: _descriptionController,
            hintText: "Wie zufrieden warst du mit dem Vermieter?",
            autocorrect: true,
            maxLines: 8,
          ),
          SizedBox(height: 16.0),
          PurpleButton(
            text: Text('Speichern'),
            onPressed: () {
              _createRating();
            },
          ),
          // SizedBox(height: 10.0),
          // TransparentButton(
          //   text: Text('Abbrechen'),
          //   onPressed: () {
          //     return;
          //   },
          // ),
        ]),
      ),
    );
  }
}
