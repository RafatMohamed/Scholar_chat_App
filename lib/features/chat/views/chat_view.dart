import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final username = email.split('@')[0];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppConstant.primaryColor),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Hi $username",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(flex: 1),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/scholar.png",
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          "Scholar Chat",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: "Scholar",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    // send
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: 90,
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppConstant.primaryColor,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(20),
                                  topStart: Radius.circular(20),
                                  bottomEnd: Radius.circular(20),
                                  bottomStart: Radius.zero,
                                ),
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxx$email",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    //recive
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            height: 90,
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppConstant.primaryColor.withOpacity(
                                  0.5,
                                ),
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(20),
                                  topStart: Radius.circular(20),
                                  bottomEnd: Radius.zero,
                                  bottomStart: Radius.circular(20),
                                ),
                              ),
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                "xxxxxxxxxxxxxxxxxxxxxxxxxxx$email",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.all(8.0),
              margin: const EdgeInsetsDirectional.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: AppConstant.primaryColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: 3,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send,
                      color: AppConstant.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
