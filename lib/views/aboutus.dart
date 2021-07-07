import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        SizedBox(
          width: context.width,
          height: context.height,
          child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBTKn-cqrU05fSn-XEmyz49Ly5Wz9o5yttML4ejd2nOKZNl5t7_cKKNkq_nSrx-gl7oCU&usqp=CAU",
              fit: BoxFit.fill),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "About US",
              style: TextStyles.CalloutFocus.bold.size(30),
            ),
            Text(
              "Our Solutions Lost your token?About Us Terms & Condition About US iRecharge is an internet powered distribution platform that enables users purchase virtual products and services such as airtime and mobile data, internet subscriptions, pay TV, and Bulk SMS This solution which integrates seamlessly with all major Telecoms operators and service providers aims to provide value added services to consumers through as many access points as available. With instant transaction fulfillment and no need for pins or print outs, it's a quick and easy solution for airtime and subscriptions. Our Services and Solutions are designed to provide our customers with ultimate convenience…anywhere, anytime",
              style: TextStyles.CalloutFocus.bold.size(20),
            ),
          ],
        )
      ],
    ));
  }
}
