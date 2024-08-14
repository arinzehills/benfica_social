
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/register_screen.dart';
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
import 'package:get/route_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String email = '', password = '';
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
                  'SIGN IN',
                  textSize: MyTextSize.xxbig,
                  type: MyTextSize.xxbig,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                    // key:"email",
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
                Constants.topMargin(10),
                MyButton(
                  placeHolder: 'Login',
                  color: AppColors.primaryColorValue,
                  loadingState: authProvider.isLoading,
                  height: 48,
                  textColor: Colors.white,
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authProvider.login(email, password);
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
              child: Text('Dont  have an account? Register'),
            ),
                // NoAccount(
                //   title: "Don't have an account?",
                //   subtitle: 'Sign up',
                //   pressed: () async {
                //     authProvider.setIsRegScreen();

                //     // Navigator.of(context).pushReplacement(
                //     //   MaterialPageRoute(
                //     //       builder: (context) => Register(
                //     //           // create: (context) => Register(),
                //     //           )),
                //     // );
                //   },
                // ), 
              ],
            ),
          ),
        ),
      )),
    );
  }
}
