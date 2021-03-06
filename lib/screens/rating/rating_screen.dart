import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatelessWidget {
  final User ratedUser;
  final Offer offer;
  final String ratingType;
  final Rating rating;
  final VoidCallback updateParentFunction;

  static String routeName = 'ratingScreen';

  RatingScreen({
    Key key,
    this.updateParentFunction,
    this.ratedUser,
    this.offer,
    this.ratingType,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: ratingType == 'lessor' || ratingType == 'lessee'
          ? ratedUser.firstName + ' ' + ratedUser.lastName
          : offer.title,
      bodyWidget: _RatingBody(
        offer: offer,
        updateParentFunction: updateParentFunction,
        ratedUser: ratedUser,
        ratingType: ratingType,
        rating: rating,
      ),
    );
  }
}

class _RatingBody extends StatefulWidget {
  final User ratedUser;
  final Offer offer;
  final String ratingType;
  final VoidCallback updateParentFunction;
  final Rating rating;

  const _RatingBody({
    Key key,
    this.updateParentFunction,
    this.ratedUser,
    this.offer,
    this.ratingType,
    this.rating,
  }) : super(key: key);

  @override
  _RatingBodyState createState() => _RatingBodyState();
}

class _RatingBodyState extends State<_RatingBody> {
  final _key = GlobalKey<FormState>();
  final _headlineController = TextEditingController();
  final _textController = TextEditingController();
  int _starRating;

  AutovalidateMode _validateMode;
  @override
  void initState() {
    super.initState();
    _validateMode = AutovalidateMode.disabled;
    _starRating = 0;
    if (widget.rating != null) {
      initFormFields();
    }
  }

  void initFormFields() {
    _headlineController.text = widget.rating.headline;
    _textController.text = widget.rating.ratingText;
    _starRating = widget.rating.rating;
  }

  void _createRating() async {
    setState(() {
      _validateMode = AutovalidateMode.always;
    });

    if (_key.currentState.validate() && _starRating > 0 && _starRating < 6) {
      if (widget.ratingType == 'lessor' || widget.ratingType == 'lessee') {
        try {
          UserRating newRating;
          if (widget.rating == null) {
            newRating = await ApiUserService().createUserRating(
              ratedUser: widget.ratedUser,
              ratingType: widget.ratingType,
              headline: _headlineController.text,
              text: _textController.text,
              rating: _starRating,
            );
          } else {
            newRating = await ApiUserService().updateUserRating(
              ratingId: widget.rating.ratingId,
              ratedUser: widget.ratedUser,
              ratingType: widget.ratingType,
              headline: _headlineController.text,
              text: _textController.text,
              rating: _starRating,
            );
          }
          Navigator.of(context).pop(newRating);
        } on UserRatingException catch (e) {
          showFlushbar(context: context, message: e.message);
        }
      } else if (widget.ratingType == 'offer') {
        try {
          OfferRating newRating;
          if (widget.rating == null) {
            newRating = await ApiOfferService().createOfferRating(
              offer: widget.offer,
              rating: _starRating,
              headline: _headlineController.text,
              ratingText: _textController.text,
            );
          } else {
            newRating = await ApiOfferService().updateOfferRating(
              offer: widget.offer,
              rating: _starRating,
              headline: _headlineController.text,
              ratingText: _textController.text,
            );
          }

          Navigator.of(context).pop(newRating);
        } on OfferRatingException catch (e) {
          showFlushbar(context: context, message: e.message);
        }
      } else {
        print('Exception');
      }
    }
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
                widget.ratingType == 'lessor'
                    ? 'Bewerte den Vermieter'
                    : widget.ratingType == 'lessee'
                        ? 'Bewerte den Mieter'
                        : 'Bewerte das Produkt',
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
              initialRating: _starRating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Theme.of(context).accentColor),
              onRatingUpdate: (rating) {
                setState(() {
                  _starRating = rating.toInt();
                });
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
            controller: _headlineController,
            hintText: "Kurzfassung",
            autocorrect: true,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Titel notwendig, wenn du eine Beschreibung erstellt hast.';
              }
            },
          ),
          SizedBox(height: 16.0),
          Text(
            'Schreibe deine Bewertung so ausführlich wie du möchtest.',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              height: 1.35,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.0),
          FormFieldStyled(
            controller: _textController,
            hintText: "Wie zufrieden warst du mit dem Prozess?",
            autocorrect: true,
            maxLines: 8,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Beschreibung notwendig, wenn du einen Titel festgelgt hast';
              }
            },
          ),
          SizedBox(height: 16.0),
          PurpleButton(
            text: Text('Speichern'),
            onPressed: () {
              _createRating();
            },
          ),
        ]),
      ),
    );
  }
}
