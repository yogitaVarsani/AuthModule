import 'package:authmodule/main_screen/LoginPage.dart';
import 'package:flutter/material.dart';


class ForgotPassPage extends StatefulWidget {
  static String id = '/ForgotPassPage';

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  late String email;
  var _formKey = GlobalKey<FormState>();

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
           /* Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),*/
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 60, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 45.0),
                      ),
                      /*Text(
                        'Password',
                        style: TextStyle(fontSize: 50.0),
                      ),*/
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0, left: 0.0, right: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Please enter your email',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        /*Text(
                          'enter your email.',
                          style: TextStyle(fontSize: 30.0),
                        ),*/
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                        const SizedBox(height: 40.0),
                        MaterialButton(
                          minWidth: 150,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          color: const Color(0xff447def),
                          child: const Text(
                            "Submit",
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
}
