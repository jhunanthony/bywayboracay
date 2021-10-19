

/*class LikeButtonWidget extends StatefulWidget {
  Items items;

  LikeButtonWidget({this.items});
  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    SaveService saveService = Provider.of<SaveService>(context, listen: false);


    return LikeButton(
        countPostion: CountPostion.top,
        size: 30,
        circleColor: CircleColor(start: Colors.pink[50], end: Colors.pink),
        bubblesColor: BubblesColor(
          dotPrimaryColor: Colors.pink[100],
          dotSecondaryColor: Colors.pink,
        ),

        //bool here
        isLiked: isSaved,
        //edit looks here

        likeBuilder: (isLiked) {
          return Icon(
            Icons.bookmark,
            color: isLiked ? Colors.pink : Colors.white,
            size: 30,
          );
        },
        likeCount: widget.items.saves,
        likeCountPadding: EdgeInsets.only(
          bottom: 5,
        ),
        countBuilder: (int count, bool isLiked, String text) {
          var color = isLiked ? Colors.pink[300] : Colors.white;
          Widget result;
          if (count == 0) {
            result = Text(
              " ",
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
          this.isSaved = !isLiked;
          widget.items.saves += this.isSaved ? 1 : -1;

          //TO DO: server request push new value likes

          return !isLiked;
        });
  }
}*/
