import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(child: Text('游戏页面内容')),
      ),
    );
  }
}
