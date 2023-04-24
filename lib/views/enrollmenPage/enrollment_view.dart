import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/logout_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:hnu_mis_announcement/views/enrollmenPage/courses_list_view.dart';

class EnrollmentView extends StatefulWidget {
  const EnrollmentView({super.key});

  @override
  State<EnrollmentView> createState() => _EnrollmentViewState();
}

class _EnrollmentViewState extends State<EnrollmentView> {
  late final FirebaseCloudStorage _enrollmentService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _enrollmentService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _enrollmentService.allCourses(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (snapshot.hasData) {
              final allCourses = snapshot.data as Iterable<Course>;
              return CoursesListView(
                courses: allCourses,
                onEnrollCourse: (Course course) {
                  print(course.toString());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
