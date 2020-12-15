part of 'pages.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Page"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children:[
          Container(

          ),
        ]
      ),
    );
  }
}