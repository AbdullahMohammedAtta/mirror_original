import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  const ImagePage(String this.imgUrl, {super.key});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imgUrl),
        enableRotation: true,
        wantKeepAlive: true,
      ),
    );
  }

}
