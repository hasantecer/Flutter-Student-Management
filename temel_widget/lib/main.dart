import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/screens/student_add.dart';
import 'package:temel_widget/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Sistemi";

  Student selectedStudent = Student.withId(0, "", "", 0);

  List<Student> students = [
    Student.withId(1, "Hasan", "Tecer", 65),
    Student.withId(2, "Ömer", "Carlakoğlu", 15),
    Student.withId(3, "Senanur", "Kaçar", 45),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(mesaj),
      ),
      body: buildBody(context),
    );
  }
  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                      print(selectedStudent);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/219/219983.png"),
                    ),
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan Aldığı Not: " +
                        students[index].grade.toString() +
                        " (" +
                        students[index].getStatus +
                        ")"),
                    trailing: buildStatusIcon(students[index].grade),
                  );
                })),
        Text("Seçili öğrenci :" + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 1.0,
                    ),
                    Text("Yeni Öğrenci"),
                  ],
                ),
    onPressed: () async {
      students = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => StudentAdd(students)));
      setState(() {});
    }
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 1.0,
                    ),
                    Text("Güncelle"),
                  ],
                ),
                  onPressed: () async {
                    selectedStudent = await Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
                    setState(() {});
                  }
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 1.0,
                    ),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var mesaj = "Silindi: " + selectedStudent.firstName;
                  mesajGoster(context, mesaj);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade > 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
