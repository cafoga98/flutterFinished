import 'package:flutter/material.dart';
import 'package:my_first_project/Models/model_newsApi.dart';
import 'package:my_first_project/Utils/Widget/item_list.dart';
import '../Utils/Persisters.dart' as globals;


class BuildItemList extends StatelessWidget {

  final Articles SnapshotData;

  BuildItemList({Key key, @required this.SnapshotData});

  @override
  Widget build(BuildContext context) {
    return ItemList(SnapshotData: SnapshotData);
  }
}
