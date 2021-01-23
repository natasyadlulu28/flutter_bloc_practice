part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPassword.clear();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Sign Up"),
            backgroundColor: HexColor("A5D6A7"),
          ),
          body: Stack(children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: ListView(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                          controller: ctrlName,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              labelText: 'Full Name',
                              hintText: "Write your full name",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                              ))),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: ctrlEmail,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Email',
                              hintText: "Write your active email",
                              border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                const Radius.circular(50.0),
                              ), 
                              ))),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: ctrlPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                              ))),
                      SizedBox(height: 20),
                      RaisedButton.icon(
                        icon: Icon(Icons.file_upload),
                        label: Text("Sign Up"),
                        textColor: Colors.white,
                        color: HexColor("A5D6A7"),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () async {
                          if (ctrlName.text == "" ||
                              ctrlEmail.text == "" ||
                              ctrlPassword.text == "") {
                            Fluttertoast.showToast(
                              msg: "Please Fill All Fields !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            setState(() {
                                isLoading = true;
                              });
                            String result = await AuthServices.signUp(
                                ctrlEmail.text,
                                ctrlPassword.text,
                                ctrlName.text);
                            if (result == "sucess") {
                              Fluttertoast.showToast(
                                msg: "Sign Up successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignInPage();
                                }));
                              setState(() {
                                isLoading = false;
                                clearForm();
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: result,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      RichText(
                          text: TextSpan(
                              text: 'Already Registered? Sign In',
                              style: TextStyle(color: Colors.green[700]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignInPage();
                                  }));
                                }))
                    ],
                  )
                ])),

                isLoading == true
                ?
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SpinKitFadingCircle(
                    size : 50,
                    color : Colors.blue,
                  )
                )
                :
                Container()
          ]),
        ));
  }
}
