import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class thirdpage3 extends StatefulWidget {
  const thirdpage3({super.key, required this.id});
  final id;

  @override
  State<thirdpage3> createState() => _thirdpage3State();
}

class _thirdpage3State extends State<thirdpage3> {
  Future<void>Getbyid() async{
    todolist_2 =await FirebaseFirestore.instance.collection("MYTODOAPP").doc(widget.id).get();//product nn paranja variable ll data nd
  }
  DocumentSnapshot?todolist_2;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Getbyid(),builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return CircularProgressIndicator(color: Colors.black,);
      }
      if(snapshot.hasError){
        return Text("${snapshot.error}");
      }
      return   Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade200,
          title: Text(
            "MyTodo_List:",
            style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        backgroundColor: Colors.brown.shade200,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10,top: 10),
              child: Card(
                color: Colors.pink.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Text("Todolist:${todolist_2!["do_list"] ?? ""}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                          ],
                        ),
                      ),Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Text("Notes:${todolist_2!["notes"] ?? ""}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                          ],
                        ),
                      ),Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Text("Day:${todolist_2!["day"] ?? ""}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                          ],
                        ),
                      ),Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Text("Goal:${todolist_2!["goals"] ?? ""}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                          ],
                        ),
                      ),Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Text("Meals:${todolist_2!["meals"] ?? ""}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
    );
  }
}
