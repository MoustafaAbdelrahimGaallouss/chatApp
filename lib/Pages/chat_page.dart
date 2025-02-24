import 'package:chat_app/Widgets/chat_babble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/massage_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final scrollingController = ScrollController();
  CollectionReference massages =
      FirebaseFirestore.instance.collection(kmassagesCollection);
  TextEditingController massageController = TextEditingController();

// Mwthods
  void scrollDown() {
    scrollingController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> deleteCollection(String collectionPath) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionPath);
    final batch = FirebaseFirestore.instance.batch();

    final querySnapshot = await collectionRef.get();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var userName = arguments['userName'];
    var email = arguments['email'];
    return StreamBuilder<QuerySnapshot>(
        stream: massages.orderBy(kSendAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List massagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massagesList.add(
                MassageModel.fromJson(
                  snapshot.data!.docs[i],
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      klogo,
                      height: 60,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$userName',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        Text(
                          '$email',
                          style:  TextStyle(
                              color: Colors.white.withOpacity(0.5), fontSize: 12,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollingController,
                      itemCount: massagesList.length,
                      itemBuilder: (context, index) {
                        return massagesList[index].id == email
                            ? chatBubble(
                                massage: massagesList[index],
                              )
                            : chatBubbleForFriend(
                                massage: massagesList[index],
                              );
                      },
                    ),
                  ),
                  /////////////////////////////////
                  Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 16,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: massageController,
                                // onSubmitted
                                onSubmitted: (value) {
                                  massages.add({
                                    kMessage: massageController.text,
                                    kSendAt: DateTime.now(),
                                    'from': userName,
                                    'id': email,
                                  });
                                  massageController.clear();
                                  scrollDown();
                                },
                                //////////////////////
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: 'Type a message',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                      icon: const Icon(Icons.send,
                                          color: kPrimaryColor),
                                      onPressed: () {
                                        massages.add({
                                          kMessage: massageController.text,
                                          kSendAt: DateTime.now(),
                                          'from': userName,
                                          'id': email,
                                        });
                                        massageController.clear();
                                        scrollDown();
                                      }),
                                )),
                          ],
                        )),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
