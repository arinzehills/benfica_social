import 'package:benfica_social/services/auth_service.dart';
import 'package:benfica_social/services/user_service.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

Future buildEditPopup(BuildContext context,name) {
  final _formKey = GlobalKey<FormState>();

           String error = '',textValuetoUpdate='';
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {

  bool loading = false;

              return AlertDialog(
                backgroundColor: Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: 277,
                  // constraints: BoxConstraints(ma),
                  // padding: EdgeInsets.all(20),
                  child: Center(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText.myText(
                          'Edit Profile',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                          child: MyTextField(
                            hintText: name!,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a value' : null,
                            onChanged: (val) {
                              setState(() => textValuetoUpdate = val);
                            },
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        MyButton(
                          placeHolder: 'Update',
                          loadingState: loading,
                          pressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(textValuetoUpdate);
                              // var user = await AuthService().getuserFromStorage();
                              var dataToUpdate = {
                                name: textValuetoUpdate,
                              };
                              var response = await AuthService()
                                  .updateUser(dataToupdate: dataToUpdate);
              
                              if (true == true) {
                              //   setState(() => {});
                              //   Navigator.pop(context);
                              //   snackBar(
                              //       BottomNavigation(
                              //         index: 5,
                              //       ),
                              //       context,
                              //       'Updated successfully');
                              } else {
                                setState(() => loading = false);
                                // setState(() => error = response['message']);
                              }
                            }
                          }, 
                        )
                      ],
                    ),
                  )),
                ),
              );
            }
          );
        });
  }