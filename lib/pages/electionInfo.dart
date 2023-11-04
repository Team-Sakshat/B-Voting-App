import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;
  const ElectionInfo(
      {super.key, required this.ethClient, required this.electionName});

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();
  var arr = [
    "assets/bdcoe.png",
    "assets/brl.png",
    "assets/pc.png",
    "assets/ccc.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xff6979F8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      FutureBuilder<List>(
                          future: getCandidatesNum(widget.ethClient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Text(
                              snapshot.data![0].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                      Text(
                        "Total Candidates",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              FutureBuilder(
                  future: getCandidatesNum(widget.ethClient),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data![0].toInt(); i++)
                            FutureBuilder<List>(
                              future: candidateInfo(i, widget.ethClient),
                              builder: (context, candidatesnapshot) {
                                if (candidatesnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  SizedBox(
                                    height: 10,
                                  );
                                  return ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Color(0xff6979F8),
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    style: ListTileStyle.list,
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          child: Image.asset(arr[i]),
                                          width: 45,
                                          height: 45,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(candidatesnapshot.data![0][0]
                                            .toString()),
                                      ],
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        // vote(i, widget.ethClient);
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          showAlertDialog(context);
                                        });
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Color(0xff6979F8),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Center(
                                          child: Text(
                                            "Vote",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Lottie.asset("assets/successful.json"),
      content: Container(
        height: 80,
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 2,
            ),
            Text(
              "Voted Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(
              height: 12,
            ),
            okButton
          ]),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
