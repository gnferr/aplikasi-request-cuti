import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../provider/model/color_pallete.dart';

class BodyPengajuanCuti extends StatefulWidget {
  const BodyPengajuanCuti({super.key});

  @override
  State<BodyPengajuanCuti> createState() => _BodyPengajuanCutiState();
}

class _BodyPengajuanCutiState extends State<BodyPengajuanCuti> {
  final textCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: color[0].grey,
      child: FormPengajuanCuti(),
    );
  }
}

int? isCuti = 1;
TextEditingController _description = TextEditingController();

class FormPengajuanCuti extends StatefulWidget {
  const FormPengajuanCuti({super.key});

  @override
  State<FormPengajuanCuti> createState() => _FormPengajuanCutiState();
}

User? currentUser = FirebaseAuth.instance.currentUser;

class _FormPengajuanCutiState extends State<FormPengajuanCuti> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userCuti =
        FirebaseFirestore.instance.collection('users');

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color[0].white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/email.png',
                    scale: 20,
                    color: color[0].darkblue,
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(" ")[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: color[0].darkblue,
                        fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From :',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color[0].darkblue,
                              fontSize: 15),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Text(
                                "${currentUser!.displayName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: color[0].darkblue),
                              ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuti :',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: color[0].darkblue,
                                fontSize: 15),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color[0].grey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                    isDense: true,
                                    isExpanded: true,
                                    value: isCuti,
                                    onChanged: (newVal) {
                                      setState(() {
                                        isCuti = newVal;
                                      });
                                    },
                                    items: <int>[1, 2, 3, 4].map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList()),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color[0].darkblue,
                              fontSize: 15),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: color[0].grey,
                          ),
                          child: TextField(
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: InputDecoration(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Message :',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: color[0].darkblue,
                        fontSize: 15),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: color[0].grey,
                    ),
                    child: TextField(
                      maxLines: 6,
                      controller: _description,
                      decoration: InputDecoration(
                          hintText: 'write message..',
                          contentPadding: EdgeInsets.all(6),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green,
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text("Are you sure?"),
                            content: Text("Anda yakin ingin submit? O_o"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: color[0].red),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  // userCuti
                                  //     .doc(currentUser!.uid)
                                  //     .collection("ajuancuti")
                                  //     .add({
                                  //   'id': currentUser!.uid,
                                  //   'name': currentUser!.displayName,
                                  //   'description': _description.text,
                                  //   'getcuti': isCuti,
                                  //   'status': 'pending'
                                  // });
                                  await userCuti.doc(currentUser!.uid).update({
                                    "getcuti": isCuti,
                                    "description": _description.text,
                                    "status": "pending"
                                  });
                                  Navigator.pop(context);
                                  _description.clear();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color[0].white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class FormSatu extends StatelessWidget {
//   const FormSatu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'From :',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: color[0].darkblue,
//                       fontSize: 15),
//                 ),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: color[0].grey,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Cuti :',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: color[0].darkblue,
//                         fontSize: 15),
//                   ),
//                   Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: color[0].grey,
//                     ),
//                     child: TextField(),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Date :',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: color[0].darkblue,
//                       fontSize: 15),
//                 ),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: color[0].grey,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Form2 extends StatelessWidget {
//   const Form2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Date :',
//             style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: color[0].darkblue,
//                 fontSize: 15),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height / 8,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: color[0].grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
