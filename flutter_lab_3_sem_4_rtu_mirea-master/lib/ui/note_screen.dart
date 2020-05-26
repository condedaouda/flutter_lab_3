import 'package:flutter/material.dart';
import '../model/student.dart';
import '../util/database_helper.dart';

class StudentScreen extends StatefulWidget {
  final Student student;
  StudentScreen(this.student);

  @override
  State<StatefulWidget> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _dateController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.student.name,
    );
    _dateController = TextEditingController(
      text: widget.student.addeddate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.student.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.student.id != null) {
                  db
                      .updateStudent(Student.fromMap({
                    'id': widget.student.id,
                    'name': _nameController.text,
                    'date': _dateController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveStudent(
                          Student(_nameController.text, _dateController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
