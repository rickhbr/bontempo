const bool isProduction = bool.fromEnvironment('dart.vm.product');

const youtubeKey = 'AIzaSyBnlDw2lGrlqNaKVN5_4lvXq7RGDRHrodA';
const calendarKey = 'AIzaSyA2t3F9lbw9R8zcVq5UZsTWwKFFVArEuYY';

const developmentConfig = {
  'baseUrl': 'https://api.bontempo.com.br',
  'baseUrlMoodboard': 'https://moodboard.bontempo.com.br/api',
  'token': 'pYtxBhQerhDfYuIBVgijasSDLpQmnCug',
  'youtubeKey': youtubeKey,
  'calendarKey': calendarKey,
};

const productionConfig = {
  'baseUrl': 'https://api.bontempo.com.br',
  'baseUrlMoodboard': 'https://moodboard.bontempo.com.br/api',
  'token': 'pYtxBhQerhDfYuIBVgijasSDLpQmnCug',
  'youtubeKey': youtubeKey,
  'calendarKey': calendarKey,
};

final Map<String, String> environment =
    isProduction ? productionConfig : developmentConfig;
