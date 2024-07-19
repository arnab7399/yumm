import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yumm/service/shared_pref.dart';
import 'package:yumm/widget/custom-widget.dart';

class Myorder extends StatefulWidget {
  const Myorder({super.key});

  @override
  State<Myorder> createState() => _MyorderState();
}

class _MyorderState extends State<Myorder> {
String? Id;
   getthesharedpref()async{
  Id= await SharedPreferenceHelper().getUserId();
    setState(() {
      print(Id);
    });
      }


  ontheload() async {
await getthesharedpref();

    orders = await getOrders(Id!);

    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }
Stream? orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: 
      AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text("My Orders",style:Mywidget.skipText(),
        ),
      ),
      body: Container(
      child: SafeArea(
        
        child: Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: StreamBuilder(
              stream: orders, 
              builder: (context,AsyncSnapshot snapshot){
              return snapshot.hasData?ListView.builder(
                 padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      
                      child: Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(20),
                        
                        child: Container(
                          // color: Colors.amber,
                          decoration: BoxDecoration(  borderRadius: BorderRadius.circular(20),color:Color.fromARGB(255, 243, 176, 6)),
                          // height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Address : "+ds["Address"],style: AppWidget.semiBoldTextFeildStyleW()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Items : "+ds["Item"],style: AppWidget.semiBoldTextFeildStyleW()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Ammount : "+ds["Ammount"],style: AppWidget.semiBoldTextFeildStyleW()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Name : "+ds["Name"],style: AppWidget.semiBoldTextFeildStyleW()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Phone : "+ds["phone"],style: AppWidget.semiBoldTextFeildStyleW()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                                child: Text("Email : "+ds["Email"],style: AppWidget.semiBoldTextFeildStyleW()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ):CircularProgressIndicator();
            }),
          ),
        )
      ),
    )

    );
  }

  Future<Stream<QuerySnapshot>> getOrders(String id) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection('Order')
        .snapshots();
  }
}
