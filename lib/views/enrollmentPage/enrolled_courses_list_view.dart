import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/enrollment.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/unenroll_dialog.dart';

typedef EnrollmentCallback = void Function(Enrollment enrollment);

class EnrolledCoursesListView extends StatelessWidget {
  final Iterable<Enrollment> enrollments;
  final EnrollmentCallback onUnEnroll;

  const EnrolledCoursesListView({
    super.key,
    required this.enrollments,
    required this.onUnEnroll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          "ENROLLED COURSES",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: enrollments.length,
            itemBuilder: (context, index) {
              final enrollment = enrollments.elementAt(index);
              return ListTile(
                title: Text(
                  enrollment.courseCode,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final shouldUnEnroll = await showUnEnrollDialog(context);
                    if (shouldUnEnroll) {
                      onUnEnroll(enrollment);
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
