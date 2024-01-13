import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                controller.lastPage(value == 3);
              },
              controller: controller.pageController,
              children: [
                customContainer(newColor: Colors.deepPurple[100]!, images: 'images/1.png'),
                customContainer(newColor: Colors.white, images: 'images/2.png'),
                customContainer(newColor: Colors.blue[100]!, images: 'images/3.png'),
                customContainer(newColor: Colors.redAccent[100]!, images: 'images/4.png'),
              ],
            ),
            Container(
                alignment: const Alignment(0, 0.80),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.pageController.jumpToPage(3);
                        },
                        child: const Text('Skip'),
                      ),
                      SmoothPageIndicator(controller: controller.pageController, count: 4),
                      controller.lastPage.value
                          ? GestureDetector(
                              onTap: () async {
                                  prefs.setBool("initial", true);
                                Get.offAllNamed(Routes.HOME);
                              },
                              child: const Text('Done'))
                          : GestureDetector(
                              onTap: () {
                                controller.pageController
                                    .nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                              },
                              child: const Text('Next')),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Container customContainer({required Color newColor, required String images}) {
    return Container(
      color: newColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            images,
            height: 300,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          const Spacer(),
          const Flexible(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
                'The default is to snap to the closest page, but you can turn that off so that you scroll smoothly across pages without stopping at any particular spot.'),
          )),
          const SizedBox(
            height: 30,
          ),
          const Text('Ok lets go...'),
          const Spacer()
        ],
      ),
    );
  }
}
