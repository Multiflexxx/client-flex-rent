import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FormFieldStyled extends StatefulWidget {
  final Widget child;
  final hintText;
  bool obscureText;
  final validator;
  final helperText;
  final icon;
  final TextInputType type;

  FormFieldStyled(
      {Key key,
      this.child,
      this.hintText,
      this.obscureText,
      this.validator,
      this.helperText,
      this.icon,
      this.type})
      : super(key: key);

  _FormFieldStyledState createState() => _FormFieldStyledState();
}

class _FormFieldStyledState extends State<FormFieldStyled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
         icon: widget.icon ?? null,
        suffixIcon: widget.type == TextInputType.visiblePassword ? IconButton(icon:Icon(!widget.obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () {
          setState(() {
            widget.obscureText = !widget.obscureText;
          });
        },) : null,

        helperStyle: TextStyle(color: Colors.white60, height: 1.25),
        helperMaxLines: 3,
        helperText: widget.helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: widget.hintText ?? '',
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hoverColor: Colors.white,
      ),
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
    );
  }
}
