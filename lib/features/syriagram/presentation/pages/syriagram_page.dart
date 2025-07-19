import 'package:flutter/material.dart';
import '../../../../core/config/app_config.dart';

/// SyriaGram community page
class SyriaGramPage extends StatefulWidget {
  const SyriaGramPage({super.key});

  @override
  State<SyriaGramPage> createState() => _SyriaGramPageState();
}

class _SyriaGramPageState extends State<SyriaGramPage> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'user': {
        'name': 'أحمد محمد',
        'username': '@ahmed_syria',
        'avatar': 'https://example.com/avatar1.jpg',
        'isVerified': true,
      },
      'location': 'تدمر، سوريا',
      'image': 'https://example.com/palmyra_post.jpg',
      'caption': 'رحلة مذهلة إلى مدينة تدمر التاريخية! 🌅 #تدمر #سوريا #تاريخ',
      'likes': 1247,
      'comments': 89,
      'shares': 45,
      'timestamp': '2 ساعة',
      'isLiked': false,
      'isSaved': false,
    },
    {
      'id': '2',
      'user': {
        'name': 'سارة الخالد',
        'username': '@sara_khaled',
        'avatar': 'https://example.com/avatar2.jpg',
        'isVerified': false,
      },
      'location': 'الجامع الأموي، دمشق',
      'image': 'https://example.com/umayyad_post.jpg',
      'caption': 'جمال الجامع الأموي في الصباح الباكر ✨ #دمشق #الجامع_الأموي',
      'likes': 892,
      'comments': 67,
      'shares': 23,
      'timestamp': '5 ساعة',
      'isLiked': true,
      'isSaved': true,
    },
    {
      'id': '3',
      'user': {
        'name': 'محمد العلي',
        'username': '@mohammed_ali',
        'avatar': 'https://example.com/avatar3.jpg',
        'isVerified': true,
      },
      'location': 'قلعة الحصن، حمص',
      'image': 'https://example.com/krak_post.jpg',
      'caption':
          'قلعة الحصن - تحفة معمارية من العصور الوسطى 🏰 #قلعة_الحصن #حمص',
      'likes': 1567,
      'comments': 123,
      'shares': 78,
      'timestamp': '1 يوم',
      'isLiked': false,
      'isSaved': false,
    },
  ];

  final List<Map<String, dynamic>> _stories = [
    {
      'id': '1',
      'user': {
        'name': 'أحمد محمد',
        'avatar': 'https://example.com/avatar1.jpg',
      },
      'image': 'https://example.com/story1.jpg',
      'isViewed': false,
    },
    {
      'id': '2',
      'user': {
        'name': 'سارة الخالد',
        'avatar': 'https://example.com/avatar2.jpg',
      },
      'image': 'https://example.com/story2.jpg',
      'isViewed': true,
    },
    {
      'id': '3',
      'user': {
        'name': 'محمد العلي',
        'avatar': 'https://example.com/avatar3.jpg',
      },
      'image': 'https://example.com/story3.jpg',
      'isViewed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SyriaGram'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // TODO: إنشاء منشور جديد
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: الانتقال إلى الإشعارات
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              // TODO: الانتقال إلى الرسائل
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // القصص (Stories)
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: AppConfig.spacingM),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConfig.spacingM,
              ),
              itemCount: _stories.length + 1, // +1 for add story button
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _AddStoryButton();
                }
                final story = _stories[index - 1];
                return _StoryItem(story: story);
              },
            ),
          ),
          // التبويبات
          Container(
            decoration: BoxDecoration(
              color: AppConfig.backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: AppConfig.primaryColor.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    icon: Icons.grid_on,
                    isSelected: _selectedTab == 0,
                    onTap: () => _selectTab(0),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    icon: Icons.person_pin,
                    isSelected: _selectedTab == 1,
                    onTap: () => _selectTab(1),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    icon: Icons.favorite,
                    isSelected: _selectedTab == 2,
                    onTap: () => _selectTab(2),
                  ),
                ),
              ],
            ),
          ),
          // المنشورات
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              children: [
                _PostsTab(posts: _posts),
                _MapTab(),
                _FavoritesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class _AddStoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppConfig.spacingM),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppConfig.primaryColor, width: 2),
            ),
            child: Icon(Icons.add, color: AppConfig.primaryColor, size: 24),
          ),
          const SizedBox(height: 4),
          Text('إضافة', style: AppConfig.caption),
        ],
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final Map<String, dynamic> story;

  const _StoryItem({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppConfig.spacingM),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: story['isViewed'] ? Colors.grey : AppConfig.primaryColor,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Container(
                color: AppConfig.primaryColor.withOpacity(0.1),
                child: const Icon(
                  Icons.person,
                  color: AppConfig.primaryColor,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            story['user']['name'],
            style: AppConfig.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConfig.spacingM),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppConfig.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: isSelected
              ? AppConfig.primaryColor
              : AppConfig.textSecondaryColor,
        ),
      ),
    );
  }
}

class _PostsTab extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  const _PostsTab({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _PostCard(post: posts[index]);
      },
    );
  }
}

class _PostCard extends StatefulWidget {
  final Map<String, dynamic> post;

  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس المنشور
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppConfig.primaryColor.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    color: AppConfig.primaryColor,
                  ),
                ),
                const SizedBox(width: AppConfig.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post['user']['name'],
                            style: AppConfig.body1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post['user']['isVerified'])
                            const Icon(
                              Icons.verified,
                              color: AppConfig.primaryColor,
                              size: 16,
                            ),
                        ],
                      ),
                      Text(post['location'], style: AppConfig.caption),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: عرض خيارات المنشور
                  },
                ),
              ],
            ),
          ),
          // صورة المنشور
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withOpacity(0.1),
            ),
            child: const Center(
              child: Icon(Icons.photo, size: 64, color: AppConfig.primaryColor),
            ),
          ),
          // أزرار التفاعل
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                    color: post['isLiked'] ? AppConfig.syrianRed : null,
                  ),
                  onPressed: () {
                    setState(() {
                      post['isLiked'] = !post['isLiked'];
                      if (post['isLiked']) {
                        post['likes']++;
                      } else {
                        post['likes']--;
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {
                    // TODO: فتح التعليقات
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // TODO: مشاركة المنشور
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    post['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
                    color: post['isSaved'] ? AppConfig.primaryColor : null,
                  ),
                  onPressed: () {
                    setState(() {
                      post['isSaved'] = !post['isSaved'];
                    });
                  },
                ),
              ],
            ),
          ),
          // عدد الإعجابات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConfig.spacingM),
            child: Text(
              '${post['likes']} إعجاب',
              style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: AppConfig.spacingS),
          // النص
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConfig.spacingM),
            child: RichText(
              text: TextSpan(
                style: AppConfig.body1,
                children: [
                  TextSpan(
                    text: '${post['user']['name']} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: post['caption']),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConfig.spacingS),
          // التعليقات
          if (post['comments'] > 0)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConfig.spacingM,
              ),
              child: Text(
                'عرض جميع التعليقات (${post['comments']})',
                style: AppConfig.caption.copyWith(
                  color: AppConfig.textSecondaryColor,
                ),
              ),
            ),
          const SizedBox(height: AppConfig.spacingS),
          // الوقت
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConfig.spacingM),
            child: Text(
              post['timestamp'],
              style: AppConfig.caption.copyWith(
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ),
          const SizedBox(height: AppConfig.spacingM),
        ],
      ),
    );
  }
}

class _MapTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('خريطة المنشورات'),
        ],
      ),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('المنشورات المفضلة'),
        ],
      ),
    );
  }
}
