import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:happyapp/common/constant.dart';
import 'package:happyapp/models/download_model.dart';
import 'package:happyapp/models/record_model.dart';
import 'package:happyapp/models/source_model.dart';

class DBHelper {
  factory DBHelper() => _instance;
  DBHelper._internal() {
    initDb();
  }
  static final DBHelper _instance = DBHelper._internal();
  Database? _db;

  /* 公用列 */
  final String _columnId = 'id';
  final String _columnName = 'name';
  final String _columnUrl = 'url';
  final String _columnType = 'type';

  /* 视频资源表 */
  final String _sourceTableName = 'table_source';
  final String _columnHttpApi = 'httpApi';
  final String _columnCreateAt = 'createAt';
  final String _columnUpdateAt = 'updateAt';

  /* 下载视频表 */
  final String _downloadTableName = 'table_download_video';
  final String _columnApi = 'api';
  final String _columnVid = 'vid';
  final String _columnTid = 'tid';
  final String _columnPic = 'pic';
  final String _columnFileId = 'fileId';
  final String _columnStatus = 'status';
  final String _columnProgress = 'progress';
  final String _columnSavePath = 'savePath';

  /* 记录表 */
  final String _recordTableName = 'table_record';
  final String _columnCollected = 'collected';
  final String _columnAnthologyName = 'anthologyName';
  final String _columnPlayedTime = 'playedTime';

  List<String> _allSourceColumn = [];
  List<String> _allDownloadColumn = [];
  List<String> _allRecordColumn = [];

  Future<void> initDb() async {
    _allDownloadColumn = [_columnId, _columnApi, _columnVid, _columnTid, _columnType, _columnName, _columnPic, _columnUrl, _columnFileId, _columnStatus, _columnProgress, _columnSavePath];
    _allSourceColumn = [_columnId, _columnName, _columnUrl, _columnType, _columnHttpApi];
    _allRecordColumn = [_columnId, _columnApi, _columnVid, _columnTid, _columnType, _columnName, _columnPic, _columnCollected, _columnProgress, _columnAnthologyName, _columnPlayedTime, _columnCreateAt, _columnUpdateAt];

    final String databasesPath  = await getDatabasesPath();
    final String path = p.join(databasesPath, Constant.keyDBName);
    _db = await openDatabase(path, version: 2, onCreate: (Database db, int version) async {
      // 创建资源表
      await db.execute('''
        create table $_sourceTableName (
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnType VARCHAR (64),
          $_columnName TEXT not null,
          $_columnUrl TEXT not null,
          $_columnHttpApi TEXT not null
        )
      ''',);
      // 创建下载表
      await db.execute('''
        create table $_downloadTableName (
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnApi VARCHAR (64) not null, 
          $_columnVid VARCHAR (32) not null, 
          $_columnTid VARCHAR (32),
          $_columnType VARCHAR (64),
          $_columnName TEXT,
          $_columnPic TEXT not null,
          $_columnUrl TEXT not null,
          $_columnFileId TEXT,
          $_columnStatus	INTEGER NOT NULL DEFAULT 0,
	        $_columnProgress	REAl NOT NULL DEFAULT 0,
          $_columnCollected INTEGER NOT NULL DEFAULT 0,
          $_columnSavePath TEXT
        )
      ''',);
      // 创建记录表
      await db.execute('''
        create table $_recordTableName (
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnApi VARCHAR (64) not null, 
          $_columnVid VARCHAR (32) not null, 
          $_columnTid VARCHAR (32),
          $_columnType VARCHAR (64),
          $_columnName TEXT,
          $_columnPic TEXT not null,
          $_columnCollected INTEGER NOT NULL DEFAULT 0,
	        $_columnProgress	REAl NOT NULL DEFAULT 0,
          $_columnAnthologyName TEXT,
          $_columnPlayedTime INTEGER NOT NULL DEFAULT 0,
          $_columnCreateAt INTEGER NOT NULL,
          $_columnUpdateAt INTEGER NOT NULL
        )
      ''',);
    },);
  }

  /**
   * 资源相关数据库操作
   */
  /// 插入资源
  Future<int> insertSource(SourceModel model) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    // 去掉自带的ID，让数据库自增
    model.id = null;
    return _db!.insert(_sourceTableName, model.toJson());
  }
  /// 批量 插入资源
  Future<int> insertBatchSource(List<SourceModel> list) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final batch = _db!.batch();
    for (final SourceModel model in list) {
      // 去掉自带的ID，让数据库自增
      model.id = null;
      batch.insert(_sourceTableName, model.toJson());
    }
    final result = await batch.commit();
    return result.length;
  }
  /// 根据ID删除资源
  Future<int> deleteSourceById(int id) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.delete(
      _sourceTableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
  /// 根据ID修改资源
  Future<int> updateSourceById(SourceModel model) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    if (model.id == null) return 0;

    return _db!.update(
      _sourceTableName,
      model.toJson(),
      where: '$_columnId = ?',
      whereArgs: [model.id],
    );
  }
  /// 根据ID获取资源
  Future<SourceModel?> getSourceById(int id) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<Map<String, Object?>> maps = await _db!.query(
      _sourceTableName,
      columns: _allSourceColumn,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SourceModel.fromJson(maps.first);
    }
    return null;
  }
  /// 根据条件获取资源列表
  Future<List<SourceModel>> getSourceList({ String? type, String? name }) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<String> whereStr = [];
    final List<Object> whereArgs = [];

    if (type != null) {
      whereStr.add('$_columnType = ?');
      whereArgs.add(type);
    }
    if (name != null) {
      whereStr.add('$_columnName like %?%');
      whereArgs.add(name);
    }
    whereArgs.add('status != ${DownloadStatus.none.index}');

    List<Map<String, Object?>> maps;
    if (whereStr.isEmpty) {
      maps = await _db!.query(_sourceTableName,
        columns: _allSourceColumn,
        orderBy: '$_columnId ASC',
      );
    } else {
      maps = await _db!.query(_sourceTableName,
        columns: _allSourceColumn,
        where: whereStr.join(" AND "),
        whereArgs: whereArgs,
        orderBy: '$_columnId ASC',
      );
    }
    if (maps.isNotEmpty) {
      return maps.map((json) => SourceModel.fromJson(json)).toList();
    }
    return [];
  }

  /**
   * 下载相关数据库操作
   */
  /// 插入下载
  Future<int> insertDownload(DownloadModel model) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.insert(_downloadTableName, model.toJson());
  }
  /// 根据ID删除下载
  Future<int> deleteDownloadById(int id) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.delete(
      _downloadTableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
  /// 根据ID集删除下载
  Future<int> deleteDownloadByIds(List<int> ids) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.delete(
      _downloadTableName,
      where: '$_columnId in (${ids.join(',')})',
      whereArgs: [],
    );
  }
  /// 根据ID修改下载
  Future<int> updateDownloadById(DownloadModel model) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }

    return _db!.update(
      _downloadTableName,
      model.toJson(),
      where: '$_columnId = ?',
      whereArgs: [model.id],
    );
  }
  /// 根据URL修改下载进度
  Future<int> updateDownloadByUrl(String url, { double? progress, DownloadStatus? status, String? savePath }) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final Map<String, Object> maps = {};
    if (progress != null) {
      maps[_columnProgress] = progress;
    }
    if (status != null) {
      maps[_columnStatus] = status.index;
    }
    if (savePath != null) {
      maps[_columnSavePath] = savePath;
    }

    return _db!.update(
      _downloadTableName,
      maps,
      where: '$_columnUrl = ?',
      whereArgs: [url],
    );
  }
  /// 根据ID获取下载
  Future<DownloadModel?> getDownloadById(int id) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<Map<String, Object?>> maps = await _db!.query(
      _downloadTableName,
      columns: _allDownloadColumn,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DownloadModel.fromJson(maps.first);
    }
    return null;
  }
  /// 根据视频URl获取下载
  Future<DownloadModel?> getDownloadByUrl(String url) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<Map<String, Object?>> maps = await _db!.query(_downloadTableName,
        columns: _allDownloadColumn,
        where: '$_columnUrl = ?',
        whereArgs: [url],);

    if (maps.isNotEmpty) {
      return DownloadModel.fromJson(maps.first);
    }
    return null;
  }
  /// 根据条件获取下载列表
  Future<List<DownloadModel>> getDownloadList({
    int pageNum = 0,
    int pageSize = 20,
    DownloadStatus? status,
    String? url,
    String? savePath,
    String? name,
  }) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<String> whereStr = [];
    final List<Object> whereArgs = [];

    if (url != null) {
      whereStr.add('$_columnUrl = ?');
      whereArgs.add(url);
    }
    if (savePath != null) {
      whereStr.add('$_columnSavePath = ?');
      whereArgs.add(savePath);
    }
    if (status != null) {
      whereStr.add('$_columnStatus = ?');
      whereArgs.add(status.index);
    }
    if (name != null) {
      whereStr.add('$_columnName like %?%');
      whereArgs.add(name);
    }

    List<Map<String, Object?>> maps;
    if (whereStr.isEmpty) {
      maps = await _db!.query(_downloadTableName,
        columns: _allDownloadColumn,
        orderBy: '$_columnId DESC',
        limit: pageSize,
        offset: pageNum * pageSize,);
    } else {
      maps = await _db!.query(_downloadTableName,
        columns: _allDownloadColumn,
        where: whereStr.join(" AND "),
        whereArgs: whereArgs,
        orderBy: '$_columnId DESC',
        limit: pageSize,
        offset: pageNum * pageSize,);
    }
    if (maps.isNotEmpty) {
      return maps.map((json) => DownloadModel.fromJson(json)).toList();
    }
    return [];
  }

  /**
   * 记录表相关操作
   */
  /// 插入记录
  Future<int> insertRecord(RecordModel model) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    // 去掉自带的ID，让数据库自增
    model.id = null;
    model.createAt = DateTime.now().millisecondsSinceEpoch;
    model.updateAt = DateTime.now().millisecondsSinceEpoch;
    return _db!.insert(_recordTableName, model.toJson());
  }
  /// 根据ID删除记录
  Future<int> deleteRecordById(int id) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.delete(
      _recordTableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
  /// 根据指定时间以前的没有被收藏的记录
  Future<int> deleteAgoRecord(int agoTime) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    return _db!.delete(
      _recordTableName,
      where: '$_columnCollected = 0 AND $_columnUpdateAt < ?',
      whereArgs: [agoTime],
    );
  }
  /// 根据ID修改记录
  Future<int> updateRecord(int id, {
    int? collected,
    String? anthologyName,
    double? progress,
    int? playedTime,
  }) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }

    final Map<String, Object> maps = {
      // 重置修改时间
      'updateAt': DateTime.now().millisecondsSinceEpoch
    };
    if (collected != null) {
      maps[_columnCollected] = collected;
    }
    if (anthologyName != null) {
      maps[_columnAnthologyName] = anthologyName;
    }
    if (progress != null) {
      maps[_columnProgress] = progress;
    }
    if (playedTime != null) {
      maps[_columnPlayedTime] = playedTime;
    }
    return _db!.update(
      _recordTableName, maps,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
  /// 根据api和视频ID获取记录
  Future<RecordModel?> getRecordByVid(String httpApi, String vid) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }
    final List<Map<String, Object?>> maps = await _db!.query(
      _recordTableName,
      columns: _allRecordColumn,
      where: '$_columnApi = ? AND $_columnVid = ?',
      whereArgs: [httpApi, vid],
    );

    if (maps.isNotEmpty) {
      return RecordModel.fromJson(maps.first);
    }
    return null;
  }
  /// 获取记录列表
  Future<List<RecordModel>> getRecordList({int pageNum = 0, int pageSize = 20, int? collected, bool played = false }) async {
    if (_db == null || !_db!.isOpen) {
      await _instance.initDb();
    }

    final List<String> whereStr = [];
    final List<Object> whereArgs = [];

    if (collected != null) {
      whereStr.add('$_columnCollected = ?');
      whereArgs.add(collected);
    }
    if (played) {
      whereStr.add('$_columnProgress > 0');
    }

    List<Map<String, Object?>> maps;
    if (whereStr.isEmpty) {
      maps = await _db!.query(_recordTableName,
          columns: _allRecordColumn,
          orderBy: '$_columnUpdateAt DESC',
          limit: pageSize,
          offset: pageNum * pageSize,);
    } else {
      maps = await _db!.query(_recordTableName,
          columns: _allRecordColumn,
          where: whereStr.join(" AND "),
          whereArgs: whereArgs,
          orderBy: '$_columnUpdateAt DESC',
          limit: pageSize,
          offset: pageNum * pageSize,);
    }
    if (maps.isNotEmpty) {
      return maps.map((json) => RecordModel.fromJson(json)).toList();
    }
    return [];
  }

  /// 关闭数据库
  Future close() async {
    if (_db != null && _db!.isOpen) {
      await _db!.close();
    }
  }
}
