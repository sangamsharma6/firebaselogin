import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSigninScreen() {
    Navigator.pushReplacementNamed(context, "/SignInPage");
  }

  @override
  void initState() {
    super.initState();
  }

  signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password)) as FirebaseUser;
        if (user != null) {
          UserUpdateInfo updateInfo = UserUpdateInfo();
          updateInfo.displayName = _name;
          user.updateProfile(updateInfo);
        }
      } catch (e) {
        showError(e.message);
      }
    }
  }

  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Image(
                    image: AssetImage("assets/mascot.png"),
                    width: 100.0,
                    height: 100.0),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an name';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          onSaved: (input) {
                            _name = input;
                          },
                        ),
                      ),
                      //email
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an Email';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          onSaved: (input) {
                            _email = input;
                          },
                        ),
                      ),
                      //password
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be of 6 char';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          onSaved: (input) {
                            _password = input;
                          },
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          splashColor: Colors.blue,
                          onPressed: signup,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),),
                          child: Text(
                            'Sign in',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToSigninScreen,
                        child: Text(
                          'Create an Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
