import 'package:doctot_sasthoo/Screen_page/ReportList_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class feedback_page extends StatefulWidget {
  const feedback_page({Key key}) : super(key: key);

  @override
  _feedback_pageState createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color(0xff31AF4E),
        centerTitle: true,
        title: Text(
          "FeedBack",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(decoration: BoxDecoration(
                     image: new DecorationImage(image:AssetImage('assets/images/bg.png'),
                     fit: BoxFit.cover,

                    ),),
               child: Column(
                    children: [
                   Container(
                    height: 400,
                     child: PhotoView(
                      imageProvider: AssetImage("assets/images/doctor.jpeg"),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'FeedBack...',
                      labelText: 'FeedBack',
                      isDense: true,
                      border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
                      maxLines: 5,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reportlist_page()));
                  },
                  style: ElevatedButton.styleFrom(
                primary: Color(0xff31AF4E),
                //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                //fontSize: 30,
                fontWeight: FontWeight.bold)),
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
