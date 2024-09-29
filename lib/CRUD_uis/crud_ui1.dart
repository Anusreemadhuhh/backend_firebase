import 'package:backend_firebase/CRUD_uis/crud_ui2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class crud_add extends StatefulWidget {
  const crud_add({super.key});

  @override
  State<crud_add> createState() => _crud_addState();
}

class _crud_addState extends State<crud_add> {
  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();

  Future<void> Product_add() async {
    FirebaseFirestore.instance.collection("Productcollection").add({
      "Product_Name":Name_ctrl.text,
      "Product_Details":Details_ctrl.text
    });
    print("Data Added Successfully");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return crud_view();
      },
    ));
  }

  final formkey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Enter The Values'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            " PRODUCT ADD",
            style: TextStyle(color: Colors.black),
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Icon(Icons.place_rounded,color: Colors.black,size: 150,),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Name_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
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
                        controller: Details_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Details',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        print("Details Submitted");
                        Product_add();
                      } else {
                        _showSnackBar(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return crud_view();
                        },
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            'View Details',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
