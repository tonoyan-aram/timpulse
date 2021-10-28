import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'suggestion_item_details.dart';

class SuggestionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SuggestionDetails()));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.grey[50],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.network(
                //   'https://picsum.photos/seed/789/300',
                //   width: double.infinity,
                //   height: 180,
                //   fit: BoxFit.cover,
                // ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Ավարտ "),
                                Text(
                                  DateFormat.yMd()
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    //color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              //color: Colors.red,
                              child: Center(child: Text("ավարտված")),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.orange,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Card Title',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // Text(
                            //   DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     color: Colors.amber,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum gravida mattis lorem, et posuere tortor rutrum vitae. Vivamus lacinia ',
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.red,
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
      ),
    );
  }
}
