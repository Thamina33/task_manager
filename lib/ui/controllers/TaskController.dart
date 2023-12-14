
import 'dart:core';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/task_count_summary_list_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class TaskController extends GetxController
    implements GetxService {

  bool _getNewTaskInProgress = false;
  bool get getNewTaskInProgress => _getNewTaskInProgress;

  bool _getTaskCountSummaryInProgress = false;

  bool get getTaskCountSummaryInProgress => _getTaskCountSummaryInProgress;

  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;


  TaskCountSummaryListModel _taskCountSummaryListModel = TaskCountSummaryListModel();
  TaskCountSummaryListModel get taskCountSummaryListModel => _taskCountSummaryListModel;


  Future<void> getTaskCountSummaryList() async {
    _getTaskCountSummaryInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      _taskCountSummaryListModel = TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    _getTaskCountSummaryInProgress = false;
    update();
  }

  Future<void> getNewTaskList() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getNewTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getNewTaskInProgress = false;
    update();
  }

  updateGetNewTaskInProgressStatus(bool value){
    _getNewTaskInProgress = value ;
    update();
  }


    }