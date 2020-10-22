import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/widgets/camera/image_source.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class UpdateOfferScreen extends StatefulWidget {
  final Offer offer;

  UpdateOfferScreen({this.offer});

  @override
  _UpdateOfferScreenState createState() => _UpdateOfferScreenState();
}

class _UpdateOfferScreenState extends State<UpdateOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descritpionController = TextEditingController();
  final _priceController = TextEditingController();

  Offer _offer;
  List<String> imageList;
  List<String> deleteImageList = new List<String>();
  Future<List<Category>> categoryList;
  Category _category;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    categoryList = ApiOfferService().getAllCategory();
    imageList = widget.offer.pictureLinks;
    _titleController.text = widget.offer.title;
    _descritpionController.text = widget.offer.description;
    _priceController.text = widget.offer.price.toString();
  }

  void _updateOffer() async {
    Offer updatedOffer = Offer(
      offerId: widget.offer.offerId,
      title: _titleController.text,
      description: _descritpionController.text,
      category: _category,
      price: double.parse(_priceController.text),
    );

    offer = await ApiOfferService()
        .updateOffer(updateOffer: updatedOffer, images: deleteImageList);
  }

  void _deleteImage({String imagePath}) {
    setState(() {
      imageList.remove(imagePath);
      deleteImageList.add(imagePath);
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
      // final _image = File(image.path);
      ApiOfferService().addImage(offer: offer, imagePath: image.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 180.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == imageList.length) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: GestureDetector(
                                      onTap: () => _selectImageSource(
                                          parentContext: context),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF202020),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Stack(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _deleteImage(
                                              imagePath: imageList[index]);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: CachedNetworkImage(
                                            imageUrl: imageList[index],
                                            width: 180,
                                            height: 180,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Icon(
                                              Icons.error,
                                              color: Colors.white,
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
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
                          SizedBox(height: 16.0),
                          FormFieldStyled(
                            controller: _titleController,
                            hintText: "Produktname",
                            autocorrect: true,
                          ),
                          SizedBox(height: 16.0),
                          FutureBuilder<List<Category>>(
                            future: categoryList,
                            builder: (context, categories) {
                              if (categories.hasData) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: DropdownButton<Category>(
                                    isExpanded: true,
                                    dropdownColor: Colors.black,
                                    value: _category,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _category = value;
                                        },
                                      );
                                    },
                                    hint: Text(
                                      'Kategorie',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    items: categories.data
                                        .map<DropdownMenuItem<Category>>(
                                            (Category category) {
                                      return DropdownMenuItem<Category>(
                                        value: category,
                                        child: Text(
                                          category.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                  child: Text('€ Pro Tag',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
