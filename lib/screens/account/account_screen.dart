import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/screens/account/my_items.dart';
import 'package:rent/screens/account/settings/account_settings_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget userCard({name, city, verified}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/jett.jpg'),
                radius: 50.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.clip,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: verified
                          ? Icon(
                              Icons.verified_user,
                              color: Colors.purple,
                            )
                          : null,
                    ),
                  ],
                ),
                Text('$city')
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  pushNewScreen(context,
                      screen: AccountSettingsScreen(), withNavBar: true);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    final User user = state.user;

    String name = '${user.firstName} ${user.lastName}';
    String city = '${user.city}';
    bool verified = user.verified;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            userCard(name: name, city: city, verified: verified),
            Divider(
              height: 20.0,
              color: Colors.purple,
            ),
            Expanded(
              child: MyItems(),
            ),
          ],
        ),
      ),
    );
  }
}
