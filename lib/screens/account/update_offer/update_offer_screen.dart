import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/screens/account/offer_delete.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/account/update_offer/update_offer_body.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UpdateOfferScreen extends StatelessWidget {
  static String routeName = 'updateOfferScreen';

  final Offer offer;
  final VoidCallback updateParentFunction;

  UpdateOfferScreen({this.offer, this.updateParentFunction});

  deleteOffer({BuildContext context}) async {
    Offer offer = await ApiOfferService().deleteOffer(offer: this.offer);
    Navigator.pop(context, offer);
  }

  // _showDeleteDialog({BuildContext context}) async {
  //   Offer offer = await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertPopup(
  //         title: "Produkt löschen",
  //         message:
  //             "Bist du sicher, dass du dieses Produkt löschen willst? Diese Aktion kann nicht rückgängig gemacht werden.",
  //         goon: () {
  //           deleteOffer(context: context);
  //         },
  //       );
  //     },
  //   );

  //   if (offer != null) {
  //     Navigator.of(context)..pop()..pop('reload');
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Bearbeiten',
      actions: [
        IconButton(
          onPressed: () async {
            final error = await showCupertinoModalBottomSheet(
              expand: false,
              useRootNavigator: true,
              context: context,
              barrierColor: Colors.black45,
              builder: (context, scrollController) => DeleteModal(
                offer: this.offer,
                updateParentFunction: updateParentFunction,
              ),
            );
            if (error == null) {
              Navigator.of(context).pop();
            } else {
              showFlushbar(context: context, message: error.message);
            }
          },
          //   onPressed: () => showCupertinoModalBottomSheet(
          //     expand: false,
          //     context: context,
          //     barrierColor: Colors.black45,
          //     builder: (context, scrollController) => SlideIn(
          //       top: false,
          //       widgetList: [
          //         GestureDetector(
          //           onTap: () {
          //             _showDeleteDialog(context: context);
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: Row(
          //               children: [
          //                 Icon(Icons.delete,
          //                     color: Theme.of(context).primaryColor),
          //                 SizedBox(
          //                   width: 5.0,
          //                 ),
          //                 Text(
          //                   "Produkt löschen",
          //                   style:
          //                       TextStyle(color: Theme.of(context).primaryColor),
          //                 )
          //               ],
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          icon: Icon(
            Icons.more_horiz,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
      bodyWidget: UpdateOfferBody(
        offer: offer,
        updateParentFunction: updateParentFunction,
      ),
    );
  }
}
