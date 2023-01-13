
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'dart:io';
class ActivityVision2Widget extends StatefulWidget {
  const ActivityVision2Widget({Key? key}) : super(key: key);

  @override
  _ActivityVision2WidgetState createState() => _ActivityVision2WidgetState();
}

class _ActivityVision2WidgetState extends State<ActivityVision2Widget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? _userImage ;

  void fn_cropImage() async {
    if (_userImage != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _userImage!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _userImage = croppedFile as File?;
        });
      }
    }
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image:  (_userImage == null)? Image.network('https://picsum.photos/seed/858/600',).image:Image.file( _userImage!,).image,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Container(

                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF27FF42),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 100,

                        decoration: BoxDecoration(

                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF141515),
                                  borderRadius: BorderRadius.circular(30),

                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Scale 1',
                                      style:TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(

                                icon: Icon(
                                  Icons.photo_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  var picker = ImagePicker();
                                  var image = await picker.pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    setState((){
                                      _userImage = File(image.path);
                                    });
                                  }
                                }

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child:  Image.network('https://picsum.photos/seed/858/600',
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                        ),


                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
