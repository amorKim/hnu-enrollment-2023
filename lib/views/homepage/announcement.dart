import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  late Stream slides;

  Stream _queryDb(){
    slides = FirebaseFirestore.instance
        .collection('announcement')
        .snapshots()
        .map((list) => list.docs.map((doc) => doc.data()));
    return slides;
  }
  double pageOffset = 0;
  @override
  void initState(){
    initializeApp();
    _queryDb();
    controller
        .addListener(() {
      setState(() {
        pageOffset = controller.page!;
      });
    });
    super.initState();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp();
  }

  final PageController controller = PageController(
      viewportFraction: 0.8, initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: slides,
            builder: (context, AsyncSnapshot snap) {
              List slideList = snap.data.toList();
              if (snap.hasError){
                return Text(snap.error.toString());
              }
              if(snap.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              return PageView.builder(
                  controller: controller,
                  itemCount: slideList.length,
                  itemBuilder: (context, int index) {
                    return _buildStoryPage(slideList[index]);
                  });
            })
    );
  }
  _buildStoryPage(Map data){
    return Container(
      margin: const EdgeInsets.only(
          top: 30, bottom: 50, right: 10, left: 20
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data['img']),
        ),
      ),
    );
  }
}

