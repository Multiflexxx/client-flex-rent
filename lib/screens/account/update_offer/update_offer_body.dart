import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/widgets/camera/image_source.dart';
import 'package:rent/widgets/category/category_picker.dart';

import 'package:rent/widgets/formfieldstyled.dart';

class UpdateOfferBody extends StatefulWidget {
  final Offer offer;

  UpdateOfferBody({this.offer});

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
  List<Category> categoryList;

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

    Offer offer = await ApiOfferService()
        .updateOffer(updateOffer: updatedOffer, images: _deleteImageList);

    setState(() {
      _offer = offer;
      initFormValues();
    });
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
      Offer offer = await ApiOfferService()
          .addImage(offer: _offer, imagePath: image.path);

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
        Padding(
          padding: EdgeInsets.only(left: 28.0),
          child: Text(
            'Bilder',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21.0,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: new BoxDecoration(
            color: Color(0xFF202020),
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
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Feather.plus_circle,
                            color: Colors.purple,
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Icon(
                          Feather.minus_circle,
                          color: Colors.white,
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
        Padding(
          padding: EdgeInsets.only(left: 28.0),
          child: Text(
            'Beschreibung',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21.0,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: new BoxDecoration(
            color: Color(0xFF202020),
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
                    color: Color(0xFF202020),
                    textColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white),
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
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Speichern'),
                    onPressed: () {
                      _updateOffer();
                    },
                  ),
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
