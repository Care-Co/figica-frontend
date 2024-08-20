import 'package:fisica/index.dart';
import 'package:flutter/material.dart';

class DialogManager {
  static Future<void> showDialogByType({
    required BuildContext context,
    required String dialogType,
    required VoidCallback getupperButtonFunction,
    required VoidCallback getlowerButtonFunction,
  }) async {
    String backGroundtype;
    String titleText;
    String descriptionText;
    String upperButtonText;
    Color checkButtonColor;
    VoidCallback upperButtonFunction;
    String? lowerButtonText;
    VoidCallback? lowerButtonFunction;

    switch (dialogType) {
      //1_Landing_Screen 네트워크에러
      case 'networkError':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorNetworkLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorNetworkResponseDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupErrorNetworkButtonConfirmLabel');
        upperButtonFunction = getupperButtonFunction;

        break;
      //1_Landing_Screen 전화번호 사용중
      case 'phone':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorLoginLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorLoginPhoneDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupErrorLoginButtonSignupLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorNetworkButtonConfirmLabel');
        lowerButtonFunction = () => context.pushNamed('home');
        ;
        break;
      //1_Landing_Screen 이메일 사용중
      case 'email':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorLoginLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorLoginEmailDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupErrorLoginButtonSignupLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorLoginButtonConfirmLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;

      //1.1.2 get_id 전화번호 사용중
      case 'phonesign':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorSignupPhoneDuplicatedLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorSignupPhoneDuplicatedDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupErrorSignupPhoneDuplicatedButtonReturnLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorSignupPhoneDuplicatedButtonConfirmLabel');
        lowerButtonFunction = () => context.pushNamed('home');
        ;
        break;
      //1.1.2 get_id 이메일 사용중
      case 'emailsign':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorSignupEmailDuplicatedLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorSignupEmailDuplicatedDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupErrorSignupEmailDuplicatedButtonReturnLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorSignupEmailDuplicatedButtonConfirmLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;
      //1.1.4 회원가입 취소
      case 'userdata':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupDecideSignupLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupDecideSignupDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupDecideSignupButtonReturnLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupDecideSignupButtonContinueLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;
      //1.2.1 비밀번호 에러 5번 이내
      case 'pwfail':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupErrorLoginLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorLoginPasswordDescription');
        upperButtonText = SetLocalizations.of(context).getText('completeLoginButtonFindPasswordLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorLoginButtonConfirmLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;
      //1.2.1 비밀번호 에러 5번 초과
      case 'over':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('completeLoginButtonFindPasswordLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupErrorLoginLabel6');
        upperButtonText = SetLocalizations.of(context).getText('completeLoginButtonFindPasswordLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupErrorLoginButtonConfirmLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;
      //1.2.1 비밀번호 재설정 확인
      case 'resetPW':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('changePasswordpopuptitle');
        checkButtonColor = AppColors.primary;
        descriptionText = SetLocalizations.of(context).getText('changePasswordpopupScript');
        upperButtonText = SetLocalizations.of(context).getText('changePasswordButtonConfirmLabel');
        upperButtonFunction = getupperButtonFunction;
        break;

      //modify
      case 'modify':
        backGroundtype = 'white';
        titleText = SetLocalizations.of(context).getText('popupDecideProfileSettingLabel');
        checkButtonColor = AppColors.red;
        descriptionText = SetLocalizations.of(context).getText('popupDecideProfileSettingDescription');
        upperButtonText = SetLocalizations.of(context).getText('popupDecideProfileSettingButtonConfirmLabel');
        upperButtonFunction = getupperButtonFunction;
        lowerButtonText = SetLocalizations.of(context).getText('popupDecideProfileSettingButtonCancelLabel');
        lowerButtonFunction = getlowerButtonFunction;
        break;
      default:
        backGroundtype = 'black';
        titleText = 'Error';
        checkButtonColor = AppColors.red;
        descriptionText = 'An unknown error occurred.';
        upperButtonText = 'OK';
        upperButtonFunction = () => Navigator.of(context).pop();
        break;
    }

    // 공통적인 showCustomDialog 호출
    await showCustomDialog(
      backGroundtype: backGroundtype,
      context: context,
      checkButtonColor: checkButtonColor,
      titleText: titleText,
      descriptionText: descriptionText,
      upperButtonText: upperButtonText,
      upperButtonFunction: upperButtonFunction,
      lowerButtonText: lowerButtonText,
      lowerButtonFunction: lowerButtonFunction,
    );
  }
}
