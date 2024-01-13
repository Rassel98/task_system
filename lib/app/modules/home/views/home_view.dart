import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/home/views/new_task_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.getTaskList.isEmpty
              ? const Center(
                  child: Text("No Data Found !!"),
                )
              : Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: const Color(0xffff3333),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search task",
                          prefixIcon: const Icon(CupertinoIcons.search_circle_fill),
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.9),
                              ))),

                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (v){
                        controller.runFilter(v);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.searchTask.length,
                        itemBuilder: (context, index) {
                          final model = controller.searchTask[index];
                          return Dismissible(
                            key: Key(model.id.toString()),
                            confirmDismiss: (direction) async {
                              return await showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Confirm Deletion'),
                                    content: const Text('Are you sure you want to delete task?'),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          controller.deleteTask(model);
                                          Navigator.of(context).pop(true);
                                        },
                                        isDestructiveAction: true,
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            direction: DismissDirection.horizontal,
                            background: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const Text("You are deleting this task")),
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xffD4D5D6).withOpacity(0.7),
                                        spreadRadius: 0,
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 20,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Title : ',
                                        style: const TextStyle(fontSize: 16, fontFamily: 'muli', fontWeight: FontWeight.w600, color: Color(0xFF404144)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: model.title ?? "",
                                            style: const TextStyle(fontFamily: 'HindSiliguri', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Description : ',
                                        style: const TextStyle(fontSize: 16, fontFamily: 'muli', fontWeight: FontWeight.w600, color: Color(0xFF404144)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: model.description ?? "",
                                            style: const TextStyle(fontFamily: 'HindSiliguri', fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Status : ',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: model.status ? const Color(0xff268A58) : Colors.red,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 0.5, color: Colors.pink),
                                          ),
                                          child: Text(
                                            model.status ? 'Active' : "Inactive",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  child: TextButton(
                                    onPressed: () => Get.to(
                                      () => NewTaskView(
                                        taskModel: model,
                                        idx: index,
                                      ),
                                      transition: Transition.leftToRight,
                                      duration: const Duration(milliseconds: 260),
                                      curve: Curves.easeInOut,
                                    ),
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(const Size(35, 25)),
                                      maximumSize: MaterialStateProperty.all(const Size(43, 28)),
                                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.pinkAccent, width: 1.5),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      )),
                                    ),
                                    child: const Text('Edit', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  ),
                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          () => const NewTaskView(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeInOut,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
