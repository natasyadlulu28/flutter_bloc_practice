part of 'pages.dart';

class DetailsPages extends StatefulWidget {
  DetailsPages({Key key, this.product}) : super(key: key);
  final Products product;

  @override
  _DetailsPagesState createState() => _DetailsPagesState();
}

class _DetailsPagesState extends State<DetailsPages> {
  Products product;
  TextEditingController ctrlName;
  TextEditingController ctrlPrice;
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
  void initState() {
    product = widget.product;
    ctrlName = TextEditingController(text: product.name);
    ctrlPrice = TextEditingController(text: product.price);
    super.initState();
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
        backgroundColor: HexColor("A5D6A7"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ctrlName,
                    // initialValue: product.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_box),
                        labelText: 'Product Name',
                        hintText: "product name",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ctrlPrice,
                    // initialValue: product.price,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: 'Price',
                        hintText: "price",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Image.network(product.image),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        color: HexColor("A5D6A7"),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text("Update Product"),
                        onPressed: () async {
                          // ctrlName.text = product.name;
                          // ctrlPrice.text = product.price;
                          if (ctrlName.text == "" || ctrlPrice.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please fill all fields!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            Products product = Products(
                                widget.product.id,
                                ctrlName.text,
                                ctrlPrice.text,
                                widget.product.image);
                            bool result =
                                await ProductServices.updateProduct(product);

                            if (result == true) {
                              Fluttertoast.showToast(
                                  msg: "Update product successful.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              clearForm();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Update product failed. Please try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      RaisedButton(
                          color: Colors.red[200],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Text("Delete Product"),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete Confirmation"),
                                    content: Text("Are you sure to delete " +
                                        product.name +
                                        "?"),
                                    actions: [
                                      FlatButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await ProductServices.deleteProduct(
                                              product);
                                          Fluttertoast.showToast(
                                              msg: "Delete product successful.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          clearForm();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Yes"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      )
                                    ],
                                  );
                                });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          ),
        ),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitFadingCircle(
                  size: 50,
                  color: Colors.blue,
                ),
              )
            : Container()
      ]),
    );
  }
}
