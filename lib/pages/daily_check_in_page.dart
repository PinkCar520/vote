import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyCheckInPage extends StatelessWidget {
  final String currentDate = '2024-12-09'; // 当前日期
  final bool isCheckedIn = false;
  final int winStreak = 5; // 连胜天数
  final int checkInDays = 12; // 打卡天数
  final double progress = 0.75; // 进度值
  final String difficulty = '中等'; // 难度等级

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWinStreakWithProgressCard(),  // 更新后的连胜与进度条卡片
              SizedBox(height: 16.0),
              _buildStatsCard(),  // 打卡天数与连胜天数卡片
              SizedBox(height: 16.0),
              _buildLearningProgressCard(),
              SizedBox(height: 16.0),
              _buildLearningTips(),
            ],
          ),
        ),
      ),
    );
  }

  // 更新后的连胜天数和进度条卡片
  Widget _buildWinStreakWithProgressCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white, // 卡片背景颜色
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: CupertinoColors.lightBackgroundGray, width: 3),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 上半部分：显示连胜天数
          Row(
            children: [
              Icon(
                CupertinoIcons.flame, // 星形图标代表成就
                color: Colors.deepOrange,
              ),
              SizedBox(width: 8.0),
              Text(
                '$winStreak 天连胜',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // 下半部分：显示进度条
          Container(
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: CupertinoColors.lightBackgroundGray, // 浅灰色背景
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10.0,
              borderRadius: BorderRadius.circular(10.0),  // 圆角设置
              backgroundColor: CupertinoColors.lightBackgroundGray,
              valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor()),
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  // 获取进度条的颜色渐变
  Color _getProgressColor() {
    if (progress >= 0.8) {
      return Colors.green;
    } else if (progress >= 0.5) {
      return Color(0xFFFF6900);
    } else {
      return Colors.red;
    }
  }

  // 打卡天数与连胜天数卡片
  Widget _buildStatsCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 打卡天数与连胜天数的卡片内容
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: CupertinoColors.white, // 卡片背景颜色
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: CupertinoColors.lightBackgroundGray, width: 3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '$winStreak',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('连胜天数', style: TextStyle(fontSize: 14.0, color: Colors.black54)),
                ],
              ),
              Container(
                width: 1.0,
                height: 50.0,
                color: Colors.black12,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              Column(
                children: [
                  Text(
                    '$checkInDays',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('打卡天数', style: TextStyle(fontSize: 14.0, color: Colors.black54)),
                ],
              ),
            ],
          ),
        ),
        // 难度等级悬浮小卡片
        Positioned(
          top: -10,  // 上移，靠近卡片的右上角
          right: 0, // 向右移动，避免卡片覆盖
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFFF6900),  // 悬浮卡片的背景颜色
              borderRadius: BorderRadius.circular(5.0),  // 圆角
            ),
            child: Text(
              difficulty,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 今日学习进度卡片
  Widget _buildLearningProgressCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white, // 卡片背景颜色
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: CupertinoColors.lightBackgroundGray, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '今日学习进度',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 16.0),
          // 环形进度圈
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 8.0,
            backgroundColor: CupertinoColors.lightBackgroundGray,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6900)),
          ),
          SizedBox(height: 16.0),
          // 进度百分比与日期
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    progress >= 0.5
                        ? CupertinoIcons.check_mark
                        : CupertinoIcons.clear_thick,
                    color: progress >= 0.5
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.systemRed,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Text(
                currentDate,
                style: TextStyle(
                  fontSize: 14.0,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 学习建议
  Widget _buildLearningTips() {
    String tips;
    if (progress >= 0.8) {
      tips = '今天学习非常棒，继续保持！';
    } else if (progress >= 0.5) {
      tips = '可以做得更好，继续努力！';
    } else {
      tips = '加油，今天还可以更进步！';
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white, // 卡片背景颜色
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: CupertinoColors.lightBackgroundGray, width: 3),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        tips,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
