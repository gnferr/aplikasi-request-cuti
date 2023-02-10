import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../provider/model/color_pallete.dart';

class WelcomeHRD extends StatefulWidget {
  const WelcomeHRD({super.key});

  @override
  State<WelcomeHRD> createState() => _WelcomeHRDState();
}

FirebaseAuth user = FirebaseAuth.instance;
var userdata = user.currentUser;

class _WelcomeHRDState extends State<WelcomeHRD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color[0].white,
      child: Column(
        children: [
          Text(
              DateFormat('EEEE, dd MMMM yyyy')
                  .format(DateTime.now())
                  .toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: color[0].darkblue)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: color[0].darkblue),
                  ),
                  Text(
                    "${userdata!.displayName}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: color[0].darkblue),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 65,
                backgroundColor: color[0].darkblue,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
