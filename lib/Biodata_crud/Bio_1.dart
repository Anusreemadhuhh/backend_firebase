import 'package:backend_firebase/Biodata_crud/Bio_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class firstpage1 extends StatefulWidget {
  const firstpage1({super.key});

  @override
  State<firstpage1> createState() => _firstpage1State();
}

class _firstpage1State extends State<firstpage1> {
  Future<void> Dolist_add() async {
    FirebaseFirestore.instance.collection("MYTODOAPP").add({
      "do_list":dolist_ctrl.text,
      "notes":notes_ctrl.text,
      "day":Day,
      "meals":meals_ctrl.text,
      "goals":goal_ctrl.text,

    });
    print("Data Added Successfully");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return secondpage2();
      },
    ));
  }
  String Day = 'Day';

  final List<String> _day = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Day'
  ];
  var dolist_ctrl = TextEditingController();
  var notes_ctrl = TextEditingController();
  var meals_ctrl = TextEditingController();
  var goal_ctrl = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
       automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade100,
        title: Text(
          "           MY TODO LIST",
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Icon(
            CupertinoIcons.heart_fill,
            color: Colors.pink.shade300,
            size: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: dolist_ctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Any Value";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'To do list:',
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.brown.shade200,
                      filled: true),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: notes_ctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Any Value";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Notes:',
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.brown.shade200,
                      filled: true),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child:  Container(
                  height: 55,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.brown.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      dropdownColor:Colors.brown.shade200 ,
                      value: Day,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 160),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ),
                      ),
                      items: _day.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          Day = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: goal_ctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Any Value";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Goal for the day:',
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.brown.shade200,
                      filled: true),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: meals_ctrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Any Value";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Meals:',
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.brown.shade200,
                      filled: true),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
           ElevatedButton(
               onPressed: () {

                   print("Details Submitted");
                   Dolist_add();

                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return secondpage2();
                 },));


           }, child:  Text("SUBMIT",style: TextStyle(fontSize: 20,
               fontWeight: FontWeight.bold,
               color: Colors.black ),))
        ],
      ))),
    );
  }
}
