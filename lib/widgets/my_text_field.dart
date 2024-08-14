import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  String hintText;
  Key? key;
  String? initiaiValue;
  String? value;
  bool? obscureText;
  bool? autovalidate;
  TextInputType? keyboardType;
  Function()? onTap;
  Function(String)? onChanged;
  // final VoidCallback pressed;
  Widget? suffixIconButton;
  Icon? prefixIcon;
  String? Function(String?)? validator;
  bool isNumberOnly;

  // IconButton(
  //                                             icon: const Icon(Icons.visibility),
  //                                             color:iconsColor,
  //                                             onPressed: () {
  //                                              if(obscureText==true){
  //                                                 setState(() {
  //                                                   obscureText=false;
  //                                                 });
  //                                               }
  //                                               else{
  //                                                 setState(() {
  //                                             obscureText=true;
  //                                               });
  //                                               }
  //                                             },
  //                                         ),

  MyTextField({
    required this.hintText,
    this.initiaiValue,
    this.key,
    // required this.pressed,
    this.suffixIconButton,
    this.value,
    this.obscureText,
    this.validator,
    this.autovalidate,
    this.isNumberOnly = false,
    this.onTap,
    this.onChanged,
    this.keyboardType,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      key: widget.key,
      // style: TextStyle(height: 2),
      // autovalidate: widget.autovalidate!s,
      initialValue: widget.initiaiValue,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.isNumberOnly
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      cursorHeight: 23,
      onTap: widget.onTap,
       style: TextStyle(
                color: AppColors.primaryColorValue,
                fontFamily: 'Roboto', // Using Roboto font family
              ),
      obscureText: widget.obscureText ?? false,
      decoration: textFieldDecoration.copyWith(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIconButton,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 12,color: Colors.grey)),
      onChanged: widget.onChanged,
    );
  }
}
