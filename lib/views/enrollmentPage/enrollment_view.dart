import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';
import 'package:hnu_mis_announcement/services/cloud/enrollment.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/logout_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:hnu_mis_announcement/views/enrollmentPage/courses_list_view.dart';
import 'package:hnu_mis_announcement/views/enrollmentPage/enrolled_courses_list_view.dart';

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
    super.initState();
    _enrollmentService = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: _enrollmentService.allCourses(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allCourses = snapshot.data as Iterable<Course>;
                  return Expanded(
                    child: CoursesListView(
                      courses: allCourses,
                      onEnrollCourse: (course) async {
                        await _enrollmentService.enrollStudentToCourse(
                          userId: userId,
                          courseId: course.documentId,
                          courseCode: course.courseCode,
                          courseName: course.courseName,
                          courseSchedule: course.schedule,
                          courseScheduleLab: course.scheduleLab,
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(height: 16), // add some spacing between the streams
        StreamBuilder(
          stream: _enrollmentService.allEnrollmentsOfStudent(userId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allEnrollments = snapshot.data as Iterable<Enrollment>;
                  return Expanded(
                    child: EnrolledCoursesListView(
                      enrollments: allEnrollments,
                      onUnEnroll: (enrollment) {
                        print(enrollment.toString());
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
        // add more StreamBuilders for additional streams
      ],
    );
  }
}
