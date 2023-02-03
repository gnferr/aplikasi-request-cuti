import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tugas_akhir/pages/hrd/component/drawer.dart';
import 'package:tugas_akhir/provider/auth/login_auth.dart';
import 'package:tugas_akhir/provider/auth/validator.dart';

class MainRegister extends StatefulWidget {
  MainRegister({super.key});

  @override
  State<MainRegister> createState() => _MainRegisterState();
}

FirebaseAuth users = FirebaseAuth.instance;
var userRegis = users.currentUser;

class _MainRegisterState extends State<MainRegister> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameCt = TextEditingController();
  final _emailCt = TextEditingController();
  final _passCt = TextEditingController();
  String role = "karyawan";

  int cuti = 12;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCt,
                    validator: (value) =>
                        Validator.validateName(name: value.toString()),
                    decoration: InputDecoration(
                      label: Text('nama'),
                    ),
                  ),
                  TextFormField(
                    controller: _emailCt,
                    validator: (value) =>
                        Validator.validateEmail(email: value.toString()),
                    decoration: InputDecoration(
                      label: Text('email'),
                    ),
                  ),
                  TextFormField(
                    controller: _passCt,
                    validator: (value) =>
                        Validator.validatePassword(password: value.toString()),
                    decoration: InputDecoration(
                      label: Text('password'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          // signUp(_nameCt.text, _emailCt.text, _passCt.text,
                          //     role, cuti);
                          User? user = await FireAuth.registerKaryawan(
                              name: _nameCt.text,
                              email: _emailCt.text,
                              image: 'assets/images/user.png',
                              password: _passCt.text);

                          await users.doc(user!.uid).set({
                            'name': _nameCt.text,
                            'email': _emailCt.text,
                            'cuti': 12,
                            'role': role,
                            'id': user.uid,
                            'getcuti': 0,
                            'description': '',
                            'status': 'pending'
                          });
                        }
                        _logout();
                      },
                      child: Text('Register')),
                  ElevatedButton(
                      onPressed: () {
                        context.goNamed('login');
                      },
                      child: Text('Back login')),
                  DropdownButton<String>(
                    value: role,

                    items: <String>['karyawan', 'hrd']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        role = newValue!;
                      });
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
