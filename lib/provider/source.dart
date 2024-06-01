import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:happyapp/common/constant.dart';
import 'package:happyapp/models/source_model.dart';
import 'package:happyapp/provider/category.dart';
import 'package:happyapp/utils/sp_helper.dart';

class SourceProvider with ChangeNotifier {

  SourceModel? _currentSource;

  SourceModel? get currentSource => _currentSource;

  void setCurrentSource(SourceModel model, BuildContext context) {
    _currentSource = model;
    SpHelper.putObject(Constant.keyCurrentSource, model);

    context.read<CategoryProvider>().setCategoryIndex(0);
    context.read<CategoryProvider>().getCategoryList();
    notifyListeners();
  }
}
