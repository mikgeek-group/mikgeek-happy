/// id : "1"
/// parentId : "0"
/// weight : 0
/// name : "电影片"
/// children : [{"id":"45","parentId":"1","weight":0,"name":"预告片"},{"id":"10","parentId":"1","weight":0,"name":"恐怖片"},{"id":"11","parentId":"1","weight":0,"name":"剧情片"},{"id":"12","parentId":"1","weight":0,"name":"战争片"},{"id":"34","parentId":"1","weight":0,"name":"伦理片"},{"id":"6","parentId":"1","weight":0,"name":"动作片"},{"id":"7","parentId":"1","weight":0,"name":"喜剧片"},{"id":"8","parentId":"1","weight":0,"name":"爱情片"},{"id":"9","parentId":"1","weight":0,"name":"科幻片"},{"id":"20","parentId":"1","weight":0,"name":"记录片"}]

class VodCategory {
  VodCategory({
      String? id, 
      String? parentId, 
      num? weight, 
      String? name, 
      List<Children>? children,}){
    _id = id;
    _parentId = parentId;
    _weight = weight;
    _name = name;
    _children = children;
}

  VodCategory.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parentId'];
    _weight = json['weight'];
    _name = json['name'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(Children.fromJson(v));
      });
    }
  }
  String? _id;
  String? _parentId;
  num? _weight;
  String? _name;
  List<Children>? _children;
VodCategory copyWith({  String? id,
  String? parentId,
  num? weight,
  String? name,
  List<Children>? children,
}) => VodCategory(  id: id ?? _id,
  parentId: parentId ?? _parentId,
  weight: weight ?? _weight,
  name: name ?? _name,
  children: children ?? _children,
);
  String? get id => _id;
  String? get parentId => _parentId;
  num? get weight => _weight;
  String? get name => _name;
  List<Children>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parentId'] = _parentId;
    map['weight'] = _weight;
    map['name'] = _name;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "45"
/// parentId : "1"
/// weight : 0
/// name : "预告片"

class Children {
  Children({
      String? id, 
      String? parentId, 
      num? weight, 
      String? name,}){
    _id = id;
    _parentId = parentId;
    _weight = weight;
    _name = name;
}

  Children.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parentId'];
    _weight = json['weight'];
    _name = json['name'];
  }
  String? _id;
  String? _parentId;
  num? _weight;
  String? _name;
Children copyWith({  String? id,
  String? parentId,
  num? weight,
  String? name,
}) => Children(  id: id ?? _id,
  parentId: parentId ?? _parentId,
  weight: weight ?? _weight,
  name: name ?? _name,
);
  String? get id => _id;
  String? get parentId => _parentId;
  num? get weight => _weight;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parentId'] = _parentId;
    map['weight'] = _weight;
    map['name'] = _name;
    return map;
  }

}