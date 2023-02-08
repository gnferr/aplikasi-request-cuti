import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tugas_akhir/provider/auth/validator.dart';

import '../../firebase_options.dart';
import '../../provider/auth/login_auth.dart';
import '../../provider/model/color_pallete.dart';

class MainLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  MainLogin({super.key});

  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initializeFirebase() async {
      FirebaseApp firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      return firebaseApp;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: color[0].white,
          ),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    User? user = await FireAuth.signInWithEmailPassword(
                        email: 'hrd@gmail.com',
                        password: 'hrd123',
                        context: context);
                    var userlogin = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        if (documentSnapshot.get('role') == "karyawan") {
                          context.go("/karyawan");
                        } else {
                          context.go("/hrd");
                        }
                      }
                    });
                  },
                  child: Text('Login Hrd')),
              ElevatedButton(
                  onPressed: () async {
                    User? user = await FireAuth.signInWithEmailPassword(
                        email: 'ryan@gmail.com',
                        password: 'ryan123',
                        context: context);
                    var userlogin = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        if (documentSnapshot.get('role') == "karyawan") {
                          context.go("/karyawan");
                        } else {
                          context.go("/hrd");
                        }
                      }
                    });
                  },
                  child: Text('Login Karyawan')),
              Expanded(
                  flex: 2,
                  child: Stack(children: [
                    Center(
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 30),
                          height: 200,
                          width: 200,
                          color: Color.fromRGBO(29, 53, 87, 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 20),
                          height: 200,
                          width: 200,
                          color: Color.fromRGBO(230, 57, 70, 1),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60, top: 25),
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            color: Color.fromRGBO(29, 53, 87, 1),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70, top: 35),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            color: color[0].white,
                          ),
                        ),
                      ]),
                    ),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            'Management',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 33,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = Color.fromRGBO(29, 53, 87, 1),
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            'Management',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 33,
                              color: color[0].white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 70),
                        child: Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              'Karyawan',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 33,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Color.fromRGBO(29, 53, 87, 1),
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              'Karyawan',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 33,
                                color: color[0].white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
              Expanded(
                  flex: 3,
                  child: FutureBuilder(
                    future: _initializeFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailText,
                                    validator: (value) =>
                                        Validator.validateEmail(
                                            email: value.toString()),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.account_circle),
                                      filled: true,
                                      hintText: 'Email',
                                      fillColor: color[0].grey,
                                      contentPadding: EdgeInsets.all(15),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: _passwordText,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(
                                            password: value.toString()),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.key),
                                        filled: true,
                                        hintText: 'Password',
                                        fillColor: color[0].grey,
                                        contentPadding: EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(25))),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Color.fromRGBO(29, 53, 87, 1)),
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              User? user = await FireAuth
                                                  .signInWithEmailPassword(
                                                      email: _emailText.text,
                                                      password:
                                                          _passwordText.text,
                                                      context: context);
                                              var userlogin = FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .get()
                                                  .then((DocumentSnapshot
                                                      documentSnapshot) {
                                                if (documentSnapshot.exists) {
                                                  if (documentSnapshot
                                                          .get('role') ==
                                                      "karyawan") {
                                                    context.go("/karyawan");
                                                  } else {
                                                    context.go("/hrd");
                                                  }
                                                }
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content: Center(
                                                            child:
                                                                CircularProgressIndicator())),
                                              );
                                            }
                                            // signIn(_emailText.text,
                                            //     _passwordText.text);
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      children: [
                                        TextSpan(
                                            text: 'Sign Up',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.go("/register");
                                              })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


// for this project assignment I made a request for permission for employees,
//  the project I made is still in progress not yet completed. 

