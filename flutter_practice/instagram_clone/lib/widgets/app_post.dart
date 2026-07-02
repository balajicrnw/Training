import 'package:instagram_clone/widgets/ui.dart';

class AppPost extends StatefulWidget {
  final Widget widget;
  AppPost({super.key, required this.widget});

  factory AppPost.small({required Post post}) {
    return AppPost(
      widget: SizedBox(
        height: 210,
        width: 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 20,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 2),
                    AppText.small(text: post.views.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory AppPost.home({required List<Post> posts}) {
    return AppPost(
      widget: ListView.builder(
        itemCount: posts.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return AppHomePost(post: posts[index]);
        },
      ),
    );
  }

  factory AppPost.full({required List<Post> post}) {
    return AppPost(
      widget: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: post.length,
        itemBuilder: (context, index) {
          return AppReel(post: post[index]);
        },
      ),
    );
  }

  @override
  State<AppPost> createState() => _AppPostState();
}

class _AppPostState extends State<AppPost> {
  @override
  Widget build(BuildContext context) {
    return Container(child: widget.widget);
  }
}

class AppReel extends StatefulWidget {
  final Post post;
  AppReel({super.key, required this.post});

  @override
  State<AppReel> createState() => _AppReelState();
}

class _AppReelState extends State<AppReel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(widget.post.image, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      AppCountIcon(
                        icon: Icons.favorite_outline_rounded,
                        count: (widget.post.likes).toString(),
                      ),
                      AppCountIcon(
                        icon: Icons.mode_comment_outlined,
                        count: (widget.post.comments).toString(),
                      ),
                      AppCountIcon(
                        icon: Icons.repeat_rounded,
                        count: (widget.post.reposts).toString(),
                      ),
                      AppCountIcon(
                        icon: Icons.send_outlined,
                        count: (widget.post.comments).toString(),
                      ),
                      AppCountIcon(
                        icon: Icons.bookmark_outline,
                        count: (widget.post.saved).toString(),
                      ),
                      AppIconButton(
                        icon: Icons.more_vert,
                        onPressed: () {},
                        selected: true,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      AppProfile(user: mockData[0]),
                      SizedBox(width: 8, height: 32),
                      AppText.small(text: mockData[0].userName),
                      SizedBox(width: 16),
                      AppButton.transparent(text: "Follow", onPressed: () {}),
                    ],
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText.small(text: widget.post.description),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppHomePost extends StatelessWidget {
  final Post post;
  const AppHomePost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(post.image),
            Positioned(
              top: 12,
              left: 12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppProfile(user: mockData[0], width: 40, height: 40),
                    SizedBox(width: 8),
                    AppText.small(text: mockData[0].userName),
                    SizedBox(width: 100),
                    AppButton.outlined(text: "Follow", onPressed: () {}),
                    SizedBox(width: 8),
                    AppIconButton(
                      icon: Icons.menu,
                      onPressed: () {},
                      selected: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              AppIconButton(
                icon: Icons.favorite_outline_rounded,
                onPressed: () {},
                selected: true,
              ),
              SizedBox(width: 8),
              AppIconButton(
                icon: Icons.mode_comment_outlined,
                onPressed: () {},
                selected: true,
              ),
              AppText.small(text: post.comments.toString()),
              SizedBox(width: 8),
              AppIconButton(
                icon: Icons.repeat_rounded,
                onPressed: () {},
                selected: true,
              ),
              AppText.small(text: post.reposts.toString()),
              SizedBox(width: 8),
              AppIconButton(
                icon: Icons.send_outlined,
                onPressed: () {},
                selected: true,
              ),
              Spacer(),
              AppIconButton(
                icon: Icons.bookmark_outline,
                onPressed: () {},
                selected: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.small(text: "Liked by batman and others"),
              AppText.small(text: post.description),
              Row(
                children: [
                  AppText.grey(text: "7 June"),
                  SizedBox(width: 8),

                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  AppText.small(text: "See translation"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppCountIcon extends StatelessWidget {
  final icon;
  final count;
  const AppCountIcon({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppIconButton(icon: icon, onPressed: () {}, selected: true),

        AppText.small(text: count),
        SizedBox(height: 8),
      ],
    );
  }
}
