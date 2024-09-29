import 'package:backend_firebase/Biodata_crud/Bio_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class secondpage2 extends StatefulWidget {
  const secondpage2({super.key});

  @override
  State<secondpage2> createState() => _secondpage2State();
}

class _secondpage2State extends State<secondpage2> {
  var dolist_ctrl = TextEditingController();
  var notes_ctrl = TextEditingController();
  var meals_ctrl = TextEditingController();
  var goal_ctrl = TextEditingController();

  Future<void> _updatetask(
    String id,
    String do_list,
    String notes,
    String meals,
    String goal,
  ) async {
    dolist_ctrl.text = do_list;
    notes_ctrl.text = notes;
    meals_ctrl.text = meals;
    goal_ctrl.text = goal;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dolist_ctrl,
                decoration: InputDecoration(labelText: 'do_list'),
              ),
              TextField(
                controller: notes_ctrl,
                decoration: InputDecoration(labelText: 'notes'),
              ),
              TextField(
                controller: meals_ctrl,
                decoration: InputDecoration(labelText: 'meals'),
              ),
              TextField(
                controller: goal_ctrl,
                decoration: InputDecoration(labelText: 'goals'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('MYTODOAPP')
                    .doc(id)
                    .update({
                  'do_list': dolist_ctrl.text,
                  'notes': notes_ctrl.text,
                  'meals': meals_ctrl.text,
                  'goals': goal_ctrl.text,
                });
                dolist_ctrl.clear();
                notes_ctrl.clear();
                meals_ctrl.clear();
                goal_ctrl.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> Delete_dolist(String id) async {
    await FirebaseFirestore.instance.collection("MYTODOAPP").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return firstpage1();
            },
          ));
        },
        backgroundColor: Colors.brown.shade300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
          ],
        ),
      ),
      backgroundColor: Colors.brown.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        backgroundColor: Colors.brown.shade200,
        title: Row(
          children: [
            Text(
              " MY TODO LIST",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("MYTODOAPP").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            final Todolist = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Todolist.length,
              itemBuilder: (context, index) {
                final doc = Todolist[index];
                final list_details = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "MY TASKS",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink.shade700),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Todolist:${list_details["do_list"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Notes:${list_details["notes"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Day:${list_details["day"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Goal:${list_details["goals"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Meals:${list_details["meals"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                Colors.pink.shade200,
                                            side: BorderSide(
                                                color: Colors.pinkAccent,
                                                width: 3)),
                                        onPressed: () {
                                          _updatetask(
                                              doc.id,
                                              list_details["do_list"],
                                              list_details["notes"],
                                              list_details["meals"],
                                              list_details["goals"]);
                                        },
                                        child: Text(
                                          "update",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 150,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                Colors.pink.shade200,
                                            side: BorderSide(
                                                color: Colors.pinkAccent,
                                                width: 3)),
                                        onPressed: () {
                                          Delete_dolist(doc.id);
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
