import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/TaskController.dart';
import '../../data/models/task_count.dart';
import '../../data/models/task_count_summary_list_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widget/profile_summary_card.dart';
import '../widget/summary_card.dart';
import '../widget/task_item_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_)  {

    Get.find<TaskController>().getNewTaskList();
      Get.find<TaskController>().getTaskCountSummaryList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskController) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final response = await Get.to(
              const AddNewTaskScreen(),
            );

            if (response != null && response == true) {
              taskController.getNewTaskList();
              taskController.getTaskCountSummaryList();
            }
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Visibility(
                visible: taskController.getTaskCountSummaryInProgress == false &&
                    (taskController.taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                        false),
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      taskController.taskCountSummaryListModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount =
                        taskController.taskCountSummaryListModel.taskCountList![index];
                        return FittedBox(
                          child: SummaryCard(
                            count: taskCount.sum.toString(),
                            title: taskCount.sId ?? '',
                          ),
                        );
                      }),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: taskController.getNewTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: taskController.getNewTaskList,
                    child: ListView.builder(
                      itemCount: taskController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: taskController.taskListModel.taskList![index],
                          onStatusChange: () {
                            taskController.getNewTaskList();
                          },
                          showProgress: (inProgress) {
                            taskController.updateGetNewTaskInProgressStatus(inProgress) ;

                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}