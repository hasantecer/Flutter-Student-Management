import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';

import '../validation/Student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student>? students;

  StudentAdd(List<Student> students){
      this.students =  students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students!);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  List<Student>? students;
  var student = Student.withOutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(List<Student> students){
    this.students =  students;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni öğrenci ekle"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children:[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton(),
              ],
            ),
          ),
        )
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration:const InputDecoration(labelText:"Öğrenci Adı", hintText: "Hasan"),
      validator: validateFirstName,
      onSaved: (String? value) {
        student.firstName = value!;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration:const InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Tecer"),
      validator: validateLastName,
      onSaved: (String? value) {
        student.lastName = value!;
      },
    );
  }

  Widget buildGradeField() {
   return TextFormField(
      decoration:const InputDecoration(labelText: "Aldığı Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String? value) {
        student.grade = int.parse(value!);
      },
    );
  }

 Widget buildSubmitButton() {
    return ElevatedButton(
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            students?.add(student);
            saveStudent();
            Navigator.pop(context, students);
          }

        },
        child: Text("Kaydet"),
    );
 }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);

  }
}

