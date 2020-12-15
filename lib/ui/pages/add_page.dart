part of 'pages.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  final productName = TextEditingController();
  final productPrice = TextEditingController();

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dispose() {
    productName.dispose();
    productPrice.dispose();
    setState(() {
      imageFile = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Data"),
          centerTitle: true,
          leading: Container(),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                        controller: productName,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.shopping_basket_rounded),
                            labelText: 'Product Name',
                            hintText: "Write your product name",
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: productPrice,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.money_rounded),
                            labelText: 'Price',
                            hintText: "Set a price",
                            border: OutlineInputBorder())),
                    SizedBox(
                      height: 20,
                    ),
                    imageFile == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.image_rounded),
                                label: Text("Choose from galery"),
                              ),
                              Text("File not found"),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.image_rounded),
                                label: Text("Re-choose from galery"),
                              ),
                              Semantics(
                                child: Image.file(File(imageFile.path),width: 100),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton.icon(
                        icon: Icon(Icons.upload_sharp),
                        label: Text("Submit"),
                        textColor: Colors.white,
                        color: Colors.blue[500],
                        onPressed: () async {
                          if (productPrice == "" ||
                              productName == "" ||
                              imageFile == null) {
                            Fluttertoast.showToast(
                              msg: "Please fill all fields!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16,
                            );
                            SizedBox(
                              height: 40,
                            );
                          } else {
                            String result = await AuthServices.addProduct(
                                productName.text, productPrice.text);
                            if (result == "success") {
                              Fluttertoast.showToast(
                                msg: "sign up successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              SizedBox(
                                height: 40,
                              );
                            } else {
                              Products product = Products("", productName.text, productPrice.text, "");
                             
                            }
                          }
                        }),
                    
                  ])
            ])));
  }
}
