import 'package:backend_firebase/CRUD_uis/crud_ui1.dart';
import 'package:backend_firebase/CRUD_uis/crud_ui3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class crud_view extends StatefulWidget {
  const crud_view({super.key});

  @override
  State<crud_view> createState() => _crud_viewState();
}

class _crud_viewState extends State<crud_view> {
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();
  Future<void> _updateProduct(
      String id, String name, String description) async {
    _nameController.text = name;
    _descriptionController.text = description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Product Details'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Productcollection')
                    .doc(id)
                    .update({
                  'Product_Name': _nameController.text,
                  'Product_Details': _descriptionController.text,
                });
                _nameController.clear();
                _descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
  Future<void>Delete_Product(String id)async{
    await FirebaseFirestore.instance.collection("Productcollection").doc(id).delete();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return crud_add();
            },
          ));
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("                    PRODUCT VIEW",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Productcollection")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            final Product = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Product.length,
              itemBuilder: (context, index) {
                final doc = Product[index];
                final product_details = doc.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Card_view(
                        id:doc.id
                      );
                    },));
                  },
                    child: Card(
                      child: ListTile(

                        title: Text(
                          "Name : ${product_details["Product_Name"] ?? ""}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                        subtitle: Text(
                          "Details  : ${product_details["Product_Details"] ?? ""}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        trailing: Wrap(children: [
                          IconButton(
                              onPressed: () {
                                _updateProduct(doc.id, product_details["Product_Name"], product_details["Product_Details"]);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {
                                Delete_Product(doc.id);
                              },
                              icon: Icon(
                                CupertinoIcons.delete_simple,
                                color: Colors.black,
                              ))
                        ]),
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
