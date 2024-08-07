import 'package:fisica/utils/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class SetLocalizations {
  SetLocalizations(this.locale);

  final Locale locale;

  static SetLocalizations of(BuildContext context) => Localizations.of<SetLocalizations>(context, SetLocalizations)!;

  static List<String> languages() => ['ko', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) => _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String _replacePlaceholders(String text, Map<String, String> values) {
    values.forEach((key, value) {
      text = text.replaceAll('{$key}', value);
    });
    return text;
  }

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode) ? languages().indexOf(languageCode) : 0;
  String getText(String key, {Map<String, String>? values}) {
    String text = (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';
    if (values != null && values.isNotEmpty) {
      text = _replacePlaceholders(text, values);
    }
    return text;
  }
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

final TranslationsMap = <Map<String, Map<String, String>>>[
  {
    'ze1u6oze': {
      'ko': '확인',
      'en': '',
      'ja': '',
    },
    'ze1uteze': {
      'ko': '그룹',
      'en': '',
      'ja': '',
    },
    'rnmfqndlg': {
      'ko': '그룹 히스토리',
      'en': '',
      'ja': '',
    },
    'ckadue1uteze': {
      'ko': '참여하고 있는 그룹이 없네요!',
      'en': '',
      'ja': '',
    },
    'ckadurmfnqteze': {
      'ko': '그룹을 생성하여 우리 가족, 회원을 관리하거나, 이미 생성되어 있는 그룹에 들어가 건강 정보를 공유할 수 있어요.',
      'en': '',
      'ja': '',
    },
    'rmfnqtodtjd': {
      'ko': '그룹 생성하기',
      'en': '',
      'ja': '',
    },
    'rmfnqdlfma': {
      'ko': '그룹 이름을 입력해주세요',
      'en': '',
      'ja': '',
    },
    'rmfnqdhksfy': {
      'ko': '초대 코드를 이용해\n새로운 멤버를 초대하세요',
      'en': '',
      'ja': '',
    },
    'tofhqkfrmf': {
      'ko': '유효 기간이',
      'en': '',
      'ja': '',
    },
    'frmf': {
      'ko': '시간 남았습니다.',
      'en': '',
      'ja': '',
    },
    'xhemcnlth': {
      'ko': '초대 코드 취소하기',
      'en': '',
      'ja': '',
    },
    'xhemtl': {
      'ko': '초대 코드 취소',
      'en': '',
      'ja': '',
    },
    'tjksodif': {
      'ko': '초대 코드를 취소하면\n그룹에 멤버를 초대할 수 없습니다.\n초대 코드를 취소할까요?',
      'en': '',
      'ja': '',
    },
    'rmfnqt': {
      'ko': '그룹 생성 완료',
      'en': '',
      'ja': '',
    },
    'cheo': {
      'ko': '초대코드',
      'en': '',
      'ja': '',
    },
    'rmfnqghq': {
      'ko': '그룹 홈으로 이동하기',
      'en': '',
      'ja': '',
    },
    'rmfnqckadu': {
      'ko': '그룹 참여 신청하기',
      'en': '',
      'ja': '',
    },
    'cheozhemdlqfur': {
      'ko': '초대 코드를 입력해주세요',
      'en': '',
      'ja': '',
    },
    'rmfqnckqrl': {
      'ko': '그룹 찾기',
      'en': '',
      'ja': '',
    },
    '바로공유': {
      'ko': '바로 공유하기',
      'en': '',
      'ja': '',
    },
    'mglc61fj': {
      'ko': '회원 정보 입력',
      'en': '',
      'ja': '',
    },
    'mglttt': {
      'ko': '원활한 서비스 이용을 위해 회원 정보를 입력해 주세요',
      'en': '',
      'ja': '',
    },
    'ty7h9c9n': {
      'ko': '성',
      'en': '',
      'ja': '',
    },
    'p9l0jbdf': {
      'ko': '이름',
      'en': '',
      'ja': '',
    },
    'cho9jtn4': {
      'ko': '생년월일',
      'en': '',
      'ja': '',
    },
    'rmfnt': {
      'ko': '그룹 성정',
      'en': '',
      'ja': '',
    },
    'tjdquf': {
      'ko': '성별',
      'en': '',
      'ja': '',
    },
    'b6pt2wpc': {
      'ko': '남성',
      'en': '',
      'ja': '',
    },
    'wyai5zsz': {
      'ko': '여성',
      'en': '',
      'ja': '',
    },
    'dqi4qlg7': {
      'ko': '신장(키)',
      'en': '',
      'ja': '',
    },
    'a45ghbyh': {
      'ko': '체중(몸무게)',
      'en': '',
      'ja': '',
    },
    'rnrrk': {
      'ko': '국가',
      'en': '',
      'ja': '',
    },
    'mht88zbc': {
      'ko': '완료',
      'en': '',
      'ja': '',
    },
    'ghldnjrk': {
      'ko': '회원 가입을 취소할까요?',
      'en': '',
      'ja': '',
    },
    'cjtghkaus': {
      'ko': '회원 가입을 취소하고\n첫 화면으로 돌아갑니다',
      'en': '',
      'ja': '',
    },
    'cnlthgkrl': {
      'ko': '회원 가입 취소하기',
      'en': '',
      'ja': '',
    },
    'rPthrwkrtjd': {
      'ko': '계속 작성하기',
      'en': '',
      'ja': '',
    },
    'cheozhemdhfb': {
      'ko': '초대 코드 오류',
      'en': '',
      'ja': '',
    },
    'ckwdmftndjqtdm': {
      'ko': '해당 초대코드를 가진 그룹을\n찾을 수 없습니다',
      'en': '',
      'ja': '',
    },
    'ghadmfhdlehd': {
      'ko': '홈으로 이동하기',
      'en': '',
      'ja': '',
    },
    'ektldlqfur': {
      'ko': '초대코드 다시 입력하기',
      'en': '',
      'ja': '',
    },
    'ckadutlscj': {
      'ko': '그룹 참여 신청하기',
      'en': '',
      'ja': '',
    },
    'tlvskdy': {
      'ko': '님의 그룹에\n함께하고 싶나요?',
      'en': '',
      'ja': '',
    },
    'dmlrnfnq': {
      'ko': '의 그룹',
      'en': '',
      'ja': '',
    },
    'dho': {
      'ko': '외',
      'en': '',
      'ja': '',
    },
    'auddmlao': {
      'ko': '명의 멤버',
      'en': '',
      'ja': '',
    },
    'wodlqdur': {
      'ko': '초대 코드 재입력',
      'en': '',
      'ja': '',
    },
    'tlscud': {
      'ko': '참여 신청하기',
      'en': '',
      'ja': '',
    },
    'tlscjddhksfy': {
      'ko': '참여 신청 완료',
      'en': '',
      'ja': '',
    },
    'dhksfy': {
      'ko': '의 그룹’에\n그룹 참여 신청을 전달했습니다!\n초대가 수락되면 다시 알려드릴게요',
      'en': '',
      'ja': '',
    },
    'dlalqhsoa': {
      'ko': '이미 참여 신청을 보냈네요!',
      'en': '',
      'ja': '',
    },
    'ghkrdlsanswk': {
      'ko': '그룹에 이미 그룹 참여 신청을 보냈어요.\n그룹장이 확인할 때까지 조금만 기다려 주세요!',
      'en': '',
      'ja': '',
    },
    'tlscjtndl': {
      'ko': '그룹을 생성하거나 다른 그룹에 참여하려면\n이미 보낸 참여 신청을 취소하세요',
      'en': '',
      'ja': '',
    },
    'dkssod': {
      'ko': '다른 그룹에 참여 신청을 보내려면 ‘취소하기’ 버튼을 눌러',
      'en': '',
      'ja': '',
    },
    'dafdf': {
      'ko': ' 그룹에 보낸 신청을 취소하세요.',
      'en': '',
      'ja': '',
    },
    'cnlgh': {
      'ko': '취소하기',
      'en': '',
      'ja': '',
    },
    'ngpljxdi': {
      'ko': '그룹 히스토리',
      'en': '',
      'ja': '',
    },
    'rmfnqfdlfwjd': {
      'ko': '그룹 일정',
      'en': '',
      'ja': '',
    },
    'rmfnqdk': {
      'ko': '그룹 참여 신청 관리',
      'en': '',
      'ja': '',
    },
    'tlscudrj': {
      'ko': '신청 거절',
      'en': '',
      'ja': '',
    },
    'gkalt': {
      'ko': '참여 신청 승인',
      'en': '',
      'ja': '',
    },
    'rlfhrqhrl': {
      'ko': '참여 신청 기록 보기',
      'en': '',
      'ja': '',
    },
    'tmddlseorl': {
      'ko': '승인 대기 중',
      'en': '',
      'ja': '',
    },
    'tmddlsdh': {
      'ko': '승인 완료',
      'en': '',
      'ja': '',
    },
    'rjwjd': {
      'ko': '승인 거절',
      'en': '',
      'ja': '',
    },
    'rjwjdehla': {
      'ko': '님의 참여 신청이 거절되었습니다',
      'en': '',
      'ja': '',
    },
    'tmddlsehla': {
      'ko': '님의 참여 신청이 승인되었습니다',
      'en': '',
      'ja': '',
    },
    'rmfqnekdlwjs': {
      'ko': '님이 그룹장이 되었습니다.',
      'en': '',
      'ja': '',
    },
    'doaqjqkdcnf': {
      'ko': '그룹 멤버 방출',
      'en': '',
      'ja': '',
    },
    'rmvnqkddlwjs': {
      'ko': '그룹장 이전',
      'en': '',
      'ja': '',
    },
    'tlscjrhksfl': {
      'ko': '그룹 참여 신청 관리',
      'en': '',
      'ja': '',
    },
    'aoqejrhksfl': {
      'ko': '맴버 관리',
      'en': '',
      'ja': '',
    },
    'aoqejrhkdcnf': {
      'ko': '방출하기',
      'en': '',
      'ja': '',
    },
    'rmfwnqkddlwjd': {
      'ko': '그룹장 이전 필요',
      'en': '',
      'ja': '',
    },
    'rmfnqwkdskrkrl': {
      'ko': '그룹을 나가기 위해서는 \n그룹장 이전이 필요합니다.\n그룹장을 옮기고 그룹을 나가시겠습니까?',
      'en': '',
      'ja': '',
    },
    'rmqnwkelwjskrl': {
      'ko': '그룹장 이전하기',
      'en': '',
      'ja': '',
    },
    'cnlth': {
      'ko': '취소',
      'en': '',
      'ja': '',
    },
    'qkdcnfkrl': {
      'ko': '방출하기',
      'en': '',
      'ja': '',
    },
    'aoqqjwkdcnf': {
      'ko': '멤버 방출하기',
      'en': '',
      'ja': '',
    },
    'rmfwnqkddlwjs': {
      'ko': '그룹장 이전',
      'en': '',
      'ja': '',
    },
    'rmfnqwk': {
      'ko': '그룹장 이전하기',
      'en': '',
      'ja': '',
    },
    'rmfnqaudrud': {
      'ko': '그룹명 변경',
      'en': '',
      'ja': '',
    },
    'gkfntdlTdma': {
      'ko': '그룹 이름을 변경할 수 있어요',
      'en': '',
      'ja': '',
    },
    'qusrudhgks': {
      'ko': '그룹명 변경 완료',
      'en': '',
      'ja': '',
    },
    'gktgkrf': {
      'ko': '그룹을 삭제할까요?',
      'en': '',
      'ja': '',
    },
    'rgklrkd': {
      'ko': '그룹 삭제',
      'en': '',
      'ja': '',
    },
    'tkrdpdhky': {
      'ko': '그룹 삭제 완료',
      'en': '',
      'ja': '',
    },
    'sodyd': {
      'ko': '그룹이 삭제되었습니다.\n그룹 기능을 다시 이용하려면\n새로운 그룹을 생성하거\n다른 그룹에 가입해야 해요.',
      'en': '',
      'ja': '',
    },
    'dbgud': {
      'ko': '유형',
      'en': '',
      'ja': '',
    },
    'tjsxor': {
      'ko': '선택',
      'en': '',
      'ja': '',
    },
    'elqkdltmdjqt': {
      'ko': '등록된 디바이스가 없어요!',
      'en': '',
      'ja': '',
    },
    'sodydd': {
      'ko': '디바이스를 등록하면 내 건강 정보를 담은\n디지털 트윈 아바타를 통해 건강을 관리할 수 있어요.',
      'en': '',
      'ja': '',
    },
    'eldktj': {
      'ko': '디바이스 등록하기',
      'en': '',
      'ja': '',
    },
    'elqkdltm': {
      'ko': '디바이스 등록 완료',
      'en': '',
      'ja': '',
    },
    'qksrkdk': {
      'ko': ' 이 연결되었습니다.\n반가워요!',
      'en': '',
      'ja': '',
    },
    'qmvldje': {
      'ko': 'Footprint 분석하기',
      'en': '',
      'ja': '',
    },
    'rlrldusrufhgkrdls': {
      'ko': '기기의 연결을 확인해주세요',
      'en': '',
      'ja': '',
    },
    'cmrwjdwnd': {
      'ko': '기기 위로 올라서서\n측정이 완료될 때까지 기다려 주세요',
      'en': '',
      'ja': '',
    },
    'elqkdltmdus': {
      'ko': '디바이스 연결하기',
      'en': '',
      'ja': '',
    },
    'whrwjdjkq': {
      'ko': '족저압 측정하기',
      'en': '',
      'ja': '',
    },
    'qlwjsqnsjr': {
      'ko': 'Vision 분석하기',
      'en': '',
      'ja': '',
    },
    'xcmrjdju': {
      'ko': 'Footprint 측정결과',
      'en': '',
      'ja': '',
    },
    'qkfw': {
      'ko': '다음과 같은 부위에\n통증이 느껴질 수 있어요',
      'en': '',
      'ja': '',
    },
    'vmfhvlfv': {
      'ko': '프로필 편집',
      'en': '',
      'ja': '',
    },
    'dkqkxk': {
      'ko': '아바타 보기',
      'en': '',
      'ja': '',
    },
    'tnwjd': {
      'ko': '수정',
      'en': '',
      'ja': '',
    },
    'vmfhvlfvuswl': {
      'ko': '프로필 편집을 중단하고\n화면을 나가겠습니까?',
      'en': '',
      'ja': '',
    },
    'dhksfydhksy': {
      'ko': '수정 내용을 저장하려면\n수정 완료 버튼을 눌러주세요',
      'en': '',
      'ja': '',
    },
    'ttnwjddhks': {
      'ko': '수정 완료',
      'en': '',
      'ja': '',
    },
    'vuswlqskrlrl': {
      'ko': '프로필 편집 나가기',
      'en': '',
      'ja': '',
    },
    'sodkqkxk': {
      'ko': '내 아바타',
      'en': '',
      'ja': '',
    },
    'rjsrkdwjdqh': {
      'ko': '건강 정보',
      'en': '',
      'ja': '',
    },
    'rpwjddktn': {
      'ko': '계정 로그아웃',
      'en': '',
      'ja': '',
    },
    'dkffkashsh': {
      'ko': '지금 로그아웃하면 이 디바이스에서\n알림을 받을 수 없어요',
      'en': '',
      'ja': '',
    },
    'xkfxhl': {
      'ko': '서비스 탈퇴',
      'en': '',
      'ja': '',
    },
    'dldydahtgo': {
      'ko': '지금 서비스를 \nFisica에서 제공하는 서비스를\n더 이상 이용할 수 없어요',
      'en': '',
      'ja': '',
    },
    'fhdnrkdtn': {
      'ko': '로그아웃 완료',
      'en': '',
      'ja': '',
    },
    'ektlgodkf': {
      'ko': '로그아웃이 완료되었습니다.\n서비스를 이용하려면 다시 로그인해 주세요',
      'en': '',
      'ja': '',
    },
    'xkfehldks': {
      'ko': '서비스 탈퇴 완료',
      'en': '',
      'ja': '',
    },
    'dkssud': {
      'ko': '다시 만나길 기다릴게요!\n안녕히 가세요',
      'en': '',
      'ja': '',
    },
    'fhrmdktn': {
      'ko': '로그아웃',
      'en': '',
      'ja': '',
    },
    'xkfxhlgkrl': {
      'ko': '탈퇴하기',
      'en': '',
      'ja': '',
    },
    'cpgjahem': {
      'ko': '체험 모드',
      'en': '',
      'ja': '',
    },
    'gmrwjdg': {
      'ko': '측정 히스토리',
      'en': '',
      'ja': '',
    },
    'dmmldlfwjd': {
      'ko': '의 일정',
      'en': '',
      'ja': '',
    },
    'cmrwjdgltm': {
      'ko': '측정 히스토리',
      'en': '',
      'ja': '',
    },
    'goeidkfwk': {
      'ko': '해당 일자 선택',
      'en': '',
      'ja': '',
    },
    'tjfwjd': {
      'ko': '설정',
      'en': '',
      'ja': '',
    },
    'todakld': {
      'ko': '그룹 생성 완료',
      'en': '',
      'ja': '',
    },
    'todtjdhskyh': {
      'ko': '그룹 생성이\n완료되었습니다',
      'en': '',
      'ja': '',
    },
    'cheozhemqkfr': {
      'ko': '초대 코드를 발급해 주세요.',
      'en': '',
      'ja': '',
    },
    'dldkwlkt': {
      'ko': '초대 코드의 유효 기간은 72시간입니다.',
      'en': '',
      'ja': '',
    },
    'zhemqkfkr': {
      'ko': '초대 코드 발급',
      'en': '',
      'ja': '',
    },
    'wldjrkdcj': {
      'ko': '내 일정 추가하기',
      'en': '',
      'ja': '',
    },
    'dudgnsrmfjrmfpdy': {
      'ko': '그룹 멤버 일정 추가하기',
      'en': '',
      'ja': '',
    },
    'dngud': {
      'ko': '유형',
      'en': '',
      'ja': '',
    },
    'rmfnqskrkrl': {
      'ko': '그룹을 나갈까요?',
      'en': '',
      'ja': '',
    },
    'rmfnqs': {
      'ko': '그룹에서 나가면\n 더이상 그룹 멤버들과 함께\n건강 관리를 진행할 수 없어요.',
      'en': '',
      'ja': '',
    },
    'skrkrldhksfy': {
      'ko': '그룹 나가기 완료',
      'en': '',
      'ja': '',
    },
    'dhksfytjfaud': {
      'ko': '그룹을 나갔습니다.\n그룹 기능을 다시 이용하려면 \n새로운 그룹을 생성하거나\n다른 그룹에 가입해야 해요.',
      'en': '',
      'ja': '',
    },
    'skrkrlqjxms': {
      'ko': '그룹 나가기',
      'en': '',
      'ja': '',
    },
    'elqlkdl': {
      'ko': '디바이스 관리',
      'en': '',
      'ja': '',
    },
    'emdfhrsh': {
      'ko': '등록된 디바이스가 없습니다',
      'en': '',
      'ja': '',
    },
    'ecnrk': {
      'ko': '디바이스 추가하기',
      'en': '',
      'ja': '',
    },
    'dltkdwjrdls': {
      'ko': '이상 적인 족저압',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
      'en': '',
      'ja': '',
    },
    '': {
      'ko': '',
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
    'tlscjdwnlth': {
      'ko': '그룹 참여 신청 취소',
      'en': '',
      'ja': '',
    },
    'o84ubxz5': {
      'ko': '‘홍길동의 그룹’ 그룹에 보낸\n그룹 참여 신청을 취소할까요?',
      'en': '',
      'ja': '',
    },
    'cnlthgkrl': {
      'ko': '참여 신청 취소하기',
      'en': '',
      'ja': '',
    },
    'ehfkdrl': {
      'ko': '이전으로 돌아가기',
      'en': '',
      'ja': '',
    },
    'tlscjdtnl': {
      'ko': '참여 신청 취소',
      'en': '',
      'ja': '',
    },
    'ektlgownj': {
      'ko': '그룹 참여 신청을 취소했습니다!\n그룹 기능을 사용하려면\n그룹을 생성하거나 다른 그룹에\n다시 참여 신청을 진행해 주세요',
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
    'wowjsthd': {
      'ko': '인증번호 재전송',
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
      'ko': '이용 약관 동의(필수)',
      'en': '',
      'ja': '',
    },
    'mqd24b0b': {
      'ko': '개인정보 수집 및 이용 동의(필수)',
      'en': '',
      'ja': '',
    },
    'dlsla': {
      'ko': '광고성 정보 수신 동의(선택)',
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
    'dlaltkdydwjs': {
      'ko': '이미 사용중인 전화번호입니다',
      'en': '',
      'ja': '',
    },
    'dlaltkdydvel': {
      'ko': '이미 사용중인 E-mail 입니다',
      'en': '',
      'ja': '',
    },
    'rlwhsrowjd': {
      'ko': '기존 계정으로 로그인하거나,\n다른 전화번호 혹은 E-mail로 회원 가입을 진행해 주세요.',
      'en': '',
      'ja': '',
    },
    'fhrmdls': {
      'ko': '로그인으로 돌아가기',
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
      'ko': '비밀번호를\n입력해주세요',
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
    'souektlwjsthd': {
      'ko': '다시 전송하기',
      'en': '',
      'ja': '',
    },
    'cjdmadmfh': {
      'ko': '처음으로 돌아가기',
      'en': '',
      'ja': '',
    },
    'dlswmdfldzm': {
      'ko': '계정 E-mail로\n인증링크 전송 완료',
      'en': '',
      'ja': '',
    },
    'qhsans': {
      'ko': '비밀번호 변경을 위해 해당 계정의 \nE-mail로 인증링크를 전송하였습니다.\n본인 인증 후 비밀번호를 변경하세요!',
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
      'ko': '마이페이지',
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
