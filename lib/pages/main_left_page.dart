import 'package:flutter/material.dart';
import 'package:happyapp/utils/application.dart';

class MainLeftPage extends StatefulWidget {
  const MainLeftPage({Key? key}) : super(key: key);

  @override
  State<MainLeftPage> createState() => _MainLeftPageState();
}

class _MainLeftPageState extends State<MainLeftPage> {

  final List<_ListItemInfo> _items = <_ListItemInfo>[
    // _ListItemInfo(title: '下载记录', icon: Icons.file_download, route: Application.downloadPage),
    _ListItemInfo(title: '收藏', icon: Icons.star, route: Application.collectionPage),
    _ListItemInfo(title: '播放记录', icon: Icons.access_time, route: Application.playRecordPage),
    _ListItemInfo(title: '设置', icon: Icons.settings, route: Application.settingPage),
    // _ListItemInfo(title: '关于', icon: Icons.info),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: const CircleAvatar(
            backgroundImage: AssetImage('assets/image/avatar.png'),
          ),
          accountName: const Text('贾玉婷特供版', style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: const Text('核心思想：开心快乐~',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                final _ListItemInfo item = _items[index];
                return ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.title ?? ''),
                    onTap: () {
                      if (item.route != null) {
                        Navigator.of(context).pop();  // 先关闭Drawer
                        Navigator.of(context).pushNamed(item.route!);
                      }
                    }
                );
              },
            ),
          )
        ),
      ],
    );
  }
}

class _ListItemInfo {
  _ListItemInfo({
    this.title,
    this.icon,
    this.route
  });

  final String? title;
  final IconData? icon;
  final String? route;
}
