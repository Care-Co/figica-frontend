import 'package:fisica/index.dart';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';

import 'package:fisica/index.dart';
import 'package:fisica/scan/Foot_Controller.dart';
import 'package:flutter/material.dart';

class Avata extends StatefulWidget {
  const Avata({Key? key}) : super(key: key);

  @override
  _AvataState createState() => _AvataState();
}

class _AvataState extends State<Avata> {
  var data;
  String type = '';
  String typeavt = '';
  bool typeok = false;
  bool isLoading = true;
  var footData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final now = DateTime.now();
    try {
      await footDataClass.getfoothistory('${now.year}', '${now.month}').then((value) async {
        footData = await DataController.getfoothistory();
        footDataClass.sortData(footData);
        print(footData.toString());
      });

      setState(() {
        data = footData.first;
        settype(data.classType);
        isLoading = false;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 460,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            child: Container(
              height: 460,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/footsheet.png',
              ),
            ),
          ),
          if (typeok)
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 460,
                  width: MediaQuery.of(context).size.width,
                  child: ModelViewer(
                    backgroundColor: Colors.transparent,
                    src: typeavt,
                    alt: 'A 3D model of an astronaut',
                    autoRotate: false,
                    cameraControls: true,
                    disableZoom: true,
                    cameraOrbit: "30deg 90deg auto",
                    minCameraOrbit: "auto 90deg auto",
                    maxCameraOrbit: "auto 90deg auto",
                  ),
                ),
              ),
            ),
          if (!typeok)
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  height: 460,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/noavt.png',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void settype(var typeint) {
    switch (typeint) {
      case 0:
        type = '정상발';
        typeavt = 'assets/body3d/Avata.glb';
        typeok = true;
        break;
      case 1:
        type = '요족';
        typeavt = '';
        typeok = false;

        break;
      case 2:
        type = '평발';
        typeavt = '';
        typeok = false;

        break;
      case 3:
        type = '척추 전만증';
        typeavt = 'assets/body3d/Avata_front.glb';
        typeok = true;

        break;
      case 4:
        type = '척추 후만증';
        typeavt = 'assets/body3d/Avata_back.glb';
        typeok = true;

        break;
      case 5:
        type = '척추 좌 측만증';
        typeavt = 'assets/body3d/Avata_left.glb';
        typeok = true;

        break;
      case 6:
        type = '척추 우 측만증';
        typeavt = 'assets/body3d/Avata_right.glb';
        typeok = true;

        break;
      case 7:
        type = '골반 비틀림';
        typeavt = 'assets/body3d/Avata_roll.glb';
        typeok = true;
        break;
      case 8:
        type = '골반 비틀림';
        typeavt = 'assets/body3d/Avata_roll.glb';
        typeok = true;
        break;
      default:
        type = '알 수 없는 상태';
        typeavt = '';
        typeok = false;
    }
  }
}
