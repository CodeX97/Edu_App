import 'package:edu_app/Datalayer/Database.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPageRoute extends CupertinoPageRoute {
  LeaderboardPageRoute()
      : super(builder: (BuildContext context) => new LeaderboardPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new LeaderboardPage());
  }
}

class LeaderboardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ප්‍රමුඛ පුවරුව | Leaderboard'),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                AppColor.colors[1].color,
                AppColor.colors[3].color,
                AppColor.colors[3].color,
                AppColor.colors[3].color,
              ],
            ),
          ),
          child: buildScreen(context)),
    );
  }

  Widget buildScreen(context) {
    Firebase db = Firebase.getdb();
    var size = MediaQuery.of(context).size;
    List list = [];
    //db.getUsers();
    return Container(
      child: Stack(
        children: [
          ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, position) {
              return buildUser(size, list, position);
            },
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildMe(size),
          ),
        ],
      ),
    );
  }

  Widget buildUser(size, list, position) {
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
          size.width * 0.08, size.height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.colors[1].color,
            //color: Color.fromRGBO(36, 209, 99, 0.9),
          ),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Text(
            (position + 1).toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.green[900],
            ),
          ),
          trailing: Stack(children: [
            Icon(Icons.grade, color: AppColor.colors[3].color, size: 24.0),
            Text("      ලකුණු",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColor.colors[1].color,
                )),
          ]),
          title: Text(
            list[position],
            style: TextStyle(
              color: AppColor.colors[1].color,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString('name');
    return name;
  }

  Widget buildMe(size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.colors[5].color,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
            size.width * 0.08, size.height * 0.02),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.colors[1].color,
              //color: Color.fromRGBO(36, 209, 99, 0.9),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            leading: Text(
              '4',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[900],
              ),
            ),
            trailing: Container(
              width: size.width * 0.2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.grade,
                        color: AppColor.colors[3].color, size: 24.0),
                    Text("179",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.colors[1].color,
                        )),
                  ]),
            ),
            title: Text(
              'Username',
              style: TextStyle(
                color: AppColor.colors[1].color,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
