import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tugas_akhir/pages/hrd/subpage/component/drawer.dart';
import 'package:tugas_akhir/provider/auth/login_auth.dart';
import 'package:tugas_akhir/provider/auth/validator.dart';

import '../../provider/model/color_pallete.dart';

class MainRegister extends StatefulWidget {
  MainRegister({super.key});

  @override
  State<MainRegister> createState() => _MainRegisterState();
}

class _MainRegisterState extends State<MainRegister> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameCt = TextEditingController();
  final _emailCt = TextEditingController();
  final _passCt = TextEditingController();
  String role = "karyawan";

  int cuti = 12;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth usersi = FirebaseAuth.instance;
    var userRegis = usersi.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        isDense: true,
                        labelStyle: TextStyle(color: color[0].darkblue),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: color[0].darkblue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        labelText: 'Nama',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _emailCt,
                      validator: (value) =>
                          Validator.validateEmail(email: value.toString()),
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle: TextStyle(color: color[0].darkblue),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: color[0].darkblue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passCt,
                      validator: (value) => Validator.validatePassword(
                          password: value.toString()),
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle: TextStyle(color: color[0].darkblue),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: color[0].darkblue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_registerFormKey.currentState!.validate()) {
                            User? user = await FireAuth.registerKaryawan(
                                name: _nameCt.text,
                                email: _emailCt.text,
                                image:
                                    'https://media.vanityfair.fr/photos/60d3507cb5f615de15ffe813/16:9/w_2560%2Cc_limit/vf_ryan_gosling_9793.jpeg',
                                password: _passCt.text);

                            await users.doc(user!.uid).set({
                              'name': _nameCt.text,
                              'email': _emailCt.text,
                              'role': role,
                              'id': user.uid,
                              'phone_number': '',
                              'address': '',
                              'AjuanCuti': {
                                'cuti': 12,
                                'getcuti': 0,
                                'description': '',
                                'status': 'pending',
                                'cuti_start': DateTime.now(),
                                'cuti_end': DateTime.now()
                              }
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
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
