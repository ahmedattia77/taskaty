import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskaty/core/common_widgets/custom_back_button.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/features/home/data/model/add_task_request_body.dart';
import 'package:taskaty/features/home/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:taskaty/features/home/presentation/cubit/home/home_cubit.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task added successfully!'),
                backgroundColor: Colors.green,
              ),
            );

            context.read<HomeCubit>().fetchTasks();
            Navigator.pop(context);
          } else if (state is AddTaskFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMassage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomBackButton(pageNAme: Routes.homeScreenRoute),
                      SizedBox(width: 20.w),
                      Center(
                        child: Text(
                          'Add Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      hintText: 'Enter title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter task title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter task description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter task description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Delivery Date Field
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: 'Delivery Date',
                      hintText: 'YYYY-MM-DD',
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select delivery date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),

                  ElevatedButton(
                    onPressed: state is AddTaskLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AddTaskCubit>().addTask(
                                AddTaskRequestBody(
                                  title: _titleController.text.trim(),
                                  description: _descriptionController.text
                                      .trim(),
                                  deliveryDate: _dateController.text.trim(),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: state is AddTaskLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Create Task',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
