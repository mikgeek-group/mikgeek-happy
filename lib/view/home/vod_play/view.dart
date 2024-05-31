import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/api/vod.dart';
import 'package:happyapp/components/video_play.dart';
import 'package:happyapp/model/Vod.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';

class VodPlayPage extends StatefulWidget {
  const VodPlayPage({Key? key}) : super(key: key);

  @override
  State<VodPlayPage> createState() => _VodPlayPageState();
}

class _VodPlayPageState extends State<VodPlayPage> {
  final controller = Get.find<VodPlayController>();
  final state = Get
      .find<VodPlayController>()
      .state;

  late Vod vod;
  late List playList = [];

  late String playUrl = "";
  late bool init = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () => _loadData());
  }

  _loadData() async {
    var id = Get.arguments['id'];

    vod = await VodApi.getById(id);

    List<String>? urls = vod.vodPlayUrl?.split("#");

    var map = <Map<String, String>>[];
    urls?.forEach((element) {
      Map<String, String> item = {};
      var videoUrl = element.split("\$");
      item['name'] = videoUrl[0];
      item['url'] = videoUrl[1];
      map.add(item);
    });
    playList = map;

    playUrl = playList[0]['url'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("11"),
        ),
        body: Column(
          children: [
            playList.length > 0
                ? VideoPlayerWidget(videoUrl: playUrl)
                : Container(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: playList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(playList[index]['name']),
                    onTap: () {
                      print(index);
                      playUrl  = playList[index]['url'];
                      print(playUrl);
                      setState(() {});
                    },
                  );
                },
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    Get.delete<VodPlayController>();
    super.dispose();
  }
}
