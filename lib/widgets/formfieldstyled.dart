import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class FormFieldStyled extends StatefulWidget {
  final Widget child;
  final hintText;
  bool obscureText;
  final validator;
  final helperText;
  final icon;
  final controller;
  final autocorrect;
  final TextInputType type;
  final length;
  final initialValue;
  final maxLines;

  FormFieldStyled(
      {Key key,
      this.child,
      this.hintText,
      this.obscureText,
      this.validator,
      this.helperText,
      this.icon,
      this.type,
      this.length,
      this.controller,
      this.autocorrect,
      this.initialValue,
      this.maxLines})
      : super(key: key);

  _FormFieldStyledState createState() => _FormFieldStyledState();
}

class _FormFieldStyledState extends State<FormFieldStyled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      autocorrect: widget.autocorrect,
      keyboardType: widget.type,
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColor),
      maxLength: widget.length,
      decoration: InputDecoration(
        counter: Offstage(),
        isDense: true,
        icon: widget.icon ?? null,
        suffixIcon: widget.type == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                    !widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,
        helperStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          height: 1.25,
        ),
        helperMaxLines: 3,
        helperText: widget.helperText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: widget.hintText ?? '',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        hoverColor: Theme.of(context).primaryColor,
      ),
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
    );
  }
}
