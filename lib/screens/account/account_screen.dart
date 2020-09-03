import 'package:flutter/material.dart';
import 'package:rent/models/profile_options_model.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account")),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/jett.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right:150.0),
                child: Column(
                  children: [
                    Text(
                        'Kim 19',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    Text('Mannheim')],
                ),
              )
            ],
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
