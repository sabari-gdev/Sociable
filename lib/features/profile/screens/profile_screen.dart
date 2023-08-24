import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/utils/theme/styles.dart';

import 'package:sociable/features/app/app.dart';
import 'package:sociable/features/auth/auth.dart';
import 'package:sociable/features/profile/cubit/profile_bloc.dart';
import 'package:sociable/features/profile/screens/edit_profile_screen.dart';

import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        repository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: kBodyLargeTextStyle,
          ),
          actions: [
            BlocListener<AppBloc, AppState>(
              listener: (context, state) {
                if (state.status == AppStatus.unauthenticated) {
                  debugPrint("Sign out");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
              child: TextButton.icon(
                onPressed: () {
                  context.read<AppBloc>().add(const AppLogoutRequested());
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: kPinkColor,
                    backgroundImage: state.documentSnapshot['profile'] != null
                        ? NetworkImage(state.documentSnapshot['profile']!)
                        : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${state.documentSnapshot['firstName']} ${state.documentSnapshot['lastName']}",
                        style: kHeading2TextStyle,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "ABOUT",
                        style: kTitleTextStyle,
                      ),
                      Text(
                        state.documentSnapshot['bio'] ?? "",
                        style: kParagraphOneTextStyle,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RoundedButton(
                  //         text: "Follow",
                  //         type: ButtonType.primary,
                  //         onPressed: () {},
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16),
                  //     Expanded(
                  //       child: RoundedButton(
                  //         text: "Chat",
                  //         onPressed: () {},
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: kPinkColor,
                            labelColor: kChromeBlackColor,
                            // tabAlignment: TabAlignment.center,
                            tabs: [
                              _ProfileTab(
                                count:
                                    state.documentSnapshot['posts'].toString(),
                                label: "Posts",
                              ),
                              _ProfileTab(
                                count: state.documentSnapshot['followers']
                                    .toString(),
                                label: "Followers",
                              ),
                              _ProfileTab(
                                count: state.documentSnapshot['following']
                                    .toString(),
                                label: "Following",
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.builder(
                                  itemCount: 12,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                                  itemBuilder: (context, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _PostGridWidget(
                                      image: state.documentSnapshot['profile'],
                                      likes: "10K",
                                      comments: "121",
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      const _FollowerListItem(
                                    isFollowing: false,
                                    name: "Account Name",
                                    username: "@username",
                                  ),
                                ),
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      const _FollowerListItem(
                                    isFollowing: false,
                                    name: "Account Name",
                                    username: "@username",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PostGridWidget extends StatelessWidget {
  final String? image;
  final String likes;
  final String comments;
  const _PostGridWidget({
    required this.comments,
    this.image,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPinkColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PostAttributeWidget(
              count: likes,
              icon: Icons.favorite,
            ),
            const SizedBox(width: 8),
            _PostAttributeWidget(
              count: comments,
              icon: Icons.comment,
            ),
          ],
        ),
      ),
      child: Image.network(
        image ??
            "https://cdn.vectorstock.com/i/preview-1x/70/84/default-avatar-profile-icon-symbol-for-website-vector-46547084.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class _FollowerListItem extends StatelessWidget {
  final String name;
  final String username;
  final bool isFollowing;

  const _FollowerListItem({
    required this.isFollowing,
    required this.name,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(name),
      subtitle: Text(username),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(isFollowing ? Icons.person_remove : Icons.person_add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
    );
  }
}

class _PostAttributeWidget extends StatelessWidget {
  final IconData icon;
  final String count;
  const _PostAttributeWidget({
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kLightWhiteColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: kButtonTextStyle,
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  final String count;
  final String label;
  const _ProfileTab({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count),
        Tab(
          text: label,
        ),
      ],
    );
  }
}
