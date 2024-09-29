import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Card_view extends StatefulWidget {
  const Card_view({super.key, required this.id});
  final id;

  @override
  State<Card_view> createState() => _Card_viewState();
}

class _Card_viewState extends State<Card_view> {
  Future<void>Getbyid() async{
    Product =await FirebaseFirestore.instance.collection("Productcollection").doc(widget.id).get();//product nn paranja variable ll data nd
  }
  DocumentSnapshot?Product;
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
          title: Text(
            "NAME:",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10,top: 10),
              child: Card(
                child: Text(Product!["Product_Details"],
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
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
