import 'package:flutter/material.dart';

class BottomTile extends StatelessWidget {
  final Widget image;
  final Widget caption;
  final GestureTapCallback onTap;

  const BottomTile({
    Key key,
    this.image,
    this.caption,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: this.onTap,
          splashColor: Colors.transparent,
          highlightColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.white.withOpacity(0.10),
            ),
            padding: EdgeInsets.only(top: 6.0, left: 6.0, bottom: 10.0),
            width: 96,
            height: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[image, caption],
            ),
          ),
        ),
      ),
    );
  }
}
