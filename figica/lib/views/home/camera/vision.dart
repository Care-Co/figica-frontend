import 'package:fisica/index.dart';
import 'package:fisica/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:retrofit/dio.dart';

class VisionScan extends StatefulWidget {
  final String mode;
  const VisionScan({Key? key, required this.mode}) : super(key: key);

  @override
  _VisionScanState createState() => _VisionScanState();
}

class _VisionScanState extends State<VisionScan> {
  final ImagePicker _picker = ImagePicker();
  File? _frontImage;
  File? _backImage;
  File? _leftImage;
  File? _rightImage;

  Future<File> _compressImage(File file) async {
    final img.Image? image = img.decodeImage(file.readAsBytesSync());
    if (image != null) {
      final img.Image resizedImage = img.copyResize(image, width: 800); // 가로 크기를 800으로 조정
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = path.join(tempDir.path, 'compressed_${path.basename(file.path)}');
      final File compressedFile = File(filePath)..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85)); // 품질을 85로 설정하여 압축

      print('Original file size: ${file.lengthSync()} bytes');
      print('Compressed file size: ${compressedFile.lengthSync()} bytes');

      return compressedFile;
    } else {
      return file;
    }
  }

  Future<void> _captureImage(String side) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File tempFile = File(pickedFile.path);
      final File compressedFile = await _compressImage(tempFile);
      setState(() {
        if (side == 'front') {
          _frontImage = compressedFile;
        } else if (side == 'back') {
          _backImage = compressedFile;
        } else if (side == 'left') {
          _leftImage = compressedFile;
        } else if (side == 'right') {
          _rightImage = compressedFile;
        }
      });
    }
  }

  void _removeImage(String side) {
    setState(() {
      if (side == 'front') {
        _frontImage = null;
      } else if (side == 'back') {
        _backImage = null;
      } else if (side == 'left') {
        _leftImage = null;
      } else if (side == 'right') {
        _rightImage = null;
      }
    });
  }

  Future<void> _uploadImages() async {
    String linkurl = mainurl;
    final String? token = await AppStateNotifier.instance.getAccessToken();

    String? uid = AppStateNotifier.instance.userdata?.uid;
    String? testuid = AppStateNotifier.instance.testuid;

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$linkurl/users/$uid/pose-estimation'),
    );

    request.headers.addAll(headers);
    print(request);
    print(request.headers);

    request.files.add(await http.MultipartFile.fromPath(
      'file1',
      _frontImage!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'file2',
      _backImage!.path,
    ));
    print(_frontImage!.path);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Upload successful');
        print(await response.stream.bytesToString());
//TODOdi
        showCustomDialog(
          context: context,
          backGroundtype: 'black',
          checkButtonColor: AppColors.red,
          titleText: SetLocalizations.of(context).getText('tkwlsgkdk'),
          descriptionText: SetLocalizations.of(context).getText('rlekfu',
              values: {'name': "${AppStateNotifier.instance.userdata!.firstName} ${AppStateNotifier.instance.userdata!.lastName}"}),
          upperButtonText: SetLocalizations.of(context).getText('popupDecideDeleteReportPlantarPressureAllButtonConfirmLabel'),
          upperButtonFunction: () async {
            context.pushNamed('home');
          },
          /* 이전으로 돌아가기 */
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Upload failed with error: $e');
    }
  }

  Future<void> _uploadtestImages() async {
    print('_uploadtestImages');
    String linkurl = mainurl;
    String? testuid = AppStateNotifier.instance.testuid;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$linkurl/test/users/$testuid/pose-estimation'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _frontImage!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _backImage!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _leftImage!.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _rightImage!.path,
    ));

    try {
      loggerNoStack.t({
        'Name': '_uploadtestImages',
        'url': request,
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Upload successful');
        print(await response.stream.bytesToString());
        AppStateNotifier.instance.cam2Up();
        context.goNamed('Tester_menu');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Upload failed with error: $e');
    }
  }

  Widget _buildImagePreview(File? image, String side) {
    return Stack(
      children: [
        Image.file(image!),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () => _removeImage(side),
          ),
        ),
      ],
    );
  }

  Widget _buildCaptureButton(String label, String side, File? image) {
    return Expanded(
      child: Container(
          width: 150,
          height: 86.0,
          child: LodingButtonWidget(
            onPressed: () => _captureImage(side),
            text: label,
            options: LodingButtonOptions(
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: AppColors.Gray700,
              textStyle: AppFont.s18.overrides(
                fontSize: 16,
                color: image == null ? AppColors.primaryBackground : AppColors.Gray500,
              ),
              elevation: 0,
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Black,
      appBar: AppBar(
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.primaryBackground,
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        backgroundColor: AppColors.Black,
        title: Text(
          '사진 업로드 하기',
          style: AppFont.s18.overrides(color: AppColors.primaryBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCaptureButton('전면', 'front', _frontImage),
                SizedBox(width: 20),
                _buildCaptureButton('후면', 'back', _backImage),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCaptureButton('왼쪽 측면', 'left', _leftImage),
                SizedBox(width: 20),
                _buildCaptureButton('오른쪽 측면', 'right', _rightImage),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('이미지 확인', style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  _frontImage != null ? _buildImagePreview(_frontImage, 'front') : Container(),
                  _backImage != null ? _buildImagePreview(_backImage, 'back') : Container(),
                  _leftImage != null ? _buildImagePreview(_leftImage, 'left') : Container(),
                  _rightImage != null ? _buildImagePreview(_rightImage, 'right') : Container(),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: 56.0,
                child: LodingButtonWidget(
                  onPressed: (_frontImage != null && _backImage != null && _leftImage != null && _rightImage != null)
                      ? (widget.mode == 'main')
                          ? _uploadImages
                          : _uploadtestImages
                      : null,
                  text: '이미지 업로드',
                  options: LodingButtonOptions(
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: (_frontImage != null && _backImage != null && _leftImage != null && _rightImage != null)
                        ? AppColors.primaryBackground
                        : AppColors.Gray700,
                    textStyle: AppFont.s18.overrides(
                      fontSize: 16,
                      color: (_frontImage != null && _backImage != null && _leftImage != null && _rightImage != null)
                          ? AppColors.Black
                          : AppColors.Gray500,
                    ),
                    elevation: 0,
                    borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
