part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
            ),
            body: Stack(
              children: [Container(
                margin: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          controller: ctrlName,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_rounded),
                                labelText: 'Full Name',
                                hintText: "Write your full name",
                                border: OutlineInputBorder())),
                        TextFormField(
                          controller: ctrlEmail,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail_sharp),
                                labelText: 'Email',
                                hintText: "Write your active email",
                                border: OutlineInputBorder())),
                        TextFormField(
                          controller: ctrlPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key_sharp),
                                labelText: 'Password',
                                border: OutlineInputBorder())),
                        
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton.icon(
                            icon: Icon(Icons.upload_sharp),
                            label: Text("Sign Up"),
                            textColor: Colors.white,
                            color: Colors.blue[500],
                            onPressed: () async {
                              if (ctrlName == "" ||
                                  ctrlEmail == "" ||
                                  ctrlPassword == "") {
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
                                String result = await AuthServices.signUp(
                                    ctrlEmail.text,
                                    ctrlPassword.text,
                                    ctrlName.text);
                                if (result == "success") {
                                  Fluttertoast.showToast(
                                    msg: "sign up successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  setState((){
                                isLoading = false;
                              });
                                  SizedBox(
                          height: 40,
                        );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: result,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  setState((){
                                isLoading = false;
                              });
                                }
                              }
                            }),
                        SizedBox(height: 25),
                        RichText(
                          text: TextSpan(
                              text: 'Already registered? Sign In.',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignInPage();
                                  }));
                                }),
                        ),
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
                ])
                ));
  }
}
