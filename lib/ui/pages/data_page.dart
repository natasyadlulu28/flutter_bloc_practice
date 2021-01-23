part of 'pages.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("product");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
        backgroundColor: HexColor("A5D6A7"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            width: double.infinity,
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: productCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Failed to get products data");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFadingCircle(
                    size: 50,
                    color: Colors.blue,
                  );
                }
                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot doc) {
                    return ProductCard(
                      product: Products(
                          doc.data()['id'],
                          doc.data()['name'],
                          doc.data()['price'],
                          doc.data()['image']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
