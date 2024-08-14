
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/utils/my_paddings.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart'; 
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegistrationnScreenState();
}

class RegistrationnScreenState extends State<RegisterScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String username='',email= '', password = '';
  bool stayLoggedIn = false;
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool emailValid = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
      key: _drawerKey,
      body: SingleChildScrollView(
          child: SafeArea(
        child: MyPaddings.responsivePadding(
          context, 
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png',height: 100,),
                MyText.myText(
                  'SIGN UP',
                  textSize: MyTextSize.xxbig,
                  type: MyTextSize.xxbig,
                ), Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'), 
                    ]),
                    hintText: 'Enter username',
                    suffixIconButton: Icon(
                      username.isNotEmpty
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: username.isNotEmpty
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    autovalidate: false,
                    onChanged: (val)=>setState(() {
                      username=val;
                    }),
                  ),
                ),
                Constants.topMargin(
                  20
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      EmailValidator(errorText: "Enter a Valid Email")
                    ]),
                    hintText: 'Enter email',
                    suffixIconButton: Icon(
                      emailValid
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: emailValid
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    autovalidate: false,
                    onChanged: (val) {
                      setState(() => {
                            email = val,
                            emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password Required'),
                      MinLengthValidator(3, errorText: "Password must be more than 3 characters")
                    ]),
                    onChanged: (val) {
                      if (mounted) {
                        setState(() => {
                              password = val,
                            });
                      }
                    },
                  ),
                ),
                Constants.topMargin(2),
                Constants.errorText(authProvider.authError),
                MyButton(
                  placeHolder: 'Register',
                  color: AppColors.primaryColorValue,
                  loadingState: authProvider.isLoading,
                  height: 48,
                  textColor: Colors.white,
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authProvider.register(username,email, password);
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
              onPressed: () {
                        authProvider.switchAuthScreens();
              },
              child: Text('Already have an account? Login'),
            ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
