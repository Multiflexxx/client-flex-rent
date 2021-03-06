import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/widgets/boxes/headline.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/calendar/calendar.dart';
import 'package:flexrent/widgets/camera/image_source.dart';
import 'package:flexrent/widgets/category/category_picker.dart';

import 'package:flexrent/widgets/styles/formfield_styled.dart';

class UpdateOfferBody extends StatefulWidget {
  final Offer offer;
  final VoidCallback updateParentFunction;

  UpdateOfferBody({this.offer, this.updateParentFunction});

  @override
  _UpdateOfferBodyState createState() => _UpdateOfferBodyState();
}

class _UpdateOfferBodyState extends State<UpdateOfferBody> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descritpionController = TextEditingController();
  final _priceController = TextEditingController();

  List<String> _imageList;
  List<String> _deleteImageList;
  Offer _offer;

  Category _category;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _offer = widget.offer;
    initFormValues();
  }

  void initFormValues() {
    _deleteImageList = new List<String>();
    _imageList = _offer.pictureLinks;
    _titleController.text = _offer.title;
    _descritpionController.text = _offer.description;
    _priceController.text = _offer.price.toString();
    _category = _offer.category;
  }

  void _selectCategory({BuildContext parentContext}) async {
    final Category _selectedCategory = await showCupertinoModalBottomSheet(
      expand: false,
      useRootNavigator: true,
      context: context,
      barrierColor: Colors.black45,
      builder: (context, scrollController) => CategoryPicker(
        scrollController: scrollController,
      ),
    );
    if (_selectedCategory != null) {
      setState(() {
        _category = _selectedCategory;
      });
    }
  }

  void _updateOffer() async {
    Offer updatedOffer = Offer(
      offerId: _offer.offerId,
      title: _titleController.text,
      description: _descritpionController.text,
      category: _category,
      price: double.parse(_priceController.text),
    );

    try {
      Offer offer = await ApiOfferService()
          .updateOffer(updateOffer: updatedOffer, images: _deleteImageList);

      setState(() {
        _offer = offer;
        initFormValues();
      });
      widget.updateParentFunction();
      showFlushbar(context: context, message: 'Erfoglreich bearbeitet!');
    } on OfferException catch (e) {
      showFlushbar(context: context, message: e.message);
    }
  }

  void _deleteImage({String imagePath}) {
    setState(() {
      _imageList.remove(imagePath);
      _deleteImageList.add(imagePath);
    });
  }

  void _selectImageSource({BuildContext parentContext}) async {
    final ImageSource source = await showCupertinoModalBottomSheet(
      expand: false,
      useRootNavigator: true,
      context: context,
      barrierColor: Colors.black45,
      builder: (context, scrollController) => ImageSourcePicker(
        scrollController: scrollController,
      ),
    );
    _addImage(source: source);
  }

  void _addImage({ImageSource source}) async {
    final image = await picker.getImage(source: source);
    if (image != null) {
      final _image = await HelperService.compressFile(File(image.path));

      Offer offer = await ApiOfferService()
          .addImage(offer: _offer, imagePath: _image.path);

      setState(() {
        _offer = offer;
        initFormValues();
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Headline(
          headline: 'Bilder',
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 180.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == _imageList.length) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () => _selectImageSource(parentContext: context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Feather.plus_circle,
                            color: Theme.of(context).accentColor,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _deleteImage(imagePath: _imageList[index]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: _imageList[index],
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Icon(
                          Feather.minus_circle,
                          color: Theme.of(context).primaryColor,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Headline(
          headline: 'Verfügbarkeit',
        ),
        GestureDetector(
          onTap: () => showCupertinoModalBottomSheet<dynamic>(
            expand: true,
            useRootNavigator: true,
            context: context,
            barrierColor: Colors.black45,
            builder: (context, scrollController) => Calendar(
              scrollController: scrollController,
              offer: _offer,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Feather.calendar,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Verfügbarkeit verändern',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Icon(
                  Ionicons.ios_arrow_forward,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Headline(
          headline: 'Beschereibung',
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormFieldStyled(
                  controller: _titleController,
                  hintText: "Produktname",
                  autocorrect: true,
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).cardColor,
                    textColor: Theme.of(context).primaryColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _category.name,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    onPressed: () => _selectCategory(parentContext: context),
                  ),
                ),
                SizedBox(height: 16.0),
                FormFieldStyled(
                  controller: _descritpionController,
                  hintText: "Beschreibung",
                  autocorrect: true,
                  maxLines: 8,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FormFieldStyled(
                        controller: _priceController,
                        hintText: "Preis",
                        autocorrect: true,
                        type: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: Text('€ Pro Tag',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                PurpleButton(
                  text: Text('Speichern'),
                  onPressed: () {
                    _updateOffer();
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 75.0,
        ),
      ],
    );
  }
}
