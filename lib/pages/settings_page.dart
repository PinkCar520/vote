import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(int) onThemeChanged; // 回调函数，更新主题

  SettingsPage({required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedSegment = 0;  // 0: 自动, 1: 浅色, 2: 深色
  double _vocabularyAmount = 500.0; // 初始的词汇量

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          children: [
            _buildSectionTitle('同步'),
            _buildFunctionSetting(
              context,
              'iCloud同步',
              CupertinoIcons.cloud, // 图标
              _buildSwitchControl(),
            ),
            Divider(
              color: CupertinoColors.inactiveGray, // 设置 Divider 的颜色
              thickness: 0.1, // 设置 Divider 的厚度
              height: 10, // 设置 Divider 与上下组件的间距
            ),
            _buildSectionTitle('显示'),
            _buildFunctionSetting(
              context,
              '主题切换',
              CupertinoIcons.moon_stars, // 图标
              _buildThemeControl(),
            ),
            Divider(
              color: CupertinoColors.inactiveGray, // 设置 Divider 的颜色
              thickness: 0.1, // 设置 Divider 的厚度
              height: 10, // 设置 Divider 与上下组件的间距
            ),
            _buildSectionTitle('功能'),
            _buildFunctionSetting(
              context,
              '每日打卡',
              CupertinoIcons.check_mark_circled, // 图标
              CupertinoSwitch(value: true, onChanged: (bool value) {}),
            ),

            // 词汇量控制
            _buildFunctionSetting(
              context,
              '每日学习量',
              CupertinoIcons.number_circle, // 图标
              _buildVocabularyControl(),
            ),
            Divider(
              color: CupertinoColors.inactiveGray, // 设置 Divider 的颜色
              thickness: 0.1, // 设置 Divider 的厚度
              height: 10, // 设置 Divider 与上下组件的间距
            ),

            _buildSectionTitle('其他'),
            _buildFunctionSetting(
              context,
              '清理缓存',
              CupertinoIcons.trash, // 图标
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  '清理',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ),
            _buildFunctionSetting(
              context,
              '检查更新',
              CupertinoIcons.arrow_2_circlepath, // 图标
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  '检查',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ),
            _buildFunctionSetting(
              context,
              '反馈意见',
              CupertinoIcons.bubble_left, // 图标
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  '提交反馈',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ),
            Divider(
              color: CupertinoColors.inactiveGray, // 设置 Divider 的颜色
              thickness: 0.1, // 设置 Divider 的厚度
              height: 10, // 设置 Divider 与上下组件的间距
            ),

            _buildSectionTitle('关于Vote'),
            _buildFunctionSetting(
              context,
              '版本信息',
              CupertinoIcons.info, // 图标
              Text(
                'v1.0.0',
                style: TextStyle(color: CupertinoColors.inactiveGray),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.black,
        ),
      ),
    );
  }

  Widget _buildFunctionSetting(
      BuildContext context, String title, IconData icon, Widget child) {
    return CupertinoFormRow(
      prefix: Row(
        children: [
          Icon(
            icon,
            color: CupertinoColors.activeBlue, // 图标颜色
            size: 24.0,  // 图标大小
          ),
          SizedBox(width: 12), // 图标和文字之间的间距
          Text(title),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSwitchControl() {
    return SizedBox(
      width: 60.0,  // 设置开关的宽度
      height: 20.0, // 设置开关的高度
      child: CupertinoSwitch(
        value: true, // 状态
        onChanged: (bool value) {
          // 处理开关状态变化
        },
      ),
    );
  }

  // 使用 CupertinoSlidingSegmentedControl 来切换主题
  Widget _buildThemeControl() {
    return CupertinoSlidingSegmentedControl<int>(
      groupValue: _selectedSegment,
      onValueChanged: (int? value) {
        setState(() {
          _selectedSegment = value!;
        });
        widget.onThemeChanged(_selectedSegment); // 通知 MyApp 更新主题
      },
      children: {
        0: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text('自动', style: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 16.0, // 调整字体大小
            fontWeight: FontWeight.bold,  // 加粗字体
          )
          ),
        ),
        1: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text('浅色', style: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 16.0, // 调整字体大小
            fontWeight: FontWeight.bold,  // 加粗字体
          )
          ),
        ),
        2: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text('深色', style: TextStyle(
            color: CupertinoColors.activeBlue,
            fontSize: 16.0, // 调整字体大小
            fontWeight: FontWeight.bold,  // 加粗字体
          )
          ),
        ),
      },
    );
  }

  // 添加词汇量控制的弹出框
  Widget _buildVocabularyControl() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        double? selectedValue = await showCupertinoModalPopup<double>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: Text('选择词汇量'),
            message: Center( // 使用 Center 小部件使 Picker 垂直居中
              child: Container(
                height: 300,  // 设置足够的高度以显示 picker
                child: CupertinoPicker(
                  itemExtent: 32.0,  // 每个选项的高度
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      // 设置选择的词汇量
                      _vocabularyAmount = 10.0 * (index + 1);
                    });
                  },
                  children: List.generate(100, (index) => Text('${(index + 1) * 10}')),
                ),
              ),
            ),
            cancelButton: CupertinoActionSheetAction(
              child: Text('取消'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        );
      },
      child: Text('选择词汇量: ${_vocabularyAmount.toStringAsFixed(0)}'),
    );
  }
}
