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
            "201135     LAB 2 MIS",
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.bold),
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
  final TextEditingController _editingController = TextEditingController();

  List<String> clothes = [];

  @override
  void initState() {
    clothes = [
      "T-shirt",
      "Dress",
      "Jeans",
      "Skirt",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      child: Column(children: buildClothesWidgets()),
    );
  }

  List<Widget> buildClothesWidgets() {
    List<Widget> list = [
      Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(5.0, 20, 5.0, 50),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white12,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const Text(
                "Add clothing item",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add Item'),
                            content: TextField(
                              controller: controller,
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    clothes.add(controller.text);
                                    controller.clear();
                                  });
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.red)),
              )
            ],
          ))
    ];

    list.addAll(clothes.map((e) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white12,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Text(
              e,
              style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: IconButton(
                  onPressed: () {
                    _editingController.text =
                        e; // Set the initial value of the TextField to the current value of the item
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('Edit Item'),
                          content: TextField(
                            controller: _editingController,
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancel',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Save',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                setState(() {
                                  int index = clothes.indexOf(e);
                                  if (index != -1) {
                                    clothes[index] = _editingController.text;
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.red)),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.fromLTRB(8, 3, 3, 3),
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Delete',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  setState(() {
                                    clothes.remove(e);
                                  });
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red)),
            )
          ],
        ))));

    return list;
  }
}
