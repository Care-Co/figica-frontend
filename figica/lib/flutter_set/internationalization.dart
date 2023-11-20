import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class SetLocalizations {
  SetLocalizations(this.locale);

  final Locale locale;

  static SetLocalizations of(BuildContext context) => Localizations.of<SetLocalizations>(context, SetLocalizations)!;

  static List<String> languages() => ['ko', 'en', 'ja'];

  static late SharedPreferences _prefs;
  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) => _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode => _languagesWithShortCode.contains(locale.toString()) ? '${locale.toString()}_short' : null;
  int get languageIndex => languages().contains(languageCode) ? languages().indexOf(languageCode) : 0;

  String getText(String key) => (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? koText = '',
    String? enText = '',
    String? jaText = '',
  }) =>
      [koText, enText, jaText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class SetLocalizationsDelegate extends LocalizationsDelegate<SetLocalizations> {
  const SetLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return SetLocalizations.languages().contains(
      language.endsWith('_') ? language.substring(0, language.length - 1) : language,
    );
  }

  @override
  Future<SetLocalizations> load(Locale locale) => SynchronousFuture<SetLocalizations>(SetLocalizations(locale));

  @override
  bool shouldReload(SetLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  {
    'ze1u6oze': {
      'ko': '확인',
      'en': '',
      'ja': '',
    },
  },
  // login
  {
    'zvrvccdi': {
      'ko': '만나서 반가워요!',
      'en': '',
      'ja': '',
    },
    'yf2ziwdh': {
      'ko': '시작하기 위해서는 로그인이 필요해요',
      'en': '',
      'ja': '',
    },
    'z3hfyqtu': {
      'ko': 'Language',
      'en': '',
      'ja': '',
    },
    'cghjktxl': {
      'ko': '한국어(Korea)',
      'en': '',
      'ja': '',
    },
    'b6fc2qid': {
      'ko': '영어',
      'en': '',
      'ja': '',
    },
    'hnwpccrg': {
      'ko': '일본어',
      'en': '',
      'ja': '',
    },
    'o2i52qph': {
      'ko': '한국어',
      'en': '',
      'ja': '',
    },
    'fu1h2quh': {
      'ko': 'Search for an item...',
      'en': '',
      'ja': '',
    },
    'n7oaur8t': {
      'ko': '전화 번호 또는 E-mail',
      'en': '',
      'ja': '',
    },
    'n7oaur8tc': {
      'ko': '전화번호 또는 E-mail을 입력해 주세요',
      'en': '',
      'ja': '',
    },
    '8u5gojh7': {
      'ko': '@를 포함한 정확한 이메일을 입력해 주세요',
      'en': '',
      'ja': '',
    },
    '8u5gojhdg': {
      'ko': '010을 포함하여 숫자만 입력해 주세요',
      'en': '',
      'ja': '',
    },
    '8u5gojhte': {
      'ko': '8 - 24자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요',
      'en': '',
      'ja': '',
    },
    '8u5gojhch': {
      'ko': '비밀번호가 일치하지 않습니다.',
      'en': '',
      'ja': '',
    },
    '8u5gojh90': {
      'ko': '이메일',
      'en': '',
      'ja': '',
    },
    '20tycjvp': {
      'ko': '로그인',
      'en': '',
      'ja': '',
    },
    'f1vk38nh': {
      'ko': '회원 가입하기',
      'en': '',
      'ja': '',
    },
    'f1vk38cs': {
      'ko': '휴대폰 번호를 변경하셨나요?',
      'en': '',
      'ja': '',
    },
    'dxwzqgnf': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
    'l7iyr39a': {
      'ko': '로그인할 수 없습니다',
      'en': '',
      'ja': '',
    },
    'onxlo41w': {
      'ko': 'E - mail을 확인할 수 없습니다',
      'en': '',
      'ja': '',
    },
    'onxtso41w': {
      'ko': '비밀번호가 일치하지 않습니다',
      'en': '',
      'ja': '',
    },
    'onxlo4te': {
      'ko': '전화번호를 확인할 수 없습니다',
      'en': '',
      'ja': '',
    },
    'onxlo41thw': {
      'ko': '아직 회원이 아니라면',
      'en': '',
      'ja': '',
    },
    'onxlo4sfhw': {
      'ko': '아직 회원이 아니라면',
      'en': '',
      'ja': '',
    },
  },
  // homePage
  {
    'o84ubxz5': {
      'ko': '안녕하세요',
      'en': '',
      'ja': '',
    },
    '0kseg516': {
      'ko': 'Hello World',
      'en': '',
      'ja': '',
    },
    'goa2jpgy': {
      'ko': '신장',
      'en': '',
      'ja': '',
    },
    'jresko8m': {
      'ko': '172cm',
      'en': '',
      'ja': '',
    },
    '5gfls12l': {
      'ko': '체중',
      'en': '',
      'ja': '',
    },
    'co3mfz1a': {
      'ko': '54.6kg',
      'en': '',
      'ja': '',
    },
    'zc3l3zq2': {
      'ko': '신장',
      'en': '',
      'ja': '',
    },
    'w8hivjce': {
      'ko': '172cm',
      'en': '',
      'ja': '',
    },
    'umph7qhx': {
      'ko': '체중',
      'en': '',
      'ja': '',
    },
    'rnl8flst': {
      'ko': '54.6kg',
      'en': '',
      'ja': '',
    },
    '4a0fxxdm': {
      'ko': '일정',
      'en': '',
      'ja': '',
    },
    'dmhmhz0q': {
      'ko': '새로운 일정 추가하기',
      'en': '',
      'ja': '',
    },
    's0rjpssz': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // smscode
  {
    '71suwd6k': {
      'ko': '인증 번호 입력',
      'en': '',
      'ja': '',
    },
    '952lmtxg': {
      'ko': '인증번호',
      'en': '',
      'ja': '',
    },
    'pjwp1wbf': {
      'ko': 'Certification number',
      'en': '',
      'ja': '',
    },
    't0ydhdm1': {
      'ko': '인증하기',
      'en': '',
      'ja': '',
    },
    'qi50r9ks': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // agree_tos
  {
    'tetwnixi': {
      'ko': '환영합니다!',
      'en': '',
      'ja': '',
    },
    '3787ork1': {
      'ko': '간단한 동의 후 \n케어엔코 서비스를 시작해 보세요',
      'en': '',
      'ja': '',
    },
    'p351sf28': {
      'ko': '약관 전체 동의',
      'en': '',
      'ja': '',
    },
    '7rstmxvf': {
      'ko': '이용 약관 동의',
      'en': '',
      'ja': '',
    },
    'mqd24b0b': {
      'ko': '이용 약관 동의',
      'en': '',
      'ja': '',
    },
    'c8ovbs6n': {
      'ko': '다음',
      'en': '',
      'ja': '',
    },
    '0sekgm29': {
      'ko': '다음',
      'en': '',
      'ja': '',
    },
    'soukj6yz': {
      'ko': '약관 동의',
      'en': '',
      'ja': '',
    },
    '9r46fvj4': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // Get id
  {
    'tetwnigg': {
      'ko': '계정 생성',
      'en': '',
      'ja': '',
    },
    '3787orgg': {
      'ko': 'Fisica 아이디로 사용할\n전화번호 혹은 E-mail을\n입력해 주세요',
      'en': '',
      'ja': '',
    },
  },
  // Get pw
  {
    'tetwnipp': {
      'ko': '비밀번호 입력',
      'en': '',
      'ja': '',
    },
    '3787orpp': {
      'ko': '로그인시 사용할\n비밀번호를 입력해주세요',
      'en': '',
      'ja': '',
    },
    '3787ocsp': {
      'ko': '비밀번호 찾기',
      'en': '',
      'ja': '',
    },
    '378s7orpp': {
      'ko': '비밀번호를 입력해주세요',
      'en': '',
      'ja': '',
    },
    'c8ovbstt': {
      'ko': '등록한 E-mail을\n입력해주세요',
      'en': '',
      'ja': '',
    },
    'c8ovbtspp': {
      'ko': 'E-mail 주소로 계정을 복구해 드릴 수 있습니다',
      'en': '',
      'ja': '',
    },
    'c8ovbttp': {
      'ko': 'E-mail',
      'en': '',
      'ja': '',
    },
    'c8ovbtpop': {
      'ko': 'E-mail을 입력해 주세요',
      'en': '',
      'ja': '',
    },
    'c8ovbspp': {
      'ko': '비밀번호',
      'en': '',
      'ja': '',
    },
    '0sekgmpp': {
      'ko': 'password',
      'en': '',
      'ja': '',
    },
    'soukj6pp': {
      'ko': '비밀번호 확인',
      'en': '',
      'ja': '',
    },
    '9r46fvpp': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // config
  {
    '3giq6j9z': {
      'ko': '본인 인증',
      'en': '',
      'ja': '',
    },
    '6o2f5q14': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // mypage
  {
    'qqpwooly': {
      'ko': 'Page Title',
      'en': '',
      'ja': '',
    },
    '0v83hnie': {
      'ko': 'MY',
      'en': '',
      'ja': '',
    },
  },
  // scanpage
  {
    '60jvpwul': {
      'ko': 'Page Title',
      'en': '',
      'ja': '',
    },
    '3x7ltwpw': {
      'ko': 'scan',
      'en': '',
      'ja': '',
    },
  },
  // expfirstpage
  {
    'bpqdr9i0': {
      'ko': '만나서 반가워요!',
      'en': '',
      'ja': '',
    },
    'tod4tt70': {
      'ko': '시작하기 위해서는 로그인이 필요해요',
      'en': '',
      'ja': '',
    },
    'q3ovq7lg': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // expscan
  {
    'k3tf81k1': {
      'ko': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // uptos
  {
    '3ylfl8cm': {
      'ko': '서비스 이용약관 ',
      'en': '',
      'ja': '',
    },
    'hz0ov3hg': {
      'ko': '동의',
      'en': '',
      'ja': '',
    },
  },
  // updateplan
  {
    '3sh49o26': {
      'ko': '일정 등록',
      'en': '',
      'ja': '',
    },
    'q7ejjpr3': {
      'ko': '일정명',
      'en': '',
      'ja': '',
    },
    '2b7rgvrc': {
      'ko': '일자',
      'en': '',
      'ja': '',
    },
    '60buq621': {
      'ko': '0000/00/00',
      'en': '',
      'ja': '',
    },
    'ffhnlwqr': {
      'ko': '시간',
      'en': '',
      'ja': '',
    },
    '8vtkk94b': {
      'ko': '00:00',
      'en': '',
      'ja': '',
    },
    '5pfo4jwy': {
      'ko': '종류',
      'en': '',
      'ja': '',
    },
    'nptltwhp': {
      'ko': '약복용',
      'en': '',
      'ja': '',
    },
    'p9kbib6l': {
      'ko': '병원',
      'en': '',
      'ja': '',
    },
    '6dtzpnjv': {
      'ko': '운동',
      'en': '',
      'ja': '',
    },
    'o8wv2xug': {
      'ko': '기타',
      'en': '',
      'ja': '',
    },
    'o5h2gh4d': {
      'ko': 'Please select...',
      'en': '',
      'ja': '',
    },
    'bgmsx1l8': {
      'ko': 'Search for an item...',
      'en': '',
      'ja': '',
    },
    'm413il0l': {
      'ko': '반복',
      'en': '',
      'ja': '',
    },
    '7xjdhhsm': {
      'ko': 'Hello World',
      'en': '',
      'ja': '',
    },
    'fewew3s1': {
      'ko': '반복',
      'en': '',
      'ja': '',
    },
    'lvkkkscd': {
      'ko': 'Hello World',
      'en': '',
      'ja': '',
    },
    'rylnty1s': {
      'ko': '등록하기',
      'en': '',
      'ja': '',
    },
  },
  // weeklist
  {
    'yn2iubpu': {
      'ko': '반복없음',
      'en': '',
      'ja': '',
    },
    'kdwrdrtp': {
      'ko': '월요일 마다',
      'en': '',
      'ja': '',
    },
    'zx7gtwsj': {
      'ko': '화요일 마다',
      'en': '',
      'ja': '',
    },
    'rzdo5bn7': {
      'ko': '수요일 마다 ',
      'en': '',
      'ja': '',
    },
    'gufcw4gb': {
      'ko': '목요일 마다',
      'en': '',
      'ja': '',
    },
    'mfvqbiu1': {
      'ko': '금요일 마다',
      'en': '',
      'ja': '',
    },
    '0i4vdzkm': {
      'ko': '토요일 마다',
      'en': '',
      'ja': '',
    },
    '742mqz79': {
      'ko': '일요일 마다',
      'en': '',
      'ja': '',
    },
  },
  // editplan
  {
    '92bik326': {
      'ko': '일정 등록',
      'en': '',
      'ja': '',
    },
    'pnbrd5e7': {
      'ko': '일정명',
      'en': '',
      'ja': '',
    },
    '34sxaeik': {
      'ko': '일자',
      'en': '',
      'ja': '',
    },
    '8c3xmhn8': {
      'ko': '0000/00/00',
      'en': '',
      'ja': '',
    },
    'ovyamwcu': {
      'ko': '시간',
      'en': '',
      'ja': '',
    },
    'ulwgir5h': {
      'ko': '00:00',
      'en': '',
      'ja': '',
    },
    'ylnsjweu': {
      'ko': '종류',
      'en': '',
      'ja': '',
    },
    '3vciuik7': {
      'ko': '약복용',
      'en': '',
      'ja': '',
    },
    'nfx1h22l': {
      'ko': '병원',
      'en': '',
      'ja': '',
    },
    'nz4e3azb': {
      'ko': '운동',
      'en': '',
      'ja': '',
    },
    'djwfq2vn': {
      'ko': '기타',
      'en': '',
      'ja': '',
    },
    'bk6vyuqd': {
      'ko': 'Please select...',
      'en': '',
      'ja': '',
    },
    'yltz1q91': {
      'ko': 'Search for an item...',
      'en': '',
      'ja': '',
    },
    '330bj6j3': {
      'ko': '반복',
      'en': '',
      'ja': '',
    },
    '7dfvr1c0': {
      'ko': 'Hello World',
      'en': '',
      'ja': '',
    },
    'zw3zrbie': {
      'ko': '반복',
      'en': '',
      'ja': '',
    },
    'awqvpclp': {
      'ko': 'Hello World',
      'en': '',
      'ja': '',
    },
    '8q4dexz5': {
      'ko': '일정 삭제',
      'en': '',
      'ja': '',
    },
    '4hislfbr': {
      'ko': '수정하기',
      'en': '',
      'ja': '',
    },
  },
  // Miscellaneous
  {
    'kmnibnk6': {
      'ko': '블루투스를 허용하시겠습니까?',
      'en': '',
      'ja': '',
    },
    'a41n6yd3': {
      'ko': '카메라 사용을 허용하시겠습니까?',
      'en': '',
      'ja': '',
    },
    'mb3hrbky': {
      'ko': '사진첩 사용을 허용하시겠습니까?',
      'en': '',
      'ja': '',
    },
    'ib1eufmr': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'ff4n53bp': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'h7gs924i': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'drrlvy2t': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'cb3m65l4': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '8edzapal': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'svtbwogs': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'ol5t1r9m': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '8hskvua7': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'r6jf67rk': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'v8at5t2g': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'rb5cgs07': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'rg0o2l31': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'ump8syes': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'h0suo8qn': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'rejj2e78': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'fjj7ruat': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'j6cmfudx': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'ak26yd0w': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'qq3x0119': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'yfnpprik': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'tyj3eik4': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    'm7cizw14': {
      'ko': '',
      'en': '',
      'ja': '',
    },
  },
].reduce((a, b) => a..addAll(b));
