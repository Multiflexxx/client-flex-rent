import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/rentalItems/auth_screen.dart';
import 'package:flexrent/screens/rentalItems/rental_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentalItemsRootScreen extends StatelessWidget {
  static String routeName = 'rootTabScreen';

  final VoidCallback hideNavBarFunction;

  const RentalItemsRootScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return RentalItemsScreen();
        }
        return AuthScreen(
          hideNavBarFunction: hideNavBarFunction,
          rootName: 'rentallItems'
        );
      },
    );
  }
}
