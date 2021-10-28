import 'package:flutter/material.dart';
//import 'package:tim/functional/managment.dart';
import 'package:tim/models/getFeeds.dart';
import 'package:tim/screens/feed_page.dart';
import 'package:tim/screens/profile.dart';
import 'package:intl/intl.dart';

import 'functional/managment.dart';
import 'screens/home.dart';

class FeedComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Feed>(
            stream:PageManager.getFeeds(),
            builder: (context, snapshot) {
              //print(snapshot.data);
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange, valueColor:AlwaysStoppedAnimation<Color>(Colors.white),));
              }
              else
              return ListView.builder(
                itemCount: snapshot.data.count,
                itemBuilder: (context, index){
                  return  GestureDetector(
                    onTap: () {
                     // print("${snapshot.data.results[index].id}  idin e feedi");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedPage(id: snapshot.data.results[index].id)));},
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.grey[100],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              //"https://www.kenyons.com/wp-content/uploads/2017/04/default-image.jpg",
                              snapshot.data.results[index].feedImages.isNotEmpty?snapshot.data.results[index].feedImages[0].image:"https://www.kenyons.com/wp-content/uploads/2017/04/default-image.jpg",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      //mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.yMd()
                                              .format(snapshot.data.results[index].createdAt),
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.results[index].title,
                                          //textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Text(
                                      snapshot.data.results[index].text,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          // Card(
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   color: Colors.grey[100],
          //   elevation: 3,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Image.network(
          //           'https://picsum.photos/seed/789/300',
          //           width: double.infinity,
          //           height: 120,
          //           fit: BoxFit.cover,
          //         ),
          //         Padding(
          //           padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.max,
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       'Card Title',
          //                       style: TextStyle(
          //                         fontFamily: 'Poppins',
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                     Text(
          //                       DateTime.now().toString(),
          //                       style: TextStyle(
          //                         fontFamily: 'Poppins',
          //                         color: Colors.amber,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          //                 child: Text(
          //                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum gravida mattis lorem, et posuere tortor rutrum vitae. Vivamus lacinia fringilla libero, at maximus quam imperdiet sed. Pellentesque egestas eget ex a consectetur.',
          //                   maxLines: 3,
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Card(
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   color: Colors.grey[100],
          //   elevation: 3,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(0),
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Image.network(
          //           'https://picsum.photos/seed/789/300',
          //           width: double.infinity,
          //           height: 120,
          //           fit: BoxFit.cover,
          //         ),
          //         Padding(
          //           padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //                 child: Row(
          //                   mainAxisSize: MainAxisSize.max,
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       'Card Title',
          //                       style: TextStyle(
          //                         fontFamily: 'Poppins',
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                     Text(
          //                       DateTime.now().toString(),
          //                       style: TextStyle(
          //                         fontFamily: 'Poppins',
          //                         color: Colors.orange,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          //                 child: Text(
          //                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum gravida mattis lorem, et posuere tortor rutrum vitae. Vivamus lacinia fringilla libero, at maximus quam imperdiet sed. Pellentesque egestas eget ex a consectetur.',
          //                   maxLines: 2,
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )
    );
  }
}
