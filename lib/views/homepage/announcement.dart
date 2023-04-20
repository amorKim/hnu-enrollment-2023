import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {

  var advisoryList = ['Adv1','Adv2','Adv3','Adv4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Text('HNU ADVISORY',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 15,),
          CarouselSlider(
            items:[
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/advisory_1.jpg'),
                      fit: BoxFit.cover,
                    )
                ),

              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/advisory_2.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/advisory_3.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/advisory_4.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),

            ],
            options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.8,
            ),
          ),
          const Text('THE WORD',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          CarouselSlider(
            items:[

              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/theWord_1.20.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(

                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/theWordCover.png'),
                      fit: BoxFit.cover,
                    )
                ),
              )
            ],
            options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                autoPlay: true,
                viewportFraction: 0.8
            ),
          ),
          const Text('EXAMINATION SCHEDULE',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          CarouselSlider(
            items:[

              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/exam_1.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/exam2.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ],
            options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                autoPlay: true,
                viewportFraction: 0.8
            ),
          ),
          const Text('OTHERS',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          CarouselSlider(
            items:[

              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/noclasses.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/hagit_sa_semana_santa2023.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ],
            options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                autoPlay: true,
                viewportFraction: 0.8
            ),
          ),

        ],
      ),
    );

  }
}
