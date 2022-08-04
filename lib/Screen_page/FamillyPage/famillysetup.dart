import 'package:doctot_sasthoo/route/route.dart';
import 'package:flutter/material.dart';

class FamillyListPage extends StatefulWidget {
  FamillyListPage({Key key}) : super(key: key);

  @override
  _FamillyListPageState createState() => _FamillyListPageState();
}

class _FamillyListPageState extends State<FamillyListPage> {
  String _gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff31AF4E),
        centerTitle: true,
        title: Text(
          "Familly setup",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color(0xffffffff),
              fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            builduserid(),
            SizedBox(
              height: 5,
            ),
            buildName(),
            SizedBox(
              height: 5,
            ),
            buildAge(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Gender",
                style: TextStyle(
                    color: Color(0xff596970),
                    fontSize: 12,
                    fontWeight: FontWeight.bold), //596970
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 40.0,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Color(0xffE9F2F2), //E9F2F2
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    hint: _gender == null
                        ? Text(
                            'gender',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            _gender,
                            style: TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black),
                    items: [
                      'male',
                      'female',
                      'others'
                    ].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _gender = val;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            buildRelation(),
            SizedBox(
              height: 20,
            ),
           
             Center(
               child: new ElevatedButton(
                 // onPressed: () {
                 //   Navigator.push(
                 //       context,
                 //       MaterialPageRoute(builder: (context) => HomePage()),
                 //   );
                 // },
                 onPressed: () {
                   Navigator.of(context).popAndPushNamed(RouteManeger.familylist_page);
                 },style: ElevatedButton.styleFrom(
                          primary:Color(0xff31AF4E),
                     
                     textStyle: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.bold)),
               
                 child: const Text('Save'),
               
               ),
             ),

          ],
        ),
      ),
    );
  }
}

Widget builduserid() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "User ID",
          style: TextStyle(
              color: Color(0xff596970),
              fontSize: 12,
              fontWeight: FontWeight.bold), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffE9F2F2), //E9F2F2
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //controller: emailController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.indeterminate_check_box,
                    color: Color(0xffA7ADBC),
                  ),
                  hintText: '*****',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildName() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: TextStyle(
              color: Color(0xff596970),
              fontSize: 12,
              fontWeight: FontWeight.bold), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffE9F2F2), //E9F2F2
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xffA7ADBC),
                  ),
                  hintText: 'Nazmul Islam',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAge() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Age",
          style: TextStyle(
              color: Color(0xff596970),
              fontSize: 12,
              fontWeight: FontWeight.bold), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffE9F2F2), //E9F2F2
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //controller: emailController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.view_agenda,
                    color: Color(0xffA7ADBC),
                  ),
                  hintText: '23',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildRelation() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Relation",
          style: TextStyle(
              color: Color(0xff596970),
              fontSize: 12,
              fontWeight: FontWeight.bold), //596970
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffE9F2F2), //E9F2F2
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //controller: emailController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.replay_5_outlined,
                    color: Color(0xffA7ADBC),
                  ),
                  hintText: 'brother',
                  hintStyle: TextStyle(
                      fontSize: 12.0, color: Color(0xffA7ADBC))), //A7ADBC
            ),
          ),
        ),
      ],
    ),
  );
}
