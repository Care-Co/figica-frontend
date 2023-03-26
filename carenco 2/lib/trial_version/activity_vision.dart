
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'activity_vision2.dart';
import 'dart:io';
class ActivityVisionWidget extends StatefulWidget {
  const ActivityVisionWidget({Key? key}) : super(key: key);

  @override
  _ActivityVisionWidgetState createState() => _ActivityVisionWidgetState();
}

class _ActivityVisionWidgetState extends State<ActivityVisionWidget> {
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
                        decoration: BoxDecoration(),
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
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFF27FF42),
                                  ),
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
                        child: (_userImage == null)? Image.network('https://picsum.photos/seed/858/600',):Image.file( _userImage!,

                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,

                        ),
                        
                      ),
                      Text(
                        '\"서비스명\" 은 나의 자세가 어떠한지 비전\n기술을 총해 분석하는 서비스입니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color:Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    child: Text("측정 시작",
                    style: TextStyle(
                      color:Colors.black,
                    ),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ActivityVision2Widget()
                      ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:const Size(200, 50),
                        backgroundColor: Color(0xFFB0FFA3),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
