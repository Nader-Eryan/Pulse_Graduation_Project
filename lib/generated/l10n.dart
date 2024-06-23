// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Pulse`
  String get app_name {
    return Intl.message(
      'Pulse',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Add as many meds as you want and get notified in time`
  String get onboardingText1 {
    return Intl.message(
      'Add as many meds as you want and get notified in time',
      name: 'onboardingText1',
      desc: '',
      args: [],
    );
  }

  /// `Get drug-drug interactions, if any`
  String get onboardingText2 {
    return Intl.message(
      'Get drug-drug interactions, if any',
      name: 'onboardingText2',
      desc: '',
      args: [],
    );
  }

  /// `Let’s get started!`
  String get authenticationText {
    return Intl.message(
      'Let’s get started!',
      name: 'authenticationText',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get name {
    return Intl.message(
      'Enter your Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get email {
    return Intl.message(
      'Enter your Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get password {
    return Intl.message(
      'Enter your Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get resetPassword {
    return Intl.message(
      'Forgot Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to recover your password.`
  String get forgotPasswordText {
    return Intl.message(
      'Please enter your email address to recover your password.',
      name: 'forgotPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get signInWithFacebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'signInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `I agree to`
  String get iAgreeToThe {
    return Intl.message(
      'I agree to',
      name: 'iAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get confirmName {
    return Intl.message(
      'Please enter your name',
      name: 'confirmName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get confirmEmail {
    return Intl.message(
      'Please enter your email',
      name: 'confirmEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get confirmPassword {
    return Intl.message(
      'Please enter your password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid name`
  String get validateName {
    return Intl.message(
      'Please enter a valid name',
      name: 'validateName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get validateEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'validateEmail',
      desc: '',
      args: [],
    );
  }

  /// `8+ length, 1+ (digit, lower, upper, special char)`
  String get validatePassword {
    return Intl.message(
      '8+ length, 1+ (digit, lower, upper, special char)',
      name: 'validatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Opps`
  String get failedSnackBar {
    return Intl.message(
      'Opps',
      name: 'failedSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `success!`
  String get successSnackBar {
    return Intl.message(
      'success!',
      name: 'successSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `You have to agree with our Privacy policy`
  String get agreePrivacyPolicy {
    return Intl.message(
      'You have to agree with our Privacy policy',
      name: 'agreePrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get recoverPassword {
    return Intl.message(
      'Recover password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `There was an error resetting your password.`
  String get errorResettingPassword {
    return Intl.message(
      'There was an error resetting your password.',
      name: 'errorResettingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Interactions`
  String get interactions {
    return Intl.message(
      'Interactions',
      name: 'interactions',
      desc: '',
      args: [],
    );
  }

  /// `Medication`
  String get medication {
    return Intl.message(
      'Medication',
      name: 'medication',
      desc: '',
      args: [],
    );
  }

  /// `Add New Medicine`
  String get addNewMedicine {
    return Intl.message(
      'Add New Medicine',
      name: 'addNewMedicine',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Medicine name`
  String get medicineName {
    return Intl.message(
      'Medicine name',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Extra note (optional)`
  String get extraNoteOptional {
    return Intl.message(
      'Extra note (optional)',
      name: 'extraNoteOptional',
      desc: '',
      args: [],
    );
  }

  /// `When the drug is taken`
  String get whenTheDrugIsTaken {
    return Intl.message(
      'When the drug is taken',
      name: 'whenTheDrugIsTaken',
      desc: '',
      args: [],
    );
  }

  /// `Before breakfast`
  String get beforeBreakfast {
    return Intl.message(
      'Before breakfast',
      name: 'beforeBreakfast',
      desc: '',
      args: [],
    );
  }

  /// `After breakfast`
  String get afterBreakfast {
    return Intl.message(
      'After breakfast',
      name: 'afterBreakfast',
      desc: '',
      args: [],
    );
  }

  /// `Before lunch`
  String get beforeLunch {
    return Intl.message(
      'Before lunch',
      name: 'beforeLunch',
      desc: '',
      args: [],
    );
  }

  /// `After lunch`
  String get afterLunch {
    return Intl.message(
      'After lunch',
      name: 'afterLunch',
      desc: '',
      args: [],
    );
  }

  /// `Before dinner`
  String get beforeDinner {
    return Intl.message(
      'Before dinner',
      name: 'beforeDinner',
      desc: '',
      args: [],
    );
  }

  /// `After dinner`
  String get afterDinner {
    return Intl.message(
      'After dinner',
      name: 'afterDinner',
      desc: '',
      args: [],
    );
  }

  /// `Add Medication`
  String get addMedication {
    return Intl.message(
      'Add Medication',
      name: 'addMedication',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get failure {
    return Intl.message(
      'Failure',
      name: 'failure',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you filled all the needed fields!`
  String get makeSureYouFilledAllTheNeededFields {
    return Intl.message(
      'Make sure you filled all the needed fields!',
      name: 'makeSureYouFilledAllTheNeededFields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get pleaseEnterSomeText {
    return Intl.message(
      'Please enter some text',
      name: 'pleaseEnterSomeText',
      desc: '',
      args: [],
    );
  }

  /// `Medication Types`
  String get medicationTypes {
    return Intl.message(
      'Medication Types',
      name: 'medicationTypes',
      desc: '',
      args: [],
    );
  }

  /// `Tablet`
  String get tablet {
    return Intl.message(
      'Tablet',
      name: 'tablet',
      desc: '',
      args: [],
    );
  }

  /// `Drop`
  String get drop {
    return Intl.message(
      'Drop',
      name: 'drop',
      desc: '',
      args: [],
    );
  }

  /// `Cream`
  String get cream {
    return Intl.message(
      'Cream',
      name: 'cream',
      desc: '',
      args: [],
    );
  }

  /// `Solution`
  String get solution {
    return Intl.message(
      'Solution',
      name: 'solution',
      desc: '',
      args: [],
    );
  }

  /// `Injection`
  String get injection {
    return Intl.message(
      'Injection',
      name: 'injection',
      desc: '',
      args: [],
    );
  }

  /// `Inhaler`
  String get inhaler {
    return Intl.message(
      'Inhaler',
      name: 'inhaler',
      desc: '',
      args: [],
    );
  }

  /// `Spray`
  String get spray {
    return Intl.message(
      'Spray',
      name: 'spray',
      desc: '',
      args: [],
    );
  }

  /// `Search drugs`
  String get searchDrugs {
    return Intl.message(
      'Search drugs',
      name: 'searchDrugs',
      desc: '',
      args: [],
    );
  }

  /// `Refill Drugs`
  String get refillDrugs {
    return Intl.message(
      'Refill Drugs',
      name: 'refillDrugs',
      desc: '',
      args: [],
    );
  }

  /// `Pill Box`
  String get pillBox {
    return Intl.message(
      'Pill Box',
      name: 'pillBox',
      desc: '',
      args: [],
    );
  }

  /// `Selected day’s meds`
  String get selectedDaysMeds {
    return Intl.message(
      'Selected day’s meds',
      name: 'selectedDaysMeds',
      desc: '',
      args: [],
    );
  }

  /// `Paracetamol`
  String get paracetamol {
    return Intl.message(
      'Paracetamol',
      name: 'paracetamol',
      desc: '',
      args: [],
    );
  }

  /// `10:00 AM`
  String get medicationTime {
    return Intl.message(
      '10:00 AM',
      name: 'medicationTime',
      desc: '',
      args: [],
    );
  }

  /// `02/12/2022`
  String get date {
    return Intl.message(
      '02/12/2022',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `2x/day`
  String get frequency {
    return Intl.message(
      '2x/day',
      name: 'frequency',
      desc: '',
      args: [],
    );
  }

  /// `weekly`
  String get weekly {
    return Intl.message(
      'weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Refill`
  String get refill {
    return Intl.message(
      'Refill',
      name: 'refill',
      desc: '',
      args: [],
    );
  }

  /// `Profile edit`
  String get profileEdit {
    return Intl.message(
      'Profile edit',
      name: 'profileEdit',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get changeLanguage {
    return Intl.message(
      'Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Drug history`
  String get drugHistory {
    return Intl.message(
      'Drug history',
      name: 'drugHistory',
      desc: '',
      args: [],
    );
  }

  /// `Donation`
  String get donation {
    return Intl.message(
      'Donation',
      name: 'donation',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get faqs {
    return Intl.message(
      'FAQs',
      name: 'faqs',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change picture`
  String get changePicture {
    return Intl.message(
      'Change picture',
      name: 'changePicture',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your role`
  String get enterYourRole {
    return Intl.message(
      'Enter your role',
      name: 'enterYourRole',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your role`
  String get validateRole {
    return Intl.message(
      'Please enter your role',
      name: 'validateRole',
      desc: '',
      args: [],
    );
  }

  /// `Phone number (optional)`
  String get phoneNumber {
    return Intl.message(
      'Phone number (optional)',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get invalidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Dinner time`
  String get dinnerTime {
    return Intl.message(
      'Dinner time',
      name: 'dinnerTime',
      desc: '',
      args: [],
    );
  }

  /// `Lunch time`
  String get lunchTime {
    return Intl.message(
      'Lunch time',
      name: 'lunchTime',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast time`
  String get breakfastTime {
    return Intl.message(
      'Breakfast time',
      name: 'breakfastTime',
      desc: '',
      args: [],
    );
  }

  /// `Normal patient`
  String get normalPatient {
    return Intl.message(
      'Normal patient',
      name: 'normalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Care giver`
  String get careGiver {
    return Intl.message(
      'Care giver',
      name: 'careGiver',
      desc: '',
      args: [],
    );
  }

  /// `Care receiver`
  String get careReceiver {
    return Intl.message(
      'Care receiver',
      name: 'careReceiver',
      desc: '',
      args: [],
    );
  }

  /// `Active meds`
  String get activeMeds {
    return Intl.message(
      'Active meds',
      name: 'activeMeds',
      desc: '',
      args: [],
    );
  }

  /// `Inactive meds`
  String get inactiveMeds {
    return Intl.message(
      'Inactive meds',
      name: 'inactiveMeds',
      desc: '',
      args: [],
    );
  }

  /// `No meds to Present`
  String get noMeds {
    return Intl.message(
      'No meds to Present',
      name: 'noMeds',
      desc: '',
      args: [],
    );
  }

  /// `Show my UID`
  String get showMyUID {
    return Intl.message(
      'Show my UID',
      name: 'showMyUID',
      desc: '',
      args: [],
    );
  }

  /// `UID`
  String get uidViewTitle {
    return Intl.message(
      'UID',
      name: 'uidViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap over the uid to get it copied`
  String get uidViewTapToCopy {
    return Intl.message(
      'Tap over the uid to get it copied',
      name: 'uidViewTapToCopy',
      desc: '',
      args: [],
    );
  }

  /// `Copied!`
  String get uidViewCopied {
    return Intl.message(
      'Copied!',
      name: 'uidViewCopied',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to clipboard.`
  String get uidViewTextCopiedToClipboard {
    return Intl.message(
      'Text copied to clipboard.',
      name: 'uidViewTextCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Drug-drug interaction`
  String get drugDrugInteraction {
    return Intl.message(
      'Drug-drug interaction',
      name: 'drugDrugInteraction',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `No drug-drug interaction found!`
  String get noInteractionText {
    return Intl.message(
      'No drug-drug interaction found!',
      name: 'noInteractionText',
      desc: '',
      args: [],
    );
  }

  /// `Our algorithms discovered that there are bad interactions between the following drugs.\nRefer back to your doctor with these results!`
  String get interactionText {
    return Intl.message(
      'Our algorithms discovered that there are bad interactions between the following drugs.\nRefer back to your doctor with these results!',
      name: 'interactionText',
      desc: '',
      args: [],
    );
  }

  /// `Awesome!`
  String get awesome {
    return Intl.message(
      'Awesome!',
      name: 'awesome',
      desc: '',
      args: [],
    );
  }

  /// `Add Medical`
  String get addMedical {
    return Intl.message(
      'Add Medical',
      name: 'addMedical',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized edit`
  String get activeMedsItemUnauthorizedEdit {
    return Intl.message(
      'Unauthorized edit',
      name: 'activeMedsItemUnauthorizedEdit',
      desc: '',
      args: [],
    );
  }

  /// `Change the role in edit profile!`
  String get activeMedsItemChangeRoleInEditProfile {
    return Intl.message(
      'Change the role in edit profile!',
      name: 'activeMedsItemChangeRoleInEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the selected med?`
  String get activeMedsItemAreYouSureYouWantToDeleteTheSelectedMed {
    return Intl.message(
      'Are you sure you want to delete the selected med?',
      name: 'activeMedsItemAreYouSureYouWantToDeleteTheSelectedMed',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get activeMedsItemCancel {
    return Intl.message(
      'CANCEL',
      name: 'activeMedsItemCancel',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get activeMedsItemSubmit {
    return Intl.message(
      'SUBMIT',
      name: 'activeMedsItemSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Updated Success!`
  String get activeMedsItemUpdatedSuccess {
    return Intl.message(
      'Updated Success!',
      name: 'activeMedsItemUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update appears next time you load the page`
  String get activeMedsItemUpdateAppearsNextTimeYouLoadThePage {
    return Intl.message(
      'Update appears next time you load the page',
      name: 'activeMedsItemUpdateAppearsNextTimeYouLoadThePage',
      desc: '',
      args: [],
    );
  }

  /// `Deleted Successfully!`
  String get activeMedsItemDeletedSuccessfully {
    return Intl.message(
      'Deleted Successfully!',
      name: 'activeMedsItemDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Refresh to show changes`
  String get activeMedsItemRefreshToShowChanges {
    return Intl.message(
      'Refresh to show changes',
      name: 'activeMedsItemRefreshToShowChanges',
      desc: '',
      args: [],
    );
  }

  /// `Alert!`
  String get alert {
    return Intl.message(
      'Alert!',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Open box request:`
  String get openBoxRequest {
    return Intl.message(
      'Open box request:',
      name: 'openBoxRequest',
      desc: '',
      args: [],
    );
  }

  /// `As a patient`
  String get asPatient {
    return Intl.message(
      'As a patient',
      name: 'asPatient',
      desc: '',
      args: [],
    );
  }

  /// `As a care giver`
  String get asCareGiver {
    return Intl.message(
      'As a care giver',
      name: 'asCareGiver',
      desc: '',
      args: [],
    );
  }

  /// `Close box`
  String get closeBox {
    return Intl.message(
      'Close box',
      name: 'closeBox',
      desc: '',
      args: [],
    );
  }

  /// `Enter a med to get alternatives`
  String get enterAMedToGetAlternatives {
    return Intl.message(
      'Enter a med to get alternatives',
      name: 'enterAMedToGetAlternatives',
      desc: '',
      args: [],
    );
  }

  /// `Search for alternatives`
  String get searchForAlternatives {
    return Intl.message(
      'Search for alternatives',
      name: 'searchForAlternatives',
      desc: '',
      args: [],
    );
  }

  /// `Enter a complete med name`
  String get enterACompleteMedName {
    return Intl.message(
      'Enter a complete med name',
      name: 'enterACompleteMedName',
      desc: '',
      args: [],
    );
  }

  /// `Alternatives`
  String get alternatives {
    return Intl.message(
      'Alternatives',
      name: 'alternatives',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternet {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get noInternetText {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'noInternetText',
      desc: '',
      args: [],
    );
  }

  /// `Make sure that you picked all meal time`
  String get makeSureThatYouPickedAllMealTime {
    return Intl.message(
      'Make sure that you picked all meal time',
      name: 'makeSureThatYouPickedAllMealTime',
      desc: '',
      args: [],
    );
  }

  /// `Care giver uid (optional)`
  String get careGiverUid {
    return Intl.message(
      'Care giver uid (optional)',
      name: 'careGiverUid',
      desc: '',
      args: [],
    );
  }

  /// `Drug box`
  String get drugBox {
    return Intl.message(
      'Drug box',
      name: 'drugBox',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
