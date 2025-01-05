import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordCardPage extends StatefulWidget {
  final String title;

  WordCardPage({required this.title});

  @override
  _WordCardPageState createState() => _WordCardPageState();
}

class _WordCardPageState extends State<WordCardPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isFront = true; // 标识当前是否是正面

  @override
  void initState() {
    super.initState();
    // 创建动画控制器，持续时间设置为 1 秒
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // 定义动画，从 0 到 pi（180 度）
    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 切换卡片正反面
  void _toggleCard() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }
  void _onButtonPressed(String action) {
    // 根据按钮的不同，处理不同的逻辑
    if (action == 'learn') {
      // 开始学习单词
    } else if (action == 'definition') {
      // 查看释义
    } else if (action == 'favorite') {
      // 收藏单词
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width - 32.0; // 卡片宽度填满屏幕宽度并留有边距
    double cardHeight = MediaQuery.of(context).size.height * 0.70; // 卡片高度占屏幕高度的 70%

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // middle: Text(widget.title),
        previousPageTitle: '返回',
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey.withOpacity(0.4),
            width: 0.5, // 设置边框厚度
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: _toggleCard,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // 正面卡片
                        if (_animation.value <= pi / 2)
                          Transform(
                            transform: Matrix4.rotationY(_animation.value),
                            alignment: Alignment.center,
                            child: _buildFrontCard(cardWidth, cardHeight),
                          ),
                        // 背面卡片
                        if (_animation.value > pi / 2)
                          Transform(
                            transform: Matrix4.rotationY(_animation.value - pi),
                            alignment: Alignment.center,
                            child: _buildBackCard(cardWidth, cardHeight),
                          ),
                      ],
                    );
                  },
                ),
                // 按钮区域
                SizedBox(height: 16.0),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 正面：显示单词
  Widget _buildFrontCard(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.book,
              size: 80.0,
              color: CupertinoColors.activeBlue,
            ),
            SizedBox(height: 20.0),
            Text(
              widget.title, // 显示标题作为单词
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 反面：显示释义
  Widget _buildBackCard(double width, double height) {
    return Transform(
      transform: Matrix4.rotationY(pi), // 反向旋转卡片
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.info_circle_fill,
                size: 80.0,
                color: CupertinoColors.systemGrey,
              ),
              SizedBox(height: 20.0),
              Transform(
                transform: Matrix4.rotationY(pi), // 文字反向旋转
                alignment: Alignment.center,
                child: Text(
                  '这是 "${widget.title}" 的释义',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: CupertinoColors.systemGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 按钮构建
  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CupertinoButton(
          child: Column(
            children: [
              Icon(CupertinoIcons.play_circle_fill, size: 40,color: CupertinoColors.systemGreen,),
              // Text("学习", style: TextStyle(fontSize: 14))
            ],
          ),
          onPressed: () => _onButtonPressed('learn'),
        ),
        CupertinoButton(
          child: Column(
            children: [
              Icon(CupertinoIcons.info_circle_fill, size: 40,color: CupertinoColors.systemGrey4,),
              // Text("释义", style: TextStyle(fontSize: 14))
            ],
          ),
          onPressed: () => _onButtonPressed('definition'),
        ),
        CupertinoButton(
          child: Column(
            children: [
              Icon(CupertinoIcons.star_fill, size: 40,color: CupertinoColors.systemOrange,),
              // Text("收藏", style: TextStyle(fontSize: 14,))
            ],
          ),
          onPressed: () => _onButtonPressed('favorite'),
        ),
      ],
    );
  }
}
