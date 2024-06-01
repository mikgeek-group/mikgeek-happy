import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:happyapp/models/category_model.dart';
import 'package:happyapp/models/source_model.dart';
import 'package:happyapp/models/video_model.dart';
import 'package:happyapp/pages/main_left_page.dart';
import 'package:happyapp/provider/source.dart';
import 'package:happyapp/utils/application.dart';
import 'package:happyapp/utils/http_util.dart';
import 'package:happyapp/widgets/animated_floating_action_button.dart';
import 'package:happyapp/widgets/no_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  // 滚动控制器
  late TabController _navController;
  List<CategoryModel> _categoryList = [];
  String? _type = '';
  bool _isLandscape = false; // 是否横屏

  late EasyRefreshController _controller;
  int _pageNum = 1;
  List<VideoModel> _videoList = [];
  SourceModel? _currentSource;
  late SourceProvider _sourceProvider;
  final GlobalKey<AnimatedFloatingActionButtonState> _buttonKey =
      GlobalKey<AnimatedFloatingActionButtonState>();
  bool _firstLoading = false;

  ScrollController _scrollController = new ScrollController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _navController = TabController(length: _categoryList.length, vsync: this);
    _controller = EasyRefreshController();

    _scrollController.addListener(() {
      var position = _scrollController.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50 && !_isLoading) {
        _isLoading = true;
        _pageNum++;
        _getVideoList();
      }
    });
    // 资源变化监听
    _sourceProvider = context.read<SourceProvider>();
    _currentSource = _sourceProvider.currentSource;
    _sourceProvider.addListener(() {
      if (!mounted) return;

      setState(() {
        _videoList = [];
        _currentSource = _sourceProvider.currentSource;
      });

      _initData();
    });

    _initData();
  }

  /// 获取分类
  Future<void> _getCategoryList() async {
    if (!mounted) return;
    // 初始化一些数据
    _navController.dispose();
    setState(() {
      _type = '';
      _categoryList = [];
      _navController = TabController(length: _categoryList.length, vsync: this);
    });
    final List<CategoryModel> list = await HttpUtil().getCategoryList();
    if (list.isNotEmpty) {
      setState(() {
        _categoryList = [CategoryModel(id: '', name: '最新')] + list;
        _navController =
            TabController(length: _categoryList.length, vsync: this);
      });
    }
  }

  /// 获取视频列表
  Future<void> _getVideoList() async {
    int? hour; // 最近几个小时更新
    if (_type == null || _type!.isEmpty) {
      hour = 24 * 7;
    }

    print("type:" + _type.toString());

    final List<VideoModel> list = await HttpUtil()
        .getVideoList(pageNum: _pageNum, type: _type, hour: hour);

    print("长度：");
    print(list.length);
    setState(() {
      if (_pageNum <= 1) {
        _videoList = list;
      } else {
        _videoList += list;
      }
    });
    if (_controller.controlFinishLoad) {
      _controller.finishLoad(
          list.length < 20 ? IndicatorResult.noMore : IndicatorResult.success);
    }

    _isLoading = false;
  }

  Future<void> _initData() async {
    setState(() {
      _firstLoading = true;
      _pageNum = 1;
    });
    try {
      await _getCategoryList();
      await _getVideoList();
    } catch (err) {
      // rethrow;
    }
    setState(() {
      _firstLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext ctx) {
          return IconButton(
              icon: Container(
                width: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/image/avatar.png'),
                  ),
                ),
              ),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              });
        }),
        centerTitle: true,
        title: Text(
            _currentSource != null ? 'HappyGo' : '没找到视频源'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_currentSource == null) return;
              Navigator.of(context).pushNamed(Application.searchPage,
                  arguments: {'hintText': '搜索资源'});
            },
          )
        ],
        bottom: _buildCategoryNav(),
      ),
      body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if (notification.dragDetails != null &&
                _buttonKey.currentState != null) {
              if (notification.dragDetails!.delta.dy < 0 &&
                  _buttonKey.currentState!.isShow) {
                _buttonKey.currentState!.hide();
              } else if (notification.dragDetails!.delta.dy > 0 &&
                  !_buttonKey.currentState!.isShow) {
                _buttonKey.currentState!.show();
              }
            }
            return false;
          },
          child: _buildBody()),
      // floatingActionButton: AnimatedFloatingActionButton(
      //   key: _buttonKey,
      //   onPress: () {
      //     Navigator.of(context).pushNamed(Application.sourceManagePage);
      //   },
      // ),
      drawer: const Drawer(
        child: MainLeftPage(),
      ),
    );
  }

  // Widget _buildBody(){
  //   return EasyRefresh(
  //       controller: _controller,
  //       child: _firstLoading ? const Center(
  //           child: CircularProgressIndicator()
  //       ) : _videoList.isEmpty ? const NoData(tip: '没有视频数据~') : (
  //           _isLandscape ? ListView.builder(
  //               padding: const EdgeInsets.all(4),
  //               itemCount: _videoList.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return _buildVideoItem(_videoList[index], true);
  //               }
  //           ) : MasonryGridView.count(
  //             padding: const EdgeInsets.all(4),
  //             crossAxisCount: 2,
  //             mainAxisSpacing: 4,
  //             crossAxisSpacing: 4,
  //             itemCount: _videoList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return _buildVideoItem(_videoList[index], false);
  //             },
  //           )
  //       ),
  //       onRefresh: () async {
  //         _pageNum = 1;
  //         await _getVideoList();
  //       },
  //       onLoad: () async {
  //         _pageNum++;
  //         await _getVideoList();
  //       }
  //   );
  // }

  Widget _buildBody() {
    return RefreshIndicator(
        color: Colors.deepOrangeAccent,
        backgroundColor: Colors.white,
        child: _firstLoading
            ? const Center(child: CircularProgressIndicator())
            : _videoList.isEmpty
                ? const NoData(tip: '没有视频数据~')
                : (_isLandscape
                    ? ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(4),
                        itemCount: _videoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildVideoItem(_videoList[index], true);
                        })
                    : MasonryGridView.count(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(4),
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemCount: _videoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildVideoItem(_videoList[index], false);
                        },
                      )),
        onRefresh: _onRefresh);
  }

  Future<void> _onRefresh() async {
    print("RefreshListPage _onRefresh()");
    _pageNum = 1;
    await _getVideoList();
  }

  PreferredSize _buildCategoryNav() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Row(
        children: <Widget>[
          Expanded(
              child: _categoryList.isNotEmpty
                  ? TabBar(
                      controller: _navController,
                      isScrollable: true,
                      tabs: _categoryList
                          .map((e) => Tab(
                                text: e.name,
                              ))
                          .toList(),
                      onTap: (index) {
                        _type = _categoryList[index].id;
                        _pageNum = 1;
                        _getVideoList();
                      },
                    )
                  : Container()),
          Container(
            height: 20,
            margin: const EdgeInsets.only(left: 4),
            child: VerticalDivider(
              color: Colors.grey[200],
            ),
          ),
          Container(
              width: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                icon: Icon(_isLandscape ? Icons.list : Icons.table_chart),
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isLandscape = !_isLandscape;
                  });
                },
              ))
        ],
      ),
    );
  }

  Widget _buildVideoItem(VideoModel video, bool isLandscape) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Application.videoDetailPage, arguments: {
          'videoId': video.id,
        });
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                if (isLandscape)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: video.pic ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        'assets/image/placeholder-l.jpg',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, dynamic error) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/image/placeholder-l.jpg'),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '图片加载失败',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  )
                else
                  CachedNetworkImage(
                    imageUrl: video.pic ?? '',
                    placeholder: (context, url) => AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Image.asset(
                        'assets/image/placeholder-p.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    errorWidget: (context, url, dynamic error) => AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/image/placeholder-p.jpg'),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '图片加载失败',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                if (video.note != null && video.note!.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(125),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        video.note!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                video.name ?? '',
                style: const TextStyle(fontSize: 15),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
