import 'package:flutter/material.dart';
import '/index.dart';

class Homeinfo extends StatefulWidget {
  const Homeinfo({Key? key}) : super(key: key);

  @override
  State<Homeinfo> createState() => _HomeinfoState();
}

class _HomeinfoState extends State<Homeinfo> {
  var data;
  Future? _loadDataFuture;

  Future<void> getData() async {
    print('홈 정보 데이터 가져오기');
    data = await UserController.getuserinfo();
    print(data);
  }

  @override
  void initState() {
    super.initState();
    _loadDataFuture = getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fu() {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    //fu();
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: _loadDataFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("데이터 로딩 중 에러 발생"));
              } else {
                return Container(
                    width: 232,
                    height: 88,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFCFDFF).withOpacity(0.20),
                          Color(0xFFFCFDFF).withOpacity(0.04),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0x33FBFCFF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0xB2121212),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      SetLocalizations.of(context).getText('goa2jpgy'),
                                      style: AppFont.s12.overrides(color: AppColors.Gray300),
                                    ),
                                    Text(
                                      data['height'].toString() + 'cm',
                                      style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      SetLocalizations.of(context).getText('5gfls12l'),
                                      style: AppFont.s12.overrides(color: AppColors.Gray300),
                                    ),
                                    Text(
                                      data['weight'].toString() + 'kg',
                                      style: AppFont.s18.overrides(color: AppColors.primaryBackground),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
            },
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
