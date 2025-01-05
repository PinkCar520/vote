import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'pages/home_page.dart';
import 'pages/game_page.dart';
import 'pages/daily_check_in_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // 当前主题模式（0: 自动, 1: 浅色, 2: 深色）
  int _selectedTheme = 0;

  @override
  void initState() {
    super.initState();
    _setSystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: _getThemeData(),
      home: VoteHomePage(onThemeChanged: _onThemeChanged),
    );
  }

  // 根据当前选择的主题模式返回不同的主题
  CupertinoThemeData _getThemeData() {
    return CupertinoThemeData(
      brightness: _getBrightness(),
      scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.systemBackground,
        darkColor: CupertinoColors.black,
      ),
      barBackgroundColor: CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.systemBackground,
        darkColor: CupertinoColors.black,
      ),
    );
  }

  Brightness _getBrightness() {
    switch (_selectedTheme) {
      case 1: // 浅色模式
        return Brightness.light;
      case 2: // 深色模式
        return Brightness.dark;
      default: // 自动模式
        return WidgetsBinding.instance.window.platformBrightness;
    }
  }

  void _setSystemUI() {
    Brightness brightness = _getBrightness();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: brightness == Brightness.dark ? CupertinoColors.black : CupertinoColors.white, // 设置状态栏背景色
      statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: brightness == Brightness.dark ? CupertinoColors.black : CupertinoColors.white,
      systemNavigationBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ));
  }

  // 更新主题
  void _onThemeChanged(int selectedTheme) {
    setState(() {
      _selectedTheme = selectedTheme;
      _setSystemUI();
    });
  }
}

class VoteHomePage extends StatefulWidget {
  final Function(int) onThemeChanged;

  VoteHomePage({required this.onThemeChanged});

  @override
  _VoteHomePageState createState() => _VoteHomePageState();
}

class _VoteHomePageState extends State<VoteHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    for (int i = 0; i < 4; i++) {
      // 为每个图标创建一个 AnimationController 和 Tween 动画
      AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 200),  // 设置动画时长
        vsync: this,  // 使用当前的State作为vsync
      );
      _controllers.add(controller);
      _animations.add(
        Tween<double>(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        ),
      );

      // 在动画结束时执行反向动画
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    // 释放所有的控制器
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.systemBackground,
          darkColor: CupertinoColors.black,
        ).resolveFrom(context),
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey.withOpacity(0.4),
            width: 0.5, // 设置顶部边框厚度
          ),
        ),
        items: List.generate(4, (index) {
          return BottomNavigationBarItem(
            icon: _buildAnimatedIcon(index),
          );
        }),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _playAnimation(index);  // 点击时播放动画
          });
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (context) {
            return _buildPage(index);
          },
        );
      },
    );
  }

  Widget _buildAnimatedIcon(int index) {
    bool isSelected = _selectedIndex == index;

    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _animations[index].value : 1.0,  // 根据动画值缩放
          child: Icon(
            _getIcon(index),
            color: isSelected
                ? CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.activeBlue,
              darkColor: CupertinoColors.white,
            ).resolveFrom(context)
                : CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.inactiveGray,
              darkColor: CupertinoColors.systemGrey2,
            ).resolveFrom(context),
          ),
        );
      },
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.home;
      case 1:
        return CupertinoIcons.gamecontroller;
      case 2:
        return CupertinoIcons.calendar;
      case 3:
        return CupertinoIcons.settings;
      default:
        return CupertinoIcons.home;
    }
  }

  Widget _buildPage(int index) {
    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_getTitle(index)),
          backgroundColor: CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.systemBackground,
            darkColor: CupertinoColors.black,
          ),
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.systemGrey.withOpacity(0.4),
              width: 0.5, // 设置边框厚度
            ),
          ),
        ),
        child: _getPage(index),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return '首页';
      case 1:
        return '游戏';
      case 2:
        return '每日打卡';
      case 3:
        return '设置';
      default:
        return '首页';
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return GamePage();
      case 2:
        return DailyCheckInPage();
      case 3:
        return SettingsPage(onThemeChanged: widget.onThemeChanged);
      default:
        return HomePage();
    }
  }

  // 播放动画的方法
  void _playAnimation(int index) {
    // 让动画从 1.0 缩放到 1.1
    _controllers[index].forward(from: 0.0);
  }
}
