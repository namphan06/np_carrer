import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'policy_detail_screen.dart';

class PolicyHomePage extends StatelessWidget {
  final List<String> policies = [
    'Chính sách quyền riêng tư',
    'Điều khoản sử dụng',
    'Cam kết bảo mật thông tin',
    'Xóa tài khoản',
    'Liên hệ hỗ trợ',
  ];

  final List<String> contents = [
    privacyPolicy,
    termsOfUse,
    dataSecurity,
    deleteAccount,
    contactSupport,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Policy & Privacy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: policies.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              title: Text(policies[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Get.to(() => PolicyDetailScreen(
                      title: policies[index],
                      content: contents[index],
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}

// Nội dung bên ngoài class
const String privacyPolicy = '''
Chúng tôi cam kết tôn trọng và bảo vệ quyền riêng tư của tất cả người dùng sử dụng nền tảng tuyển dụng. Việc thu thập, lưu trữ và sử dụng thông tin cá nhân của bạn được thực hiện một cách minh bạch và có trách nhiệm. Thông tin cá nhân như tên, email, số điện thoại, thông tin tài khoản Google hoặc Facebook sẽ chỉ được sử dụng nhằm mục đích phục vụ việc kết nối giữa nhà tuyển dụng và người tìm việc.

Chúng tôi không chia sẻ dữ liệu người dùng cho bất kỳ bên thứ ba nào mà không có sự đồng ý rõ ràng từ phía bạn. Các hành vi như bán thông tin, sử dụng cho quảng cáo trái phép, hoặc theo dõi hoạt động cá nhân sẽ không được chấp nhận.

Ứng dụng sử dụng công nghệ mã hóa SSL để bảo vệ dữ liệu trong quá trình truyền tải và lưu trữ. Đồng thời, các biện pháp kiểm soát truy cập được áp dụng nhằm ngăn chặn hành vi truy cập trái phép vào hệ thống.

Người dùng có thể yêu cầu truy xuất, cập nhật hoặc xóa thông tin cá nhân của mình bất kỳ lúc nào. Chúng tôi luôn minh bạch trong cách thu thập dữ liệu và cho phép người dùng kiểm soát thông tin của chính họ.

Việc sử dụng nền tảng đồng nghĩa với việc bạn đồng ý với chính sách quyền riêng tư này. Nếu bạn không đồng ý, vui lòng ngừng sử dụng dịch vụ của chúng tôi.
''';

const String termsOfUse = '''
Khi đăng ký và sử dụng ứng dụng tuyển dụng, bạn đã đồng ý tuân thủ tất cả các điều khoản và điều kiện được quy định tại đây. Người dùng có trách nhiệm cung cấp thông tin chính xác, trung thực và cập nhật thường xuyên. Mọi hành vi giả mạo danh tính, đăng tin sai sự thật hoặc lừa đảo đều sẽ bị xử lý nghiêm theo quy định của pháp luật.

Ứng dụng cho phép các cá nhân và tổ chức đăng tin tuyển dụng, ứng tuyển vào vị trí phù hợp và quản lý hồ sơ ứng viên. Tuy nhiên, người dùng phải cam kết không đăng tải các nội dung vi phạm thuần phong mỹ tục, nội dung phản cảm, hoặc thông tin sai lệch gây hoang mang cho cộng đồng.

Chúng tôi có quyền chặn, khóa hoặc xóa tài khoản vi phạm mà không cần báo trước. Ngoài ra, những người dùng lạm dụng nền tảng cho các mục đích thương mại không phù hợp cũng sẽ bị từ chối cung cấp dịch vụ.

Người dùng không được sử dụng mã độc, spam, hay bất kỳ công cụ nào gây ảnh hưởng đến hiệu năng hoặc bảo mật của hệ thống.

Việc tiếp tục sử dụng ứng dụng được xem như bạn đã hiểu rõ và đồng ý với toàn bộ điều khoản được nêu ra trong văn bản này.
''';

const String dataSecurity = '''
Chúng tôi nhận thức rõ tầm quan trọng của bảo mật dữ liệu cá nhân và cam kết áp dụng những biện pháp nghiêm ngặt nhất để bảo vệ thông tin của người dùng. Tất cả dữ liệu được mã hóa và lưu trữ trong hệ thống bảo mật cao, đáp ứng các tiêu chuẩn quốc tế.

Thông tin như tên, số điện thoại, email, và các thông tin về hoạt động ứng tuyển chỉ được lưu trữ trên máy chủ nội bộ và không được chia sẻ ra bên ngoài nếu không có sự cho phép của người dùng.

Chúng tôi thường xuyên kiểm tra và cập nhật các biện pháp bảo mật để chống lại các cuộc tấn công mạng, xâm nhập trái phép hoặc mất dữ liệu.

Mỗi lần người dùng đăng nhập, hệ thống sẽ tạo ra mã xác thực an toàn, và dữ liệu người dùng luôn được truyền tải qua giao thức HTTPS nhằm đảm bảo an toàn tuyệt đối.

Trong trường hợp phát hiện có sự cố rò rỉ thông tin, chúng tôi sẽ thông báo đến người dùng trong vòng 72 giờ và phối hợp khắc phục nhanh chóng.

Người dùng cũng nên chủ động bảo mật tài khoản của mình bằng cách không chia sẻ mật khẩu, sử dụng xác thực 2 bước nếu có thể, và thoát khỏi tài khoản sau khi sử dụng.
''';

const String deleteAccount = '''
Chúng tôi tôn trọng quyền kiểm soát dữ liệu cá nhân của bạn. Nếu bạn không muốn tiếp tục sử dụng dịch vụ, bạn hoàn toàn có thể yêu cầu xóa tài khoản và toàn bộ dữ liệu liên quan bất kỳ lúc nào.

Khi xóa tài khoản, tất cả thông tin liên quan bao gồm hồ sơ cá nhân, lịch sử ứng tuyển, tin tuyển dụng (nếu có), và các dữ liệu liên quan khác sẽ bị xóa vĩnh viễn khỏi hệ thống. Quá trình này không thể hoàn tác.

Để gửi yêu cầu xóa tài khoản, bạn có thể vào phần "Cài đặt tài khoản" và chọn "Xóa tài khoản". Chúng tôi có thể yêu cầu bạn xác minh lại danh tính trước khi tiến hành để đảm bảo an toàn.

Việc xóa tài khoản sẽ không ảnh hưởng đến dữ liệu mà bạn đã chia sẻ công khai với người khác (như nhà tuyển dụng hoặc ứng viên), nếu họ đã lưu trữ dữ liệu đó trước thời điểm xóa.

Trong một số trường hợp đặc biệt (liên quan đến lừa đảo hoặc vi phạm pháp luật), thông tin sẽ được lưu lại theo quy định của pháp luật trong một thời gian nhất định trước khi xóa hoàn toàn.
''';

const String contactSupport = '''
Nếu bạn gặp bất kỳ sự cố nào khi sử dụng ứng dụng hoặc có câu hỏi liên quan đến quyền riêng tư và bảo mật, hãy liên hệ ngay với chúng tôi. Chúng tôi có đội ngũ chăm sóc khách hàng luôn sẵn sàng hỗ trợ bạn.

Email hỗ trợ: support@npcareers.vn

Số điện thoại: 0123-456-789

Thời gian làm việc: Thứ 2 - Thứ 6 (8h00 - 17h30)

Chúng tôi sẽ cố gắng phản hồi tất cả yêu cầu trong vòng 24 giờ làm việc. Đối với các vấn đề khẩn cấp như vi phạm dữ liệu, mất quyền truy cập tài khoản, hoặc báo cáo gian lận, vui lòng gọi trực tiếp để được xử lý nhanh chóng.

Ngoài ra, người dùng có thể gửi phản hồi, đề xuất cải tiến hoặc báo lỗi kỹ thuật qua mục “Góp ý” trong ứng dụng. Mọi ý kiến đều được tiếp nhận và xử lý nghiêm túc nhằm cải thiện trải nghiệm người dùng.
''';
