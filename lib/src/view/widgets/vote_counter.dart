import 'package:flutter/material.dart';


class VoteCounter extends StatefulWidget {
 final int count ;
  VoteCounter({required this.count});
  @override
  _VoteCounterState createState() =>
      _VoteCounterState();
}

class _VoteCounterState
extends State<VoteCounter> {  int count =0;

  @override
  void initState() {
    super.initState();
    count = widget.count; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return     Container(
            height: 100.0,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                 
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_drop_up,
                     
                    ),
                    onTap: () {
                     
                      setState(() {
                        count++;
                        
                      });
                    },
                  ),
                ),
                Text(count.toString()),
                InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                  
                  ),
                  onTap: () {
                    setState(() {
                      print("Setting state");
                      count--;
                      count =
                          count > 0 ? count : 0; // decrementing value
                    });
                  },
                ),
              ],
            ),
          )
        ;
  }
}
