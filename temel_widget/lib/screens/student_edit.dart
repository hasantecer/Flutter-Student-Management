import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';

import '../validation/Student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student? selectedStudent;

  StudentEdit(Student? selectedStudent){
    this.selectedStudent =  selectedStudent;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedStudent);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  Student? selectedStudent;
  var formKey = GlobalKey<FormState>();

  _StudentAddState(Student? selectedStudent){
    this.selectedStudent =  selectedStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Guncelle"),
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
      initialValue: selectedStudent?.firstName,
      decoration:const InputDecoration(labelText:"Öğrenci Adı", hintText: "Hasan"),
      validator: validateFirstName,
      onSaved: (String? value) {
        selectedStudent?.firstName = value!;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent?.lastName,
      decoration:const InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Tecer"),
      validator: validateLastName,
      onSaved: (String? value) {
        selectedStudent?.lastName = value!;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent?.grade.toString(),
      decoration:const InputDecoration(labelText: "Aldığı Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String? value) {
        selectedStudent?.grade = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          saveStudent();
          Navigator.pop(context, selectedStudent);
        }

      },
      child: Text("Guncelle"),
    );
  }

  void saveStudent() {
    print(selectedStudent?.firstName);
    print(selectedStudent?.lastName);
    print(selectedStudent?.grade);

  }
}

