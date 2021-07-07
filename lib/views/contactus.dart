import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            width: context.width,
            height: context.height,
            child: Image.network(
                "https://static9.depositphotos.com/1000487/1207/i/600/depositphotos_12077336-stock-photo-abstract-green-background.jpg",
                fit: BoxFit.fill)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Submit  a Ticket/Contact US",
                  style: TextStyles.CalloutFocus.bold.size(27),
                ),
                Text(
                  "We have a provided number or supoport channels to help get what you want",
                  style: TextStyles.CalloutFocus.bold.size(20),
                ),
                Text(
                  "Contact Form",
                  style: TextStyles.CalloutFocus.bold.size(30),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Enter your Name", labelText: "Name"),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Enter your Emai", labelText: "Email"),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Enter your Number", labelText: "Phone"),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Enter your Message", labelText: "Message"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Send")),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "OFFICE ADDRESS",
                  style: TextStyles.CalloutFocus.bold.size(20),
                ),
                Row(
                  children: [
                    Text("Parent  Company",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                    SizedBox(
                      width: 30,
                    ),
                    Text("Alameen Nig ltd",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                  ],
                ),
                Row(
                  children: [
                    Text("Subsidiary",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                    SizedBox(
                      width: 30,
                    ),
                    Text("Light247",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                  ],
                ),
                Row(
                  children: [
                    Text("Company Address",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                    SizedBox(
                      width: 30,
                    ),
                    Text("Wuse 2, Abuja",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                  ],
                ),
                Row(
                  children: [
                    Text("Contact Number",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                    SizedBox(
                      width: 30,
                    ),
                    Text("07039365403",
                        style: TextStyles.CalloutFocus.bold.size(15)),
                  ],
                )
              ],
            )
          ],
        )
      ],
    ));
  }
}
