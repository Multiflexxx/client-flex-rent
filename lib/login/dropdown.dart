import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomDropDown extends StatefulWidget {
  final Widget child;
  final hintText;
  final obscureText;
  final validator;
  final helperText;
  final icon;
  final TextInputType type;
  final length;

  CustomDropDown(
      {Key key,
      this.child,
      this.hintText,
      this.obscureText,
      this.validator,
      this.helperText,
      this.icon,
      this.type,
      this.length})
      : super(key: key);

  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> _countryNumber = <String>[
    'Deutschland +49',
    'England +756',
    'Russland +1',
  
   
  ];
  var selectedNumber;
  @override
  Widget build(BuildContext context) {
    return 
    
    DropdownButton(
      
      items: _countryNumber
          .map((value) => DropdownMenuItem(
            
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
                value: value,
                
              ))
          .toList(),
      onChanged: (selectedNumberType) {
        setState(() {
          selectedNumber = selectedNumberType;
        });
      },
      dropdownColor: Colors.black,
      focusColor: Colors.purple,
      iconDisabledColor: Colors.white,
      iconEnabledColor: Colors.white,
      value: selectedNumber,
    
      
    );
  }
}
