import 'package:happyapp/models/category_model.dart';
import 'package:happyapp/models/video_model.dart';
import 'package:xml/xml.dart';

mixin XmlUtil {
  static List<CategoryModel> parseCategoryList(String xmlStr) {
    final List<CategoryModel> list = [];

    final document = XmlDocument.parse(xmlStr);
    final types = document.findAllElements('ty');
    for (final XmlElement node in types) {
      list.add(CategoryModel(id: node.getAttribute('id'), name: node.text));
    }

    return list;
  }

  static List<VideoModel> parseVideoList(String xmlStr) {
    final List<VideoModel> list = [];

    final document = XmlDocument.parse(xmlStr);
    final videos = document.findAllElements('video');
    for (final XmlElement node in videos) {
      list.add(VideoModel(
        id: getNodeText(node, 'id'),
        tid: getNodeText(node, 'tid'),
        name: getNodeCData(node, 'name'),
        type: getNodeText(node, 'type'),
        pic: getNodeText(node, 'pic') ?? '',
        lang: getNodeText(node, 'lang'),
        area: getNodeText(node, 'area'),
        year: getNodeText(node, 'year'),
        last: getNodeText(node, 'last'),
        state: getNodeText(node, 'state'),
        note: getNodeCData(node, 'note'),
        actor: getNodeCData(node, 'actor'),
        director: getNodeCData(node, 'director'),
        des: getNodeCData(node, 'des'),
      ),);
    }

    return list;
  }

  static VideoModel? parseVideo(String xmlStr) {
    final document = XmlDocument.parse(xmlStr);
    final videos = document.findAllElements('video');
    if (videos.isEmpty) return null;
    final video = videos.first;
    // 视频源处理
    final dl = video.findElements('dl').isEmpty ? null : video.findElements('dl').first;
    if (dl == null) return null;
    final List<Anthology> anthologies = [];
    for (final dd in dl.children) {
      if (dd.children.isEmpty) break;
      final String str = dd.children.first.text;
      String? tag;
      if (dd.attributes.isNotEmpty) {
        tag = dd.attributes.first.value;
      }
      if (str.isNotEmpty) {
        str.split('#').forEach((s) {
          if (s.isNotEmpty) {
            if (s.contains('\$')) {
              anthologies.add(Anthology(
                tag: tag,
                name: s.split('\$')[0],
                url: s.split('\$')[1])
              );
            } else {
              anthologies.add(Anthology(
                tag: tag,
                url: s
              ));
            }
          }
        });
      }
    }
    return VideoModel(
      id: getNodeText(video, 'id'),
      tid: getNodeText(video, 'tid'),
      name: getNodeCData(video, 'name'),
      type: getNodeText(video, 'type'),
      pic: getNodeText(video, 'pic'),
      lang: getNodeText(video, 'lang'),
      area: getNodeText(video, 'area'),
      year: getNodeText(video, 'year'),
      last: getNodeText(video, 'last'),
      state: getNodeText(video, 'state'),
      note: getNodeCData(video, 'note'),
      actor: getNodeCData(video, 'actor'),
      director: getNodeCData(video, 'director'),
      des: getNodeCData(video, 'des'),
      anthologies: anthologies,
    );
  }

  static String? getNodeText(XmlElement node, String name) {
    final elements = node.findElements(name);
    if (elements.isEmpty) return null;
    return elements.first.text;
  }

  static String? getNodeCData(XmlElement node, String name) {
    final elements = node.findElements(name);
    if (elements.isEmpty ) return null;
    final children = node.findElements(name).first.children;
    if (children.isEmpty) return null;
    return children.first.text;
  }
}
