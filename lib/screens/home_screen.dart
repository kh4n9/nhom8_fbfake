import 'package:flutter/material.dart';

// Định nghĩa lớp Post
class Post {
  final String userName;
  final String userAvatarUrl;
  final String content;
  final String? postImageUrl;
  final String timeAgo;

  const Post({
    required this.userName,
    required this.userAvatarUrl,
    required this.content,
    this.postImageUrl,
    required this.timeAgo,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Danh sách bài viết
  final List<Post> posts = const [
    Post(
      userName: 'Nguyễn Văn A',
      userAvatarUrl: 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
      content: 'Hôm nay trời thật đẹp!',
      postImageUrl: 'https://scontent.fsgn1-1.fna.fbcdn.net/v/t39.30808-6/468613614_1002070678632177_8263620590873043370_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHp0LSOV2YmBHhIkVaN-PIG2KXrW7p7vcvYpetbunu9y5GP6VotkEE0IOJWHgFK8DwD9afzYbmYcAvLihmaIf7H&_nc_ohc=gP1e7SNKfPsQ7kNvgHL1NWP&_nc_zt=23&_nc_ht=scontent.fsgn1-1.fna&_nc_gid=AFE0Bot1_LuH19k-DE5oxzO&oh=00_AYAp9AjSCtMvI5gZG99O_FkXyUFo7tCdZ_6stU1U-QurDA&oe=674E0B05',
      timeAgo: '2 giờ trước',
    ),
    Post(
      userName: 'Trần Thị B',
      userAvatarUrl: 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
      content: 'Đã hoàn thành dự án Flutter đầu tiên của mình!',
      postImageUrl: null,
      timeAgo: '5 giờ trước',
    ),
    Post(
      userName: 'Lê Văn C',
      userAvatarUrl: 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
      content: 'Cùng nhau học lập trình nhé!',
      postImageUrl: 'https://scontent.fsgn1-1.fna.fbcdn.net/v/t39.30808-6/468249386_889400803380797_7038151702707694767_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHiqTidT78-FzjPk6HnyHnXzRknhW78W4rNGSeFbvxbiplpVv0LComqMiOAErsM8TiT8mjcc-wDTfolc7RmLnXN&_nc_ohc=XMlp2WIViIAQ7kNvgFnIvzh&_nc_zt=23&_nc_ht=scontent.fsgn1-1.fna&_nc_gid=A2lmzH-UiXX02G8ylh_Y8RJ&oh=00_AYAh4p4LhnPf5z9AegWJ0AIi8VHTsKdHlt4TOqubgtCKGw&oe=674DE4A3',
      timeAgo: '1 ngày trước',
    ),
    // Thêm nhiều bài viết tại đây
  ];

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const Text("Home"),
            floating: true,  // AppBar sẽ xuất hiện khi cuộn xuống.
            pinned: true,    // Giữ AppBar luôn hiển thị khi cuộn lên.
            snap: true,      // Hiệu ứng snap khi cuộn lên/xuống.
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Home"),
              background: Image.asset(
                'assets/home_tab_logo.png',  // Logo tab Home
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin người dùng
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(post.userAvatarUrl),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            post.timeAgo,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Nội dung bài viết
                  Text(post.content),
                  const SizedBox(height: 10),
                  // Hình ảnh bài viết (nếu có)
                  if (post.postImageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        post.postImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 10),
                  // Các nút tương tác
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconText(Icons.thumb_up_alt_outlined, 'Thích'),
                      _buildIconText(Icons.comment_outlined, 'Bình luận'),
                      _buildIconText(Icons.share_outlined, 'Chia sẻ'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Hàm tạo widget cho nút tương tác
  Widget _buildIconText(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
