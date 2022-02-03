import 'package:authmodule/main_screen/Dashboard.dart';
import 'package:authmodule/main_screen/LoginPage.dart';
import 'package:authmodule/other/ErrorDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegisterPage extends StatefulWidget {
  static String id = '/RegisterPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String email;
  late String password;
  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';
  var _formKey = GlobalKey<FormState>();

  bool isLoggedIn = false;
  bool isLoading = false;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      isLoading = false;
      this.isLoggedIn = isLoggedIn;
      print('$isLoggedIn');
      if (isLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(message: 'Facebook login cancel');
            });
      }
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            /*Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),*/
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0, bottom: 20, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 45.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Please register to your account',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      /*Text(
                        'to your account',
                        style: TextStyle(fontSize: 30.0),
                      ),*/
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'User Name',
                            labelText: 'User Name',
                          ),
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (value) {
                            //Validator
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid username!';
                            }
                            return null;
                          },
                        ),
                        //box styling
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {
                            //Validator
                          },
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        //box styling
                        const SizedBox(height: 20.0),
                        //text input
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Password', hintText: 'Password'),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40.0),
                        MaterialButton(
                          minWidth: 150,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          color: const Color(0xff447def),
                          child: const Text(
                            "Register",
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                          onPressed: () => _submit(),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                      const Text(
                        'Or',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                        MaterialButton(
                          elevation: 0,
                          minWidth: double.maxFinite,
                          height: 50,
                          onPressed: () {
                            onGoogleSignIn(context);
                          },
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(FontAwesomeIcons.google),
                              SizedBox(width: 10),
                              Text('Google',
                                  style: TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          textColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child:
                        MaterialButton(
                          elevation: 0,
                          minWidth: double.maxFinite,
                          height: 50,
                          onPressed: () {
                            print('facebook');
                            initiateFacebookLogin();
                          },
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(FontAwesomeIcons.facebookF),
                              SizedBox(width: 10),
                              Text('Facebook',
                                  style: TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          ' Sign In',
                          style: TextStyle(fontSize: 22.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> onGoogleSignIn(BuildContext context) async {
    print('googleSignInClicked');
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  void initiateFacebookLogin() async {
    setState(() {
      isLoading = true;
    });
    var facebookLoginResult = await facebookLogin.logIn(['email','public_profile']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print('error');
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print('${facebookLoginResult.accessToken}');
        onLoginStatusChanged(true);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancel');
        onLoginStatusChanged(false);
        break;
    }
  }
}
