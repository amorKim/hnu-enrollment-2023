import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';

typedef CourseCallback = void Function(Course course);

class CoursesListView extends StatelessWidget {
  final Iterable<Course> courses;
  final CourseCallback onEnrollCourse;
  final BuildContext context;

  const CoursesListView({
    Key? key,
    required this.context,
    required this.courses,
    required this.onEnrollCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          "COURSE OFFERINGS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 10,
            child: Scrollable(
              viewportBuilder: (context, viewportOffset) {
                return ListView.builder(
                  controller: ScrollController(),
                  itemExtent: deviceHeight * 0.1,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses.elementAt(index);
                    return DataTable(
                      dataRowHeight: deviceHeight * 0.1,
                      headingRowHeight: deviceHeight * 0,
                      columnSpacing: deviceWidth * 0.10,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Course Code',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Schedule',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataColumn(label: Text('+')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(course.courseCode)),
                          DataCell(
                            Center(child: Text(course.schedule.toString())),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () async {
                                onEnrollCourse(course);
                              },
                              icon: const Icon(Icons.add_card_rounded),
                            ),
                          ),
                        ]),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
