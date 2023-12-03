import "package:flutter/material.dart";

void main() {
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "201135",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: const BodyWidget(),
    ));
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final TextEditingController controller = TextEditingController();

  List<String> subjects = [];

  @override
  void initState() {
    subjects = [
      "Information Systems Analysis and Design",
      "Management Information Systems",
      "Mobile Information Systems",
      "Team project"
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black45),
      child: Column(children: buildSubjectWidgets()),
    );
  }

  List<Widget> buildSubjectWidgets() {
    List<Widget> list = [
      Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Add new subject',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    )),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  subjects.add(controller.text);
                  controller.text = '';
                });
              },
              child: const Text(
                "SAVE",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          )
        ],
      )
    ];

    list.addAll(subjects.map((e) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Text(
              e,
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    subjects.remove(e);
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.white))
          ],
        ))));

    return list;
  }
}
