/// id : 87730
/// vodName : "双面骗子虚假警察第一季"
/// vodCategoryId : 22
/// vodPic : "https://img.lzzyimg.com/upload/vod/20240427-1/8481ae6a5d78724e7d82f2143c04c01f.jpg"
/// vodLang : "日语"
/// vodArea : "日本"
/// vodActor : "向井理,内田理央,荒川良良,上川周作,伊藤淳史,结木滉星,桥本润,梶原善,松本若菜,胜村政信,小林隆,野村麻纯"
/// vodClass : "喜剧,悬疑"
/// vodBlurb : "　　在派出所工作的警官·多家良启介是在某商店街的派出所工作的认真可靠之人，但是多家良有着谁也不知道的过去和背后的面孔… 那就是专挑法律无法制裁的对象的“骗子K”！以前的多家良是搜查二课的刑警，负责追捕"
/// vodPubdate : "2024-04-25T16:00:00.000+00:00"
/// vodRemarks : "更新至第04集"
/// vodState : "正片"
/// vodTime : "2024-05-27T05:52:15.000+00:00"
/// vodYear : "2024"
/// vodPlayUrl : "第01集$https://v.cdnlz9.com/20240427/23671_1fd37b80/index.m3u8#第02集$https://v.cdnlz9.com/20240505/24097_5fb28fa2/index.m3u8#第03集$https://v.cdnlz9.com/20240513/24521_321c0dd8/index.m3u8#第04集$https://v.cdnlz22.com/20240527/240_eaf88803/index.m3u8"
/// vodLetter : "S"
/// vodDownUrl : "第01集$https://dow.dowlz6.com/20240427/23671_1fd37b80/双面骗子虚假警察第一季01.mp4#第02集$https://dow.dowlz6.com/20240505/24097_5fb28fa2/双面骗子虚假警察第一季02.mp4#第03集$https://dow.dowlz6.com/20240513/24521_321c0dd8/双面骗子虚假警察第一季03.mp4#第04集$https://dow.dowlz17.com/20240527/240_eaf88803/双面骗子虚假警察第一季.04.mp4"

class Vod {
  Vod({
      num? id, 
      String? vodName, 
      num? vodCategoryId, 
      String? vodPic, 
      String? vodLang, 
      String? vodArea, 
      String? vodActor, 
      String? vodClass, 
      String? vodBlurb, 
      String? vodPubdate, 
      String? vodRemarks, 
      String? vodState, 
      String? vodTime, 
      String? vodYear, 
      String? vodPlayUrl, 
      String? vodLetter, 
      String? vodDownUrl,}){
    _id = id;
    _vodName = vodName;
    _vodCategoryId = vodCategoryId;
    _vodPic = vodPic;
    _vodLang = vodLang;
    _vodArea = vodArea;
    _vodActor = vodActor;
    _vodClass = vodClass;
    _vodBlurb = vodBlurb;
    _vodPubdate = vodPubdate;
    _vodRemarks = vodRemarks;
    _vodState = vodState;
    _vodTime = vodTime;
    _vodYear = vodYear;
    _vodPlayUrl = vodPlayUrl;
    _vodLetter = vodLetter;
    _vodDownUrl = vodDownUrl;
}

  Vod.fromJson(dynamic json) {
    _id = json['id'];
    _vodName = json['vodName'];
    _vodCategoryId = json['vodCategoryId'];
    _vodPic = json['vodPic'];
    _vodLang = json['vodLang'];
    _vodArea = json['vodArea'];
    _vodActor = json['vodActor'];
    _vodClass = json['vodClass'];
    _vodBlurb = json['vodBlurb'];
    _vodPubdate = json['vodPubdate'];
    _vodRemarks = json['vodRemarks'];
    _vodState = json['vodState'];
    _vodTime = json['vodTime'];
    _vodYear = json['vodYear'];
    _vodPlayUrl = json['vodPlayUrl'];
    _vodLetter = json['vodLetter'];
    _vodDownUrl = json['vodDownUrl'];
  }
  num? _id;
  String? _vodName;
  num? _vodCategoryId;
  String? _vodPic;
  String? _vodLang;
  String? _vodArea;
  String? _vodActor;
  String? _vodClass;
  String? _vodBlurb;
  String? _vodPubdate;
  String? _vodRemarks;
  String? _vodState;
  String? _vodTime;
  String? _vodYear;
  String? _vodPlayUrl;
  String? _vodLetter;
  String? _vodDownUrl;
Vod copyWith({  num? id,
  String? vodName,
  num? vodCategoryId,
  String? vodPic,
  String? vodLang,
  String? vodArea,
  String? vodActor,
  String? vodClass,
  String? vodBlurb,
  String? vodPubdate,
  String? vodRemarks,
  String? vodState,
  String? vodTime,
  String? vodYear,
  String? vodPlayUrl,
  String? vodLetter,
  String? vodDownUrl,
}) => Vod(  id: id ?? _id,
  vodName: vodName ?? _vodName,
  vodCategoryId: vodCategoryId ?? _vodCategoryId,
  vodPic: vodPic ?? _vodPic,
  vodLang: vodLang ?? _vodLang,
  vodArea: vodArea ?? _vodArea,
  vodActor: vodActor ?? _vodActor,
  vodClass: vodClass ?? _vodClass,
  vodBlurb: vodBlurb ?? _vodBlurb,
  vodPubdate: vodPubdate ?? _vodPubdate,
  vodRemarks: vodRemarks ?? _vodRemarks,
  vodState: vodState ?? _vodState,
  vodTime: vodTime ?? _vodTime,
  vodYear: vodYear ?? _vodYear,
  vodPlayUrl: vodPlayUrl ?? _vodPlayUrl,
  vodLetter: vodLetter ?? _vodLetter,
  vodDownUrl: vodDownUrl ?? _vodDownUrl,
);
  num? get id => _id;
  String? get vodName => _vodName;
  num? get vodCategoryId => _vodCategoryId;
  String? get vodPic => _vodPic;
  String? get vodLang => _vodLang;
  String? get vodArea => _vodArea;
  String? get vodActor => _vodActor;
  String? get vodClass => _vodClass;
  String? get vodBlurb => _vodBlurb;
  String? get vodPubdate => _vodPubdate;
  String? get vodRemarks => _vodRemarks;
  String? get vodState => _vodState;
  String? get vodTime => _vodTime;
  String? get vodYear => _vodYear;
  String? get vodPlayUrl => _vodPlayUrl;
  String? get vodLetter => _vodLetter;
  String? get vodDownUrl => _vodDownUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['vodName'] = _vodName;
    map['vodCategoryId'] = _vodCategoryId;
    map['vodPic'] = _vodPic;
    map['vodLang'] = _vodLang;
    map['vodArea'] = _vodArea;
    map['vodActor'] = _vodActor;
    map['vodClass'] = _vodClass;
    map['vodBlurb'] = _vodBlurb;
    map['vodPubdate'] = _vodPubdate;
    map['vodRemarks'] = _vodRemarks;
    map['vodState'] = _vodState;
    map['vodTime'] = _vodTime;
    map['vodYear'] = _vodYear;
    map['vodPlayUrl'] = _vodPlayUrl;
    map['vodLetter'] = _vodLetter;
    map['vodDownUrl'] = _vodDownUrl;
    return map;
  }

}