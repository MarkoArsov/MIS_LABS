import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lab5/models/exam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab5/models/exam_location.dart';
import 'package:lab5/screens/calendar_screen.dart';
import 'package:lab5/screens/map_screen.dart';
import 'package:lab5/utils/notification_controller.dart';
import 'package:lab5/widgets/create_exam_widget.dart';
import 'package:lab5/widgets/exam_widget.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  ExamListScreenState createState() => ExamListScreenState();
}

class ExamListScreenState extends State<ExamListScreen> {
  final List<Exam> exams = [Exam(courseName: 'MIS', dateTime: DateTime.now())];
  final List<ExamLocation> locations = [
    ExamLocation(
        name: "Faculty of Law",
        latitude: 41.999735288132015,
        longitude: 21.44336931193241),
    ExamLocation(
        name: "Faculty of Economics",
        latitude: 42.000863845204684,
        longitude: 21.44291933853767),
    ExamLocation(
        name: 'FINKI',
        latitude: 42.00496024806522,
        longitude: 21.410040580569245),
    ExamLocation(
        name: 'FEIT',
        latitude: 42.004991986121425,
        longitude: 21.40845801336476),
    ExamLocation(
        name: 'American College',
        latitude: 41.981320625608824,
        longitude: 21.454833922808117)
  ];

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceiveMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceiveMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayed);
    scheduleNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIS LAB 4 - 201135'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => openMap(),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => openCalendar(),
          ),
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
      scheduleNotification(exam);
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

  void openMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(locations: locations),
      ),
    );
  }

  void openCalendar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(exams: exams),
      ),
    );
  }

  void scheduleNotifications() {
    for (var exam in exams) {
      scheduleNotification(exam);
    }
  }

  void scheduleNotification(Exam exam) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: exams.indexOf(exam),
        channelKey: 'basic_channel',
        title: exam.courseName,
        body: "You have an exam",
      ),
      schedule: NotificationCalendar.fromDate(date: exam.dateTime),
    );
  }
}
