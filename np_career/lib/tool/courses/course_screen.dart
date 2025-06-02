import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/services/call_api.dart';
import 'package:np_career/tool/courses/course_video_screen.dart';
import 'package:np_career/tool/courses/providers/CourseProvider.dart';
import 'package:provider/provider.dart';
import 'package:np_career/model/course.dart';

class CourseListScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  CourseListScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  String? getYoutubeThumbnail(String? youtubeLink) {
    if (youtubeLink == null) return null;

    final uri = Uri.tryParse(youtubeLink);
    if (uri == null) return null;

    String? videoId;

    if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
    } else if (uri.host == 'youtu.be') {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    }

    if (videoId == null || videoId.isEmpty) return null;

    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseProvider>(
      create: (_) =>
          CourseProvider(apiService: AppService(), categoryId: categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Khoá học: $categoryName'),
          centerTitle: true,
          backgroundColor: AppColor.orangePrimaryColor,
          foregroundColor: Colors.white,
        ),
        body: Consumer<CourseProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.courses.isEmpty) {
              return const Center(child: Text('Không có khóa học nào.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.courses.length,
              itemBuilder: (context, index) {
                final course = provider.courses[index];
                final enrollmentStatusCode =
                    provider.enrollmentStatus[course.id!] ?? 1;
                return _buildCourseCard(
                    context, course, enrollmentStatusCode, provider);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    Course course,
    int enrollmentStatusCode,
    CourseProvider provider,
  ) {
    final thumbnailUrl = getYoutubeThumbnail(course.youtubeLink);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnailUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(height: 180),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              course.title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              course.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '${course.price.toStringAsFixed(2)} VNĐ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            if (enrollmentStatusCode == 3) ...[
              // Active - Hiển thị nút xem video
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.orangePrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.play_circle_fill),
                  label: const Text(
                    'Xem video',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (course.youtubeLink != null &&
                        course.youtubeLink!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseVideoScreen(
                            youtubeUrl: course.youtubeLink!,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Không có link video')),
                      );
                    }
                  },
                ),
              )
            ] else if (enrollmentStatusCode == 2) ...[
              // Inactive - Hiển thị nút chờ xác nhận, không cho bấm
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: null, // Không cho bấm
                  child: const Text(
                    'Chờ xác nhận',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ] else ...[
              // Chưa đăng ký (1) - Hiển thị nút đăng ký
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.orangePrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    String userId = auth.currentUser!.uid;

                    bool success = await AppService().enrollCourse(
                      userId: userId,
                      courseId: course.id!,
                      note: 'Đăng ký từ app',
                      status: 'inactive',
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Đăng ký khóa học thành công!')),
                      );
                      await provider.init();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Đăng ký thất bại. Vui lòng thử lại.')),
                      );
                    }
                  },
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
