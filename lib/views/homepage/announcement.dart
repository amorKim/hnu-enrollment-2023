import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  late Stream advisorySlides;
  late Stream schedSlides;
  late Stream otherSlides;
  late Stream theWordSlides;

  Stream _queryAnnouncementDb() {
    advisorySlides = FirebaseFirestore.instance
        .collection('announcement')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return advisorySlides;
  }

  Stream _queryExamDb() {
    schedSlides = FirebaseFirestore.instance
        .collection('announcement exam schedule')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return schedSlides;
  }

  Stream _queryOthersDb() {
    theWordSlides = FirebaseFirestore.instance
        .collection('announcement theWord')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return theWordSlides;
  }

  Stream _queryTheWordDb() {
    otherSlides = FirebaseFirestore.instance
        .collection('announcement others')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return otherSlides;
  }

  double pageOffset = 0;
  @override
  void initState() {
    initializeApp();
    _queryAnnouncementDb();
    _queryExamDb();
    _queryOthersDb();
    _queryTheWordDb();
    super.initState();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp();
  }

  final PageController controller = PageController(viewportFraction: 0.8, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text('HNU ADVISORY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
            height: 300,
              child: StreamBuilder(
              stream: advisorySlides,
              builder: (context, AsyncSnapshot snap) {
              List slideList = snap.data.toList();
              if (snap.hasError) {
                return Text(snap.error.toString());
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
                return PageView.builder(
                controller: controller,
                itemCount: slideList.length,
                itemBuilder: (context, int index) {
                return _buildStoryPage(slideList[index]);
                },
              );
              },
              ),
              ),
            const SizedBox(height: 10,),
            const Text('EXAMINATION SCHEDULE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
            height: 300,
              child: StreamBuilder(
                stream: schedSlides,
                builder: (context, AsyncSnapshot snap) {
                List slideList = snap.data.toList();
                if (snap.hasError) {
                return Text(snap.error.toString());
                }
                if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
                }
                return PageView.builder(
                controller: controller,
                itemCount: slideList.length,
                itemBuilder: (context, int index) {
                return _buildStoryPage(slideList[index]);
                },
                );
                },
                ),
                ),
            const SizedBox(height: 10,),
            const Text('THE WORD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream: theWordSlides,
                builder: (context, AsyncSnapshot snap) {
                  List slideList = snap.data.toList();
                  if (snap.hasError) {
                    return Text(snap.error.toString());
                  }
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return PageView.builder(
                    controller: controller,
                    itemCount: slideList.length,
                    itemBuilder: (context, int index) {
                      return _buildStoryPage(slideList[index]);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Text('OTHERS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
             height: 300,
              child: StreamBuilder(
              stream: otherSlides,
              builder: (context, AsyncSnapshot snap) {
              List slideList = snap.data.toList();
              if (snap.hasError) {
                return Text(snap.error.toString());
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
                return PageView.builder(
              controller: controller,
              itemCount: slideList.length,
              itemBuilder: (context, int index) {
              return _buildStoryPage(slideList[index]);
            },
            );
            },
            ),
            ),
            ],
            ),

            ),
            );
          }

  _buildStoryPage(Map data) {
    return Container(
      //height: 600.00,
      //margin: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 1, left: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: NetworkImage(data['img']),
        ),
      ),
    );
  }
}
