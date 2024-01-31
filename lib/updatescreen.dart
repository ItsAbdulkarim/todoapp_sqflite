import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_to_do_app/helperdb.dart';

import 'package:sqflite_to_do_app/model.dart';
import 'package:sqflite_to_do_app/readscreen.dart';


class UpdateScreen extends StatefulWidget {
  final Student student;
  const UpdateScreen({super.key,required this.student});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late String title, description;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    initialValue: widget.student.title,
                    decoration: InputDecoration(
                      hintText: 'please enter title',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill';
                      } else {
                        title=value;
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.student.description,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'descreipton',
                          isDense: true,
                          filled: true,
                          border: InputBorder.none),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill';
                        } else {
                          description=value;
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)),
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                Student student=Student(
                                    id: widget.student.id,

                                    title: title.toString(),
                                    description: description.toString());
                                await DatabaseHelper.instance.updatestudent(student);
                                setState(() {
                                  // Update UI if necessary
                                });


                                Fluttertoast.showToast(
                                    msg: 'Record Update',
                                    backgroundColor: Colors.green);
                              } else {

                                Fluttertoast.showToast(
                                    msg: 'Not Record Saved',
                                    backgroundColor: Colors.green);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)),
                            onPressed: () {
                              formkey.currentState!.reset();
                              setState(() {

                              });
                            },

                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 20)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ReadScreen();
                          },
                        ));
                      },
                      child: Text(
                        'view record',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
