import 'package:backend_firebase/CRUD_uis/crud_ui3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backend_firebase/CRUD_uis/crud_ui3.dart';

class crud_view extends StatefulWidget {
  const crud_view({super.key});

  @override
  State<crud_view> createState() => _crud_viewState();
}

class _crud_viewState extends State<crud_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRODUCT VIEW",style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Productcollection").snapshots(),
        builder:(context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError){
            return Text("$snapshot")
          }
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Card(
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.black,
                    ),
                    Column(
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          " Details:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100,bottom: 40),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30,top: 30),
                            child: InkWell(onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return crud_update();
                              },));
                            },
                              child: Text(
                                " UPDATE",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,top: 80),
                            child: Text(
                              " DELETE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
