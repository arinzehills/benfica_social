import 'dart:convert';

import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/my_paddings.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/no_items_widget.dart';
import 'package:benfica_social/widgets/post_list_item.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  List<Post> _posts = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });
  }

  Future<void> _fetchPosts({isRefresh = false}) async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);
    if (isRefresh) {
      setState(() {
        _page = 1;
        _posts = [];
        _hasMore = true;
      });
    }
    setState(() => _isLoading = false);

    try {
      var posts = await PostService().fetchPost(_page, 10);

      if (posts.isNotEmpty && !isRefresh) {
        setState(() {
          _page++;
          _posts.addAll(posts);
        });
      } else {
        setState(() {
          _hasMore = false;
        });
      }
    } catch (err) {
      print('Error: $err');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMorePosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Post> newPosts = await PostService().fetchPost(_page, 10);
      setState(() {
        _posts.addAll(newPosts);
        _page++;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 30,
            ),
            MyText.myText('Posts Feed', textSize: MyTextSize.small),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: MyPaddings.responsivePadding(context,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _loadMorePosts();
              }
              return true;
            },
            child: Column(
              children: [
                if (_isLoading)
                  Container(
                    color: AppColors.primaryColorTransperent,
                    child: MyText.myText('...Loading More',
                        align: TextAlign.center,
                        color: AppColors.primaryColorValue),
                    width: double.infinity,
                  ),
                  if(_posts.isEmpty) NoItemsWidget(message: "No Posts Added",),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _fetchPosts(isRefresh: true);
                    },
                    child: ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: (context, index) {
                          var post = _posts[index];
                          return PostListItem(
                              post: post,
                              imageUrls: post.imageUrls,
                              title: post.title,
                              description: post.description);
                        }),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
