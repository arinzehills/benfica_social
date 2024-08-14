import 'dart:convert';
import 'dart:io';
import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/widgets/images_display.dart'; 
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/my_text_field.dart';
import 'package:benfica_social/widgets/radial-gradient.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// import 'package:share/share.dart';

class AddComment extends StatefulWidget {
  final Post? post;
  const AddComment({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  String error = '';
  String  comment = '';
  final _formKey = GlobalKey<FormState>();
  File? image;
  List<File>? images=[];
  String imagename = '';
  bool loading = false;


  Future popUp(uid, docid) {
    int count = 0;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
          height: 172,
          child: Center(
            child: Column(
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.red,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17.0, top: 9),
                  child: Text(
                    'Confirm Delete?',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Are you sure you want to delete?',
                    style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColorValue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Roboto'),
                        ),
                        onPressed: () => {
                          // status==true ? _emailSuccess(context) : _emailFailure(context)
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Roboto'),
                        ),
                        onPressed: () => {
                          // Navigator.of(context).popUntil((_) => count++ >= 2),
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconlyBold.arrow_left,
              color: AppColors.primaryColorValue,
            ),
          ),
          elevation: 0,
          title:const Text(
            'Comment',
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MyText.myText(widget.post!.title),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter a comment' : null,
                              keyboardType: TextInputType.multiline,
                              // initialValue: widget.post == null
                              //     ? null
                              //     : widget.post!.comment,
                              maxLines: image == null ? 7: 4,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Enter comment...',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() => comment = val);
                              },
                            ),
                          ),
                        ),
                        images!.length==0 
                            ? SizedBox()
                            : ImageDisplay(images: images!),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              
                              MyButton(
                                placeHolder: 'Add Comment',
                                height: 45, 
                                loadingState: loading,
                                isOval: true,
                                widthRatio: 0.40,
                                pressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                     
                                     setState(() => loading = true);
                                   var res = await PostService().addComment(postId: widget.post!.id,comment: comment);
                                     setState(() => loading = false);

                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ]),
                ))));
  }

  void _showModalBottomSheet(context, uid, docid) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //     padding: const EdgeInsets.only(left: 13.0),
                    //     child: GradientText('More options',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold, fontSize: 20),
                    //         gradient: LinearGradient(
                    //           colors: [myhomepageBlue, myhomepageLightBlue],
                    //         ))),
                    RadiantGradientMask(
                      child: IconButton(
                        icon: Icon(
                          IconlyBold.close_square,
                          color: AppColors.primaryColorValue,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: RadiantGradientMask(
                            child: Icon(
                              Icons.cancel,
                              color: AppColors.primaryColorValue,
                              size: 19.83,
                            ),
                          ),
                          tooltip: 'cancel',
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: Text(
                            'Cancel changes',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.post != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: GestureDetector(
                      onTap: () {
                        print('deleted');
                        Navigator.pop(context);
                        popUp(uid, docid);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(left: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 19.83,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text(
                                'Delete Note',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ]);
        });
  }



}
