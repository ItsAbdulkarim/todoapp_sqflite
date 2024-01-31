import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_to_do_app/helperdb.dart';
import 'package:sqflite_to_do_app/model.dart';
import 'package:sqflite_to_do_app/updatescreen.dart';
class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('detail screen'),),

      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudents(),

        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {

            print("this is iiii$snapshot");
            if( snapshot.data.isEmpty){
              return const Center(
                child: Text('No students found'),

              );
            }


            List<Student> students = snapshot.data;

            return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  Student student = students[index];
                  print('Student $index - ID: ${student.id}, Title: ${student.title}, Description: ${student.description}');

                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Text(student.id.toString()),
                      title: Text(student.title),
                      subtitle: Text(student.description),
                      trailing: Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return UpdateScreen(student: student,);
                                },));

                              },

                              child: Icon(Icons.edit)),
                          SizedBox(height: 5,),


                          InkWell(
                              onTap: (){

    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title: const Text('Confirmation'),
    content: const Text('Are you sure to delete ? '),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    }, child: const Text('No')),
    TextButton(
    onPressed: () async{
    Navigator.pop(context);

    int result = await DatabaseHelper.instance.deleteStudent(student.id!);

    if( result > 0 ){
    Fluttertoast.showToast(msg: 'Deleted');
    setState(() {

    });
    }else{
    Fluttertoast.showToast(msg: 'Failed');

    }
    }, child: const Text('Yes')),
    ],
    );
    });







                              },

                              child: Icon(Icons.delete_outline))


                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

