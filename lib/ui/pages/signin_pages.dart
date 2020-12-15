part of 'pages.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();

  @override
  void dispose() {
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
              title: Text("Sign In"),
            ),
            body: Container(
                margin: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          controller: ctrlEmail,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail_sharp),
                                labelText: 'Email',
                                hintText: "Write your Email",
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
                            icon: Icon(Icons.download_sharp),
                            label: Text("Sign In"),
                            textColor: Colors.white,
                            color: Colors.blue[500],
                            onPressed: () async {
                              if (ctrlEmail == "" || ctrlPassword == "") {
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
                                String result = await AuthServices.signIn(
                                  ctrlEmail.text,
                                  ctrlPassword.text,
                                );
                                if (result == "success") {
                                  Fluttertoast.showToast(
                                    msg: "sign in successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  SizedBox(
                          height: 40,
                        );
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MainMenu();
                                  }));
                                } else {
                                  Fluttertoast.showToast(
                                    msg: result,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              }
                            }),
                        SizedBox(height: 25),
                        RichText(
                          text: TextSpan(
                              text: 'Not Register yet? Sign Up.',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUpPage();
                                  }));
                                }),
                        ),
                      ])
                ]))));
  }
}
