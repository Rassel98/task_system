import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';

class NewTaskView extends StatelessWidget {
  final TaskModel? taskModel;
  final int? idx;
  const NewTaskView({Key? key, this.taskModel, this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    if (taskModel != null) {
      controller.titleController.text = taskModel!.title;
      controller.descriptionController.text = taskModel!.description ?? "";
      controller.isStatus(taskModel!.status);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(taskModel == null ? "New Task" : "Edit Task"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            controller.titleController.clear();
            controller.descriptionController.clear();
            controller.isStatus(false);
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Form(
            key: controller.formKeys,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xffff3333),
                    keyboardType: TextInputType.text,
                    controller: controller.titleController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please write your task title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Enter task title",
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9),
                            ))),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xffff3333),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: controller.descriptionController,
                    maxLines: 5,
                    expands: false,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please write task description ';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Write your task description",
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: "Description",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9),
                            ))),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: controller.isStatus.value,
                          checkColor: Colors.white,
                          activeColor: const Color(0xFFC81E26),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onChanged: (v) {
                            controller.isStatus(v);
                          }),
                      const Text(
                        'Status',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        debugPrint("dksgkdfsg");
                        if (taskModel == null) {
                          controller.insertTask();
                        } else {
                          controller.updateTask(taskModel!, idx!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        taskModel == null ? 'Save' : "Update",
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
