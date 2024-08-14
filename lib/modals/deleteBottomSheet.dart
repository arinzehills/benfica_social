import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/screens/add_post.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

 Future showDeleteBottomSheet(BuildContext context, Post post) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          bool isLoading = false;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'More Options',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                MyButton(placeHolder: 'Delete',
                color: Colors.redAccent.withOpacity(0.2),
                suffixIcon: Icon(IconlyBold.delete,color: AppColors.danger,),
                loadingState: isLoading, pressed:  () {
                 
                     _showConfirmDialog(context, post.id, setState).then((onValue)=>
                    Navigator.pop(context)//close it
                    );
                  },)
               ,
                SizedBox(height: 16),
                MyButton(placeHolder: 'Edit',
                color: AppColors.success.withOpacity(0.2),
                suffixIcon: Icon(IconlyBold.delete,color: AppColors.success,),
                loadingState: isLoading, pressed:  () {
                      Get.to(()=>AddPost(post: post,));
                  },)
               ,
                SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
Future<void> _showConfirmDialog(
    BuildContext context, String postId, StateSetter setState) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: isLoading
                ? CircularProgressIndicator()
                : Text('Are you sure you want to permanently delete this post?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close the dialog
                child: Text('Cancel'),
              ),
             MyButton(placeHolder: 'Delete',
                color: Colors.redAccent.withOpacity(0.2),
                suffixIcon: Icon(IconlyBold.delete,color: AppColors.danger,),
                loadingState: isLoading,
                pressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  // Navigator.pop(context); // Close the dialog
                  await PostService().deletePost(postId:postId,);
                  setState(()=>{});
                }, 
               
              ),
            ],
          );
        },
      );
    },
  );
}


