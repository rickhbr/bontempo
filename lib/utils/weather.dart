import 'package:bontempo/models/home_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color bagroundColor(HomeMode mode) {
  return mode == HomeMode.day ? Colors.white : Colors.black;
}

Color textColor(HomeMode mode, {bool blueNight = false}) {
  if (mode == HomeMode.day)
    return Colors.black;
  else
    return blueNight ? blue : Colors.white;
}

String parseClouds(HomeMode mode, String clouds) {
  switch (clouds) {
    case 'stormy':
      return 'Posibilidade de tempestade!';
    case 'snowing':
      return 'Posibilidade de neve!';
    case 'raining':
      return mode == HomeMode.day ? 'Dia chuvoso!' : 'Noite chuvosa!';
    case 'cloudy':
      return mode == HomeMode.day ? 'Dia nublado!' : 'Noite nublada!';
    case 'partly_cloudy':
      return mode == HomeMode.day
          ? 'Dia de sol com algumas nuvens!'
          : 'Noite com algumas nuvens!';
    default:
      return mode == HomeMode.day ? 'Dia ensolarado!' : 'Noite com céu limpo!';
  }
}

String parseBackground(HomeMode mode, String clouds) {
  switch (clouds) {
    case 'raining':
    case 'stormy':
      return 'assets/images/bg-rain${mode == HomeMode.night ? '-night' : ''}.png';
    case 'cloudy':
    case 'snowing':
      return 'assets/images/bg-cloudy${mode == HomeMode.night ? '-night' : ''}.png';
    default:
      return 'assets/images/bg${mode == HomeMode.night ? '-night' : '-day'}.png';
  }
}

SvgPicture parseIcon(HomeMode mode, String clouds) {
  if (clouds == 'raining') {
    return SvgPicture.asset(
      'assets/svg/weather-rain.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else if (clouds == 'stormy') {
    return SvgPicture.asset(
      'assets/svg/weather-storm.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else if (clouds == 'snowing') {
    return SvgPicture.asset(
      'assets/svg/weather-snow.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else if (clouds == 'cloudy') {
    return SvgPicture.asset(
      'assets/svg/weather-cloud.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else if (clouds == 'partly_cloudy') {
    return SvgPicture.asset(
      'assets/svg/weather-${mode == HomeMode.night ? 'night' : 'day'}-cloud.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else if (mode == HomeMode.night) {
    return SvgPicture.asset(
      'assets/svg/weather-night.svg',
      width: ScreenUtil().setWidth(46),
    );
  } else {
    return SvgPicture.asset(
      'assets/svg/weather-sun.svg',
      width: ScreenUtil().setWidth(46),
    );
  }
}
