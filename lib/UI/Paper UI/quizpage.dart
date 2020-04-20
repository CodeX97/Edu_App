import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:edu_app/Datalayer/paper.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/Paper UI/quizfinish.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final Paper paper;

  const QuizPage({Key key, @required this.paper}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  int _currentIndex = 0;
  int timer;
  int correct = 0;
  bool canceltimer = false;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration:
          //Duration(hours: widget.paper.htime, minutes: widget.paper.mtime),
          Duration(seconds: 10),
    );
    starttimer();
    controller.reverse(from: 1.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    Size size = MediaQuery.of(context).size;
    Question question = widget.paper.qs[_currentIndex];
    final List<Answer> options = question.as;
    // Uint8List bytes;
    // Uint8List qbytes;
    // if (question.q.i != "") {
    //   qbytes = base64.decode(question.q.i);
    // }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        body: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   alignment: Alignment.bottomCenter,
            //   image: AssetImage('assets/images/boygirl.png'),
            // ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.blue[800],
                Colors.blue[700],
                Colors.blue[600],
                Colors.blue[400],
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: AppColor.colors[2].color,
                      ),
                      height: size.height * 0.07,
                      width: size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Time Remaining : ",
                            style: TextStyle(
                              color: AppColor.colors[1].color,
                              fontSize: size.height * 0.03,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: AppColor.colors[3].color,
                            ),
                            alignment: Alignment.center,
                            height: size.height * 0.05,
                            width: size.width * 0.3,
                            child: AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Text(
                                    timerString,
                                    style: TextStyle(
                                      fontSize: size.height * 0.03,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Container(
                      color: Colors.white,
                      height: size.height * 0.005,
                      width: size.width,
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white70,
                      ),
                      height: size.height * 0.06,
                      width: size.width * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: _currentIndex == (0)
                                ? Icon(null)
                                : Icon(Icons.arrow_back_ios),
                            color: AppColor.colors[1].color,
                            onPressed: _previous,
                          ),
                          SizedBox(width: size.width * 0.035),
                          CircleAvatar(
                            backgroundColor: AppColor.colors[1].color,
                            child: Text(
                              "${_currentIndex + 1}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: size.width * 0.035),
                          IconButton(
                            icon: _currentIndex == (widget.paper.qs.length - 1)
                                ? Icon(null)
                                : Icon(Icons.arrow_forward_ios),
                            color: AppColor.colors[1].color,
                            onPressed: _next,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    SizedBox(width: size.width * 0.05),
                    // Expanded(
                    //   child: Container(
                    //     color: Colors.white,
                    //     child:
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                          "Q" +
                              (_currentIndex + 1).toString() +
                              " : " +
                              widget.paper.qs[_currentIndex].q.t,
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        ...options.map(
                          (option) => Column(
                            children: [
                              RadioListTile(
                                title: Text(
                                  "${option.t}",
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                activeColor: Colors.white,
                                groupValue: _answers[_currentIndex],
                                value: option.t,
                                onChanged: (value) {
                                  setState(() {
                                    _answers[_currentIndex] = option.t;
                                  });
                                },
                              ),
                              // Container(
                              //   child: (bytes != null)
                              //       ? Image.memory(
                              //           bytes,
                              //           height: size.height * 0.15,
                              //           width: size.width * 0.15,
                              //         )
                              //       : Container(),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //   ),
                    // ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      child: _currentIndex == (widget.paper.qs.length - 1)
                          ? RaisedButton(
                              color: AppColor.colors[1].color,
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: _submit,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours % 60).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void starttimer() {
    timer = 10;
    //timer = (widget.paper.htime * 60 * 60) + (widget.paper.mtime * 60);
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      if (timer < 2) {
        t.cancel();
        _submitTimer();
      } else if (canceltimer == true) {
        t.cancel();
      } else {
        timer--;
      }
    });
  }

  void _previous() {
    if (_currentIndex > (0)) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _next() {
    if (_currentIndex < (widget.paper.qs.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _submit() {
    if (_currentIndex == (widget.paper.qs.length - 1)) {
      canceltimer = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          nextPage();
        });
      });
    }
  }

  void nextPage() {
    canceltimer = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuizFinishedPage(
            questions: widget.paper.qs, answers: _answers, paper: widget.paper),
      ),
    );
  }

  void _submitTimer() {
    _key.currentState.showSnackBar(SnackBar(
      content: Text("Time is Up !"),
    ));
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        nextPage();
      });
    });
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  canceltimer = true;

                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
