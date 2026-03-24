import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vasool_raja_maruthuva_manai/features/dashboard/dashboard.dart';


class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => OnboardingPageState(); 
}

class OnboardingPageState extends State<OnboardingPage> {
  final controller=PageController();
  bool isLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (i){
            setState(() {
              isLastPage=i==2;
            });
          },
          controller: controller,
          children: [
            Container(
              color:Colors.teal,
              child:Center(child:  Stack(children: [Image.network("https://media.gettyimages.com/id/1312706413/photo/modern-hospital-building.jpg?s=2048x2048&w=gi&k=20&c=2vk6X1Ais7xks0W5i-oBkL_I9EUEZwznPY9lhgRYgog="),Text("Page 1"),
              
              ])
              )
            ),
           
             Container(
              color:Colors.teal,
              child:Stack(children: [Positioned.fill(
                child: Image.network("https://media.istockphoto.com/id/1496500536/photo/hospital-bed-and-crib-for-a-newborn.jpg?s=612x612&w=0&k=20&c=6-u3v_MbnLXBUxG2ktvBa4qJe10clcSEXV1bTJfk-jc=",
                fit:BoxFit.contain
                             ),
              ),Text("Page 1"),
              ],
              )
              ),

               Container(
              color:Colors.teal,
              child:Center(child:  Stack(children: [Image.network("https://m.media-amazon.com/images/S/pv-target-images/186ca9119fdcd61339603ffbe120c17cde166cf7f949a0ea393d3d2e87ed1177.jpg"),Text("Page 1"),
              ])
              )
            ),
            
          ],
        
        ),
      ),
      bottomSheet:isLastPage? Container(
        padding: const EdgeInsets.all(20),
        height: 80,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.push("/dashboard");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            "Get Started",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ): Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height:80,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed:(){
              controller.jumpToPage(2);
            }, child: Text("SKIP")),
            Center(
              child: SmoothPageIndicator(
                controller:controller,
                count:3
              ),
            ),
            TextButton(onPressed:(){
              controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            }, child: Text("NEXT"))
          ],
        )
      ),
      
    );
  }
}