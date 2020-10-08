import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/models/profile_options_model.dart';
import 'package:rent/screens/404.dart';
import 'package:rent/screens/account/my_items.dart';
import 'package:rent/screens/account/personal_info.dart';
import 'package:rent/screens/account/settings.dart';
import 'package:rent/logic/models/models.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final routes = {
    'personalInfo': PersonalInfo(),
    'myitems': MyItems(),
    'paymentinfos': PageNotFound(),
    'karmainfo': PageNotFound(),
    'settings': AppSettings(),
    'logout': PageNotFound(),
  };

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    final User user = state.user;

    String name = '${user.firstName} ${user.lastName}';
    String city = '${user.city}';
    bool verified = user.verified;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
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
                flex: 2,
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
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: verified
                                  ? Icon(
                                      Icons.verified_user,
                                      color: Colors.purple,
                                    )
                                  : null),
                        ],
                      ),
                      Text('$city')
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 20.0,
            color: Colors.purple,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: profileOptions.length,
                  itemBuilder: (context, index) {
                    ProfileOption option = profileOptions[index];
                    return ListTile(
                        onTap: () {
                          if (index < profileOptions.length - 1) {
                            print(option.optionId);
                            pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name: option.optionId),
                              screen: routes[option.optionId] ?? PageNotFound(),
                              withNavBar: true,
                            );
                          } else {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(UserLoggedOut());
                          }
                        },
                        leading: Icon(
                          option.icon,
                          color: Colors.white,
                        ),
                        title: Text(
                          option.name,
                          style: TextStyle(color: Colors.white),
                        ));
                  }))
        ],
      ),
    );
  }
}
