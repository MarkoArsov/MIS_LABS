import 'package:flutter/material.dart';
import 'package:lab3/models/exam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab3/widgets/create_exam_widget.dart';
import 'package:lab3/widgets/exam_widget.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  ExamListScreenState createState() => ExamListScreenState();
}

class ExamListScreenState extends State<ExamListScreen> {
  final List<Exam> exams = [Exam(courseName: 'MIS', dateTime: DateTime.now())];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIS LAB 3 - 201135'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => FirebaseAuth.instance.currentUser != null
                ? addNewExam(context)
                : logIn(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logOut,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return ExamWidget(exam: exams[index]);
        },
      ),
    );
  }

  Future<void> addNewExam(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: CreateExamWidget(
              addExam: addExam,
            ),
          );
        });
  }

  void addExam(Exam exam) {
    setState(() {
      exams.add(exam);
    });
  }

  void logIn(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
