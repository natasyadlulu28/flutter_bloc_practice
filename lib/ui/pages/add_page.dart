part of 'pages.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  bool isLoading = false;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }
  
  @override
  void dispose() {
    productName.dispose();
    productPrice.dispose();
    setState(() {
      imageFile = null;
    });
    super.dispose();
  }

  void clearForm() {
    productName.clear();
    productPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Data"),
          centerTitle: true,
          leading: Container(),
        ),
        body: Stack(
                  children: [Container(
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
                                  onPressed: () async{
                                    chooseImage();
                                    },
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
                                  onPressed: () async {
                                    chooseImage();
                                  },
                                  icon: Icon(Icons.image_rounded),
                                  label: Text("Re-choose from galery"),
                                ),
                                Semantics(
                                  child: Image.file(File(imageFile.path),
                                      width: 100),
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
                              setState((){
                                isLoading = true;
                              });
                              Products product = Products(
                                  "", productName.text, productPrice.text, "");
                              bool result = await ProductServices.addProduct(
                                  product, imageFile);
                              if (result == true) {
                                Fluttertoast.showToast(
                                  msg: "Add Product Successful!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16,
                                );
                                clearForm();
                                setState((){
                                isLoading = false;
                              });
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Failed! Try Again",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16,
                                );
                                setState((){
                                isLoading = false;
                              });
                              }
                            }
                            SizedBox(
                              height: 40,
                            );
                          }),
                    ])
              ])),
              isLoading==true ?
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    )
                    )
                    :
                    Container()

                  ],));
  }
}
