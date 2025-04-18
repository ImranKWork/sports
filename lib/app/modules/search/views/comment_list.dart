import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/controllers/home_controller.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/shared_preference.dart';
import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../widgets/common_header.dart';

class CommentList extends StatefulWidget {
  final String id;
  const CommentList({super.key, required this.id});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final HomeController controller = Get.put(HomeController());
  final TextEditingController commentControllers = TextEditingController();

  bool isEditing = false;
  String editingCommentId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchComments(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size30),
                Text(
                  "Back",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorAssets.themeColorOrange,
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.commentsList.isEmpty) {
          return Center(
            child: Text(
              "No comments yet",
              style: Styles.textMetalHeader.copyWith(color: ColorAssets.black),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 3),
          physics: BouncingScrollPhysics(),
          itemCount: controller.commentsList.length,
          itemBuilder: (context, index) {
            final item = controller.commentsList[index];
            final commentUserId = item["user_id"];
            final currentUserId = SharedPref.getString(PrefsKey.userId, "");

            return ListTile(
              leading: Image.asset(ImageAssets.img6, scale: 3),
              title: Row(
                children: [
                  Text(
                    "${item["username"]} | ${timeago.format(DateTime.parse(item["created_at"]))}",
                    style: Styles.textMetalHeader.copyWith(
                      color: ColorAssets.black,
                    ),
                  ),
                  const Spacer(),
                  if (commentUserId == currentUserId) ...[
                    InkWell(
                      onTap: () {
                        isEditing = true;
                        editingCommentId = item["comment_id"];
                        commentControllers.text = item["commentText"];
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await controller.deleteComment(
                          widget.id,
                          item["comment_id"],
                        );
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ],
              ),
              subtitle: Text(
                item["commentText"],
                style: Styles.textStyleWhite16.copyWith(fontSize: 12),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Row(
            children: [
              Image.asset(ImageAssets.img6, height: 40, width: 40),
              SizedBox(width: Constant.size5),
              Expanded(
                child: TextField(
                  controller: commentControllers,
                  decoration: InputDecoration(
                    hintText:
                        isEditing ? "Edit your comment..." : "Add a comment...",
                    hintStyle: Styles.textStyleWhite16.copyWith(fontSize: 12),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorAssets.themeColorOrange,
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isEditing)
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                                editingCommentId = '';
                                commentControllers.clear();
                              });
                            },
                          ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(ImageAssets.smile, scale: 3),
                        ),
                        Container(
                          height: 20,
                          width: 1.5,
                          color: Colors.grey.shade400,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final commentText = commentControllers.text.trim();
                            if (commentText.isEmpty) return;

                            if (isEditing) {
                              await controller.editComment(
                                widget.id,
                                editingCommentId,
                                commentText,
                              );
                              setState(() {
                                isEditing = false;
                                editingCommentId = '';
                              });
                            } else {
                              await controller.commentVideos(
                                widget.id,
                                commentText,
                              );
                            }

                            commentControllers.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {});
                          },
                          child: Image.asset(ImageAssets.send, scale: 3),
                        ),
                        SizedBox(width: Constant.size10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
