import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';

typedef CourseCallback = void Function(Course course);

class CoursesListView extends StatelessWidget {
  final Iterable<Course> courses;
  final CourseCallback onEnrollCourse;

  const CoursesListView({
    super.key,
    required this.courses,
    required this.onEnrollCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text("COURSE OFFERINGS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses.elementAt(index);
              return ListTile(
                title: Text(
                  course.courseName,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    onEnrollCourse(course);
                  },
                  icon: const Icon(Icons.add_card_rounded),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
