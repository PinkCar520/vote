import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'word_card_page.dart'; // 引入 WordCardPage 页面

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = ''; // 搜索框内容

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // 搜索框
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CupertinoSearchTextField(
                onChanged: (text) {
                  setState(() {
                    searchQuery = text;  // 更新搜索框内容
                  });
                },
                placeholder: '搜索单词',
              ),
            ),
            _buildCard(
              context,
              title: '当前词汇',
              icon: CupertinoIcons.book,
              onTap: () {
                // 跳转到 WordCardPage
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => WordCardPage(title: '当前词汇'),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                _buildCard(
                  context,
                  title: '今日练习',
                  icon: CupertinoIcons.timer,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WordCardPage(title: '今日练习'),
                      ),
                    );
                  },
                ),
                _buildCard(
                  context,
                  title: '昨日复习',
                  icon: CupertinoIcons.arrow_2_circlepath,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WordCardPage(title: '昨日复习'),
                      ),
                    );
                  },
                ),
                _buildCard(
                  context,
                  title: '我的收藏',
                  icon: CupertinoIcons.star_fill,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WordCardPage(title: '我的收藏'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    double cardSize = (MediaQuery.of(context).size.width - 48.0 - 16.0) / 2;
    CupertinoDynamicColor cardColor = CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemBackground,
      darkColor: CupertinoColors.black,
    );
    CupertinoDynamicColor textColor = CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.label,
      darkColor: CupertinoColors.white,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardSize,
        height: cardSize,
        decoration: BoxDecoration(
          color: cardColor.resolveFrom(context),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.0,
                color: CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.activeBlue,
                  darkColor: CupertinoColors.white,
                ).resolveFrom(context),
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: textColor.resolveFrom(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
