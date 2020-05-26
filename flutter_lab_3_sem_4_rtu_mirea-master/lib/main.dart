import 'package:flutter/material.dart';
import './model/student.dart';
import './util/database_helper.dart';
import './ui/note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 3',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> items = [];
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllStudents().then((students) {
      setState(() {
        students.forEach((student) {
          items.add(Student.fromMap(student));
        });
      });
    });
  }

  void _deleteStudent(
      BuildContext context, Student student, int position) async {
    db.deleteStudent(student.id).then((students) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToStudent(BuildContext context, Student student) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentScreen(student)),
    );

    if (result == 'update') {
      db.getAllStudents().then((students) {
        setState(() {
          items.clear();
          students.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }

  void _createNewStudent(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentScreen(Student('', ''))),
    );

    if (result == 'save') {
      db.getAllStudents().then((students) {
        setState(() {
          items.clear();
          students.forEach((student) {
            items.add(Student.fromMap(student));
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Database'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Divider(height: 3.0),
              ListTile(
                title: Text(
                  '${items[position].name}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(
                  '${items[position].addeddate}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () => _deleteStudent(
                    context,
                    items[position],
                    position,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewStudent(context),
      ),
    );
  }
}
