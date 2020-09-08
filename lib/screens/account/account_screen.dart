import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/models/profile_options_model.dart';
import 'package:rent/screens/account/personal_info.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  String Name = "Kim 19";
  String City = "Mannheim";
  bool verified = true;

  @override
  Widget build(BuildContext context) {
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
                              '$Name',
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          Padding (
                            padding: const EdgeInsets.only(left: 5.0),
                            child: verified ? Icon(
                              Icons.verified_user,
                              color: Colors.purple,
                            ): null
                          ),
                        ],
                      ),
                      Text('$City')],
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
                        onTap:
                              () => Navigator.push(
                              context,
                              new CupertinoPageRoute(
                              builder: (BuildContext context) =>
                          new PersonalInfo(),
                          )
                              ),

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
