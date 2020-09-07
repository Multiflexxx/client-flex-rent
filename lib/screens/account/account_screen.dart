import 'package:flutter/material.dart';
import 'package:rent/models/profile_options_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                              'Kim 19',
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.verified_user,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      Text('Mannheim')],
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
                        onTap: null,
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
