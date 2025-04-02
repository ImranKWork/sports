import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

late Size screenSize;
double defaultScreenWidth = 390.0;
double defaultScreenHeight = 844.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class Constant {
  /*Padding & Margin Constants*/
  static double size0_45 = 0.45;
  static double size0_5 = 0.5;
  static double size1 = 1.0;
  static double size1_5 = 1.5;
  static double size1_6 = 1.6;
  static double size2 = 2.0;
  static double size3 = 3.0;
  static double size4 = 4.0;
  static double size5 = 5.0;
  static double size6 = 6.0;
  static double size7 = 7.0;
  static double size8 = 8.0;
  static double size9 = 9.0;
  static double size10 = 10.0;
  static double size12 = 12.0;
  static double size13 = 13.0;
  static double size14 = 14.0;
  static double size15 = 15.0;
  static double size16 = 16.0;
  static double size17 = 17.0;
  static double size18 = 18.0;
  static double size20 = 20.0;
  static double size22 = 22.0;
  static double size21 = 21.0;
  static double size23 = 23.0;
  static double size24 = 24.0;
  static double size25 = 25.0;
  static double size26 = 26.0;
  static double size28 = 28.0;
  static double size29 = 29.0;
  static double size30 = 30.0;
  static double size31 = 31.0;
  static double size32 = 32.0;
  static double size33 = 33.0;
  static double size34 = 34.0;
  static double size35 = 35.0;
  static double size36 = 36.0;
  static double size38 = 38.0;
  static double size40 = 40.0;
  static double size42 = 42.0;
  static double size44 = 44.0;
  static double size46 = 46.0;
  static double size48 = 48.0;
  static double size50 = 50.0;
  static double size52 = 52.0;
  static double size56 = 56.0;
  static double size58 = 58.0;
  static double size60 = 60.0;
  static double size62 = 60.0;
  static double size64 = 64.0;
  static double size66 = 66.0;
  static double size68 = 68.0;
  static double size70 = 70.0;
  static double size72 = 72.0;
  static double size74 = 74.0;
  static double size76 = 76.0;
  static double size75 = 75.0;
  static double size77 = 77.0;
  static double size78 = 78.0;
  static double size80 = 80.0;
  static double size82 = 82.0;
  static double size88 = 88.0;
  static double size90 = 90.0;
  static double size96 = 96.0;
  static double size100 = 100.0;
  static double size105 = 105.0;
  static double size110 = 110.0;
  static double size115 = 115.0;
  static double size120 = 120.0;
  static double size130 = 130.0;
  static double size140 = 140.0;
  static double size150 = 150.0;
  static double size160 = 160.0;
  static double size170 = 170.0;
  static double size180 = 180.0;
  static double size185 = 185.0;
  static double size190 = 195.0;
  static double size200 = 200.0;
  static double size210 = 210.0;
  static double size220 = 220.0;
  static double size230 = 230.0;
  static double size240 = 240.0;
  static double size250 = 250.0;
  static double size260 = 260.0;
  static double size270 = 275.0;
  static double size280 = 280.0;
  static double size290 = 290.0;
  static double size300 = 300.0;
  static double size310 = 310.0;
  static double size320 = 320.0;
  static double size330 = 330.0;
  static double size340 = 340.0;
  static double size350 = 350.0;
  static double size400 = 400.0;
  static double size450 = 450.0;
  static double size500 = 500.0;
  static double size600 = 600.0;
  static double size700 = 700.0;
  static double size900 = 900.0;
  static double size1000 = 1000.0;
  static double size1200 = 1200.0;
  static double size1300 = 1300.0;
  static double size1400 = 1400.0;
  static double size1500 = 1500.0;
  static double size1024 = 1024.0;
  static double size2000 = 2000.0;
  static double size3000 = 3000.0;
  static double size5000 = 5000.0;
  static double size6000 = 6000.0;
  static double size7000 = 7000.0;
  static double size8000 = 8000.0;
  static double size9000 = 9000.0;
  static double size10000 = 10000.0;

  /*Screen Size dependent Constants*/

  static double screenWidthButton = screenWidth - size64;
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double defaultImageHeight = 120.0;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;

  /*Default Height&Width*/
  static double defaultIndicatorHeight = 5.0;
  static double defaultIndicatorWidth = screenWidthFourth;

  static void setDefaultSize(context) {
    screenSize = Get.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    size24 = 20.0;
    size32 = 30.0;
    size44 = 40.0;
    size56 = 50.0;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;

    defaultIconSize = 80.0;
    defaultImageHeight = 120.0;
    snackBarHeight = 50.0;
    texIconSize = 30.0;

    defaultIndicatorHeight = 5.0;
    defaultIndicatorWidth = screenWidthFourth;

    FontSize.setDefaultFontSize();
  }

  static void setScreenAwareConstant(context, {num? screenHeight, num? screenWidth}) {
    setDefaultSize(context);

    ScreenUtil.init(
      context,
    );

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/
    size0_5 = ScreenUtil().setWidth(0.5).toDouble();
    size1 = ScreenUtil().setWidth(1.0).toDouble();
    size1_5 = ScreenUtil().setWidth(1.5).toDouble();
    size1_6 = ScreenUtil().setWidth(1.6).toDouble();
    size3 = ScreenUtil().setWidth(3.0).toDouble();
    size2 = ScreenUtil().setWidth(2.0).toDouble();
    size4 = ScreenUtil().setWidth(4.0).toDouble();
    size5 = ScreenUtil().setWidth(5.0).toDouble();
    size6 = ScreenUtil().setWidth(6.0).toDouble();
    size7 = ScreenUtil().setWidth(7.0).toDouble();
    size8 = ScreenUtil().setWidth(8.0).toDouble();
    size9 = ScreenUtil().setWidth(9.0).toDouble();
    size10 = ScreenUtil().setWidth(10.0).toDouble();
    size12 = ScreenUtil().setWidth(12.0).toDouble();
    size13 = ScreenUtil().setWidth(13.0).toDouble();
    size14 = ScreenUtil().setWidth(14.0).toDouble();
    size15 = ScreenUtil().setWidth(15.0).toDouble();
    size16 = ScreenUtil().setWidth(16.0).toDouble();
    size17 = ScreenUtil().setWidth(17.0).toDouble();
    size18 = ScreenUtil().setWidth(18.0).toDouble();
    size20 = ScreenUtil().setWidth(20.0).toDouble();
    size22 = ScreenUtil().setWidth(22.0).toDouble();
    size23 = ScreenUtil().setWidth(23.0).toDouble();
    size24 = ScreenUtil().setWidth(24.0).toDouble();
    size25 = ScreenUtil().setWidth(25.0).toDouble();
    size26 = ScreenUtil().setWidth(26.0).toDouble();
    size28 = ScreenUtil().setWidth(28.0).toDouble();
    size29 = ScreenUtil().setWidth(29.0).toDouble();
    size30 = ScreenUtil().setWidth(30.0).toDouble();
    size31 = ScreenUtil().setWidth(31.0).toDouble();
    size32 = ScreenUtil().setWidth(32.0).toDouble();
    size34 = ScreenUtil().setWidth(34.0).toDouble();
    size40 = ScreenUtil().setWidth(40.0).toDouble();
    size35 = ScreenUtil().setWidth(35.0).toDouble();
    size36 = ScreenUtil().setWidth(36.0).toDouble();
    size38 = ScreenUtil().setWidth(38.0).toDouble();
    size40 = ScreenUtil().setWidth(40.0).toDouble();
    size42 = ScreenUtil().setWidth(42.0).toDouble();
    size44 = ScreenUtil().setWidth(44.0).toDouble();
    size50 = ScreenUtil().setWidth(50.0).toDouble();
    size48 = ScreenUtil().setWidth(48.0).toDouble();
    size52 = ScreenUtil().setWidth(52.0).toDouble();
    size56 = ScreenUtil().setWidth(56.0).toDouble();
    size58 = ScreenUtil().setWidth(58.0).toDouble();
    size60 = ScreenUtil().setWidth(60.0).toDouble();
    size62 = ScreenUtil().setWidth(62.0).toDouble();
    size64 = ScreenUtil().setWidth(64.0).toDouble();
    size66 = ScreenUtil().setWidth(66.0).toDouble();
    size72 = ScreenUtil().setWidth(72.0).toDouble();
    size74 = ScreenUtil().setWidth(74.0).toDouble();
    size76 = ScreenUtil().setWidth(76.0).toDouble();
    size75 = ScreenUtil().setWidth(75.0).toDouble();
    size77 = ScreenUtil().setWidth(77.0).toDouble();
    size80 = ScreenUtil().setWidth(80.0).toDouble();
    size82 = ScreenUtil().setWidth(82.0).toDouble();
    size88 = ScreenUtil().setWidth(88.0).toDouble();
    size100 = ScreenUtil().setWidth(100.0).toDouble();
    size105 = ScreenUtil().setWidth(105.0).toDouble();
    size110 = ScreenUtil().setWidth(110.0).toDouble();
    size115 = ScreenUtil().setWidth(115.0).toDouble();
    size120 = ScreenUtil().setWidth(120.0).toDouble();
    size130 = ScreenUtil().setWidth(130.0).toDouble();
    size140 = ScreenUtil().setWidth(140.0).toDouble();
    size150 = ScreenUtil().setWidth(150.0).toDouble();
    size160 = ScreenUtil().setWidth(160.0).toDouble();
    size180 = ScreenUtil().setWidth(180.0).toDouble();
    size185 = ScreenUtil().setWidth(185.0).toDouble();
    size190 = ScreenUtil().setWidth(195.0).toDouble();
    size200 = ScreenUtil().setWidth(200.0).toDouble();
    size210 = ScreenUtil().setWidth(210.0).toDouble();
    size220 = ScreenUtil().setWidth(220.0).toDouble();
    size230 = ScreenUtil().setWidth(230.0).toDouble();
    size240 = ScreenUtil().setWidth(240.0).toDouble();
    size250 = ScreenUtil().setWidth(250.0).toDouble();
    size260 = ScreenUtil().setWidth(260.0).toDouble();
    size270 = ScreenUtil().setWidth(275.0).toDouble();
    size280 = ScreenUtil().setWidth(280.0).toDouble();
    size290 = ScreenUtil().setWidth(290.0).toDouble();
    size300 = ScreenUtil().setWidth(300.0).toDouble();
    size310 = ScreenUtil().setWidth(310.0).toDouble();
    size320 = ScreenUtil().setWidth(320.0).toDouble();
    size330 = ScreenUtil().setWidth(330.0).toDouble();
    size340 = ScreenUtil().setWidth(340.0).toDouble();
    size350 = ScreenUtil().setWidth(350.0).toDouble();
    size400 = ScreenUtil().setWidth(400.0).toDouble();
    size450 = ScreenUtil().setWidth(450.0).toDouble();
    size500 = ScreenUtil().setWidth(500.0).toDouble();
    size600 = ScreenUtil().setWidth(600.0).toDouble();
    size1000 = ScreenUtil().setWidth(1000.0).toDouble();
    size1024 = ScreenUtil().setWidth(1024.0).toDouble();
    size2000 = ScreenUtil().setWidth(1024.0).toDouble();
    size3000 = ScreenUtil().setWidth(1024.0).toDouble();
    size5000 = ScreenUtil().setWidth(1024.0).toDouble();
    size6000 = ScreenUtil().setWidth(1024.0).toDouble();
    size7000 = ScreenUtil().setWidth(1024.0).toDouble();
    size8000 = ScreenUtil().setWidth(1024.0).toDouble();
    size9000 = ScreenUtil().setWidth(1024.0).toDouble();
    size10000 = ScreenUtil().setWidth(1024.0).toDouble();


    /*Screen Size dependent Constants*/
    screenWidthHalf = ScreenUtil().scaleWidth / 2;
    screenWidthThird = ScreenUtil().scaleWidth / 3;
    screenWidthFourth = ScreenUtil().scaleWidth / 4;
    screenWidthFifth = ScreenUtil().scaleWidth / 5;
    screenWidthSixth = ScreenUtil().scaleWidth / 6;
    screenWidthTenth = ScreenUtil().scaleWidth / 10;

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil().setWidth(80.0).toDouble();
    defaultImageHeight = ScreenUtil().setHeight(120.0).toDouble();
    snackBarHeight = ScreenUtil().setHeight(50.0).toDouble();
    texIconSize = ScreenUtil().setWidth(30.0).toDouble();

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil().setHeight(5.0).toDouble();
    defaultIndicatorWidth = screenWidthFourth;
  }
}

class FontSize {
  static double s8 = 8.0;
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s24 = 24.0;
  static double s26 = 26.0;
  static double s28 = 28.0;
  static double s30 = 30.0;
  static double s32 = 32.0;
  static double s36 = 36.0;
  static double s40 = 40.0;
  static double s42 = 42.0;
  static double s48 = 48.0;
  static double s190 = 190.0;

  static setDefaultFontSize() {
    s9 = 9.0;
    s10 = 10.0;
    s12 = 12.0;
    s13 = 13.0;
    s14 = 14.0;
    s15 = 15.0;
    s16 = 16.0;
    s17 = 17.0;
    s18 = 18.0;
    s20 = 20.0;
    s22 = 22.0;
    s24 = 24.0;
    s26 = 26.0;
    s28 = 28.0;
    s30 = 30.0;
    s32 = 32.0;
    s36 = 36.0;
    s40 = 40.0;
    s42 = 42.0;
    s48 = 48.0;
    s190 = 190.0;
  }

  static setScreenAwareFontSize() {
    s8 = ScreenUtil().setSp(8.0).toDouble();
    s9 = ScreenUtil().setSp(9.0).toDouble();
    s10 = ScreenUtil().setSp(10.0).toDouble();
    s12 = ScreenUtil().setSp(12.0).toDouble();
    s13 = ScreenUtil().setSp(13.0).toDouble();
    s14 = ScreenUtil().setSp(14.0).toDouble();
    s15 = ScreenUtil().setSp(15.0).toDouble();
    s16 = ScreenUtil().setSp(16.0).toDouble();
    s17 = ScreenUtil().setSp(17.0).toDouble();
    s18 = ScreenUtil().setSp(18.0).toDouble();
    s20 = ScreenUtil().setSp(20.0).toDouble();
    s22 = ScreenUtil().setSp(22.0).toDouble();
    s24 = ScreenUtil().setSp(24.0).toDouble();
    s26 = ScreenUtil().setSp(26.0).toDouble();
    s28 = ScreenUtil().setSp(28.0).toDouble();
    s30 = ScreenUtil().setSp(30.0).toDouble();
    s32 = ScreenUtil().setSp(32.0).toDouble();
    s36 = ScreenUtil().setSp(36.0).toDouble();
    s40 = ScreenUtil().setSp(40.0).toDouble();
    s42 = ScreenUtil().setSp(42.0).toDouble();
    s48 = ScreenUtil().setSp(48.0).toDouble();
  }
}
