import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/slideIns/slide_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteModal extends StatelessWidget {
  final Offer offer;
  final VoidCallback updateParentFunction;

  const DeleteModal({Key key, this.offer, this.updateParentFunction})
      : super(key: key);

  deleteOffer({BuildContext context}) async {
    try {
      await ApiOfferService().deleteOffer(offer: this.offer);
      updateParentFunction();
      Navigator.pop(context, 'deleted');
    } on OfferException catch (e) {
      Navigator.pop(context, e);
    }
  }

  @override
  Widget build(BuildContext rootContext) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Material(
          color: Theme.of(rootContext).cardColor,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 0.5 * MediaQuery.of(rootContext).size.width,
            child: Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (context2) => Builder(
                  builder: (context) => SafeArea(
                    top: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlideBar(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Optionen',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 21,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ListTile(
                              title: Text(
                                "Produkt löschen",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              leading: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Builder(
                                      builder: (context) => SafeArea(
                                        top: true,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SlideBar(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Produkt löschen',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 21,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Text(
                                                'Bist du sicher, dass du dieses Produkt löschen willst? Diese Aktion kann nicht rückgängig gemacht werden.',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.of(
                                                            rootContext)
                                                        .pop(),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ),
                                                      child: Text(
                                                        "Abbrechen",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => deleteOffer(
                                                        context: rootContext),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15.0),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                      ),
                                                      child: Text(
                                                        "Löschen",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
