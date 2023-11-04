import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project1/pages/electionInfo.dart';
import 'package:project1/services/functions.dart';
import 'package:project1/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff6979fb),
          centerTitle: true,
          title: Text(
            "Start Election",
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter election name"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff6979fb))),
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        await startElection(controller.text, ethClient!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ElectionInfo(
                                    ethClient: ethClient!,
                                    electionName: controller.text)));
                      }
                    },
                    child: Text(
                      "Start Election",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )))
          ],
        ),
      ),
    );
  }
}
