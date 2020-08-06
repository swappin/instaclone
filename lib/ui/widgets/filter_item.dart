import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final String name;
  final List<int> bytes;
  final bool isFilterSelected;

  FilterItem({this.name, this.bytes, this.isFilterSelected});

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 4),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: widget.isFilterSelected ? Colors.black : Colors.grey
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height * 0.145,
            height: MediaQuery.of(context).size.height * 0.145,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(widget.bytes),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x44444444),
                  blurRadius: 15, // has the effect of softening the shadow
                  spreadRadius: 5, // has the effect of extending the shadow
                  offset: Offset(
                    6, // horizontal, move right 10
                    6, // vertical, move down 10
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
