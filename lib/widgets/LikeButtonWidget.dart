import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class LikeButtonWidget extends StatefulWidget {
 
Items items;

LikeButtonWidget({this.items});
  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
   
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;
    
    return LikeButton(
                            countPostion: CountPostion.top,
                            size: 30,
                            circleColor: CircleColor(
                                start: Colors.pink[50], end: Colors.pink),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.pink[100],
                              dotSecondaryColor: Colors.pink,
                            ),

                            //bool here
                            isLiked: isLiked,
                            //edit looks here

                            likeBuilder: (isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.pink : Colors.white,
                                size: 30,
                              );
                            },
                            likeCount: widget.items.likes,
                            likeCountPadding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            countBuilder:
                                (int count, bool isLiked, String text) {
                              var color =
                                  isLiked ? Colors.pink[300] : Colors.white;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  "love",
                                  style: TextStyle(color: color, fontSize: 12),
                                );
                              } else
                                result = Text(
                                  text,
                                  style: TextStyle(color: color, fontSize: 12),
                                );
                              return result;
                            },
                            onTap: (isLiked) async {
                              this.isLiked = !isLiked;
                              widget.items.likes += this.isLiked ? 1 : -1;

                              //TO DO: server request push new value likes

                              return !isLiked;
                            });
  }
}