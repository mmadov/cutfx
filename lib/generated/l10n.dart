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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cut.FX`
  String get appName {
    return Intl.message('Cut.FX', name: 'appName', desc: '', args: []);
  }

  /// `Premium Beauty Services`
  String get premiumBeautyServices {
    return Intl.message(
      'Premium Beauty Services',
      name: 'premiumBeautyServices',
      desc: '',
      args: [],
    );
  }

  /// `Find and book Hair Cut, Massage, Spa,\nWaxing, Coloring services anytime.`
  String get findAndBookHairCutMassageSpaWaxingColoringServicesAnytime {
    return Intl.message(
      'Find and book Hair Cut, Massage, Spa,\nWaxing, Coloring services anytime.',
      name: 'findAndBookHairCutMassageSpaWaxingColoringServicesAnytime',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message('Continue', name: 'continue_', desc: '', args: []);
  }

  /// `Sign in to Continue`
  String get signInToContinue {
    return Intl.message(
      'Sign in to Continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Apple`
  String get signInWithApple {
    return Intl.message(
      'Sign In With Apple',
      name: 'signInWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign In With Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Email`
  String get signInWithEmail {
    return Intl.message(
      'Sign In With Email',
      name: 'signInWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `By continuing with any options,`
  String get byContinuingWithAnyOptions {
    return Intl.message(
      'By continuing with any options,',
      name: 'byContinuingWithAnyOptions',
      desc: '',
      args: [],
    );
  }

  /// `You agree to`
  String get youAgreeTo {
    return Intl.message('You agree to', name: 'youAgreeTo', desc: '', args: []);
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message('Terms of Use', name: 'termsOfUse', desc: '', args: []);
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
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

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword_ {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword_',
      desc: '',
      args: [],
    );
  }

  /// `New User? Register Here`
  String get newUserRegisterHere {
    return Intl.message(
      'New User? Register Here',
      name: 'newUserRegisterHere',
      desc: '',
      args: [],
    );
  }

  /// `Email Registration`
  String get emailRegistration {
    return Intl.message(
      'Email Registration',
      name: 'emailRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details and complete\nprofile for better experience`
  String get enterYourDetailsAndCompleteProfileForBetterExperience {
    return Intl.message(
      'Enter your details and complete\nprofile for better experience',
      name: 'enterYourDetailsAndCompleteProfileForBetterExperience',
      desc: '',
      args: [],
    );
  }

  /// `Fullname`
  String get fullName {
    return Intl.message('Fullname', name: 'fullName', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Your Password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot Your Password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address, on which we will\nsend you the link to reset the password.`
  String
      get enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword {
    return Intl.message(
      'Enter your email address, on which we will\nsend you the link to reset the password.',
      name:
          'enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword',
      desc: '',
      args: [],
    );
  }

  /// `Be the best version of yourself`
  String get beTheBestVersionOfYourself {
    return Intl.message(
      'Be the best version of yourself',
      name: 'beTheBestVersionOfYourself',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Favourite`
  String get favourite {
    return Intl.message('Favourite', name: 'favourite', desc: '', args: []);
  }

  /// `My Bookings`
  String get myBooking {
    return Intl.message('My Bookings', name: 'myBooking', desc: '', args: []);
  }

  /// `Messages`
  String get messages {
    return Intl.message('Messages', name: 'messages', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `Top Rated Salons`
  String get topRatedSalons {
    return Intl.message(
      'Top Rated Salons',
      name: 'topRatedSalons',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message('Open', name: 'open', desc: '', args: []);
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message('Top Rated', name: 'topRated', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Nearby Salons`
  String get nearBySalons {
    return Intl.message(
      'Nearby Salons',
      name: 'nearBySalons',
      desc: '',
      args: [],
    );
  }

  /// `Explore salons on map`
  String get exploreSalonsOnMap {
    return Intl.message(
      'Explore salons on map',
      name: 'exploreSalonsOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get bookings {
    return Intl.message('Bookings', name: 'bookings', desc: '', args: []);
  }

  /// `Help & FAQ`
  String get help_FAQ {
    return Intl.message('Help & FAQ', name: 'help_FAQ', desc: '', args: []);
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Service`
  String get service {
    return Intl.message('Service', name: 'service', desc: '', args: []);
  }

  /// `Salon`
  String get salon {
    return Intl.message('Salon', name: 'salon', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `My Bookings`
  String get myBookings {
    return Intl.message('My Bookings', name: 'myBookings', desc: '', args: []);
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Total Bookings`
  String get totalBookings {
    return Intl.message(
      'Total Bookings',
      name: 'totalBookings',
      desc: '',
      args: [],
    );
  }

  /// `Edit Details`
  String get editDetails {
    return Intl.message(
      'Edit Details',
      name: 'editDetails',
      desc: '',
      args: [],
    );
  }

  /// `Push Notification`
  String get pushNotification {
    return Intl.message(
      'Push Notification',
      name: 'pushNotification',
      desc: '',
      args: [],
    );
  }

  /// `Keep it On, if you want to receive notifications`
  String get keepItOnIfYouWantToReceiveNotifications {
    return Intl.message(
      'Keep it On, if you want to receive notifications',
      name: 'keepItOnIfYouWantToReceiveNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
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

  /// `Delete My Account`
  String get deleteMyAccount {
    return Intl.message(
      'Delete My Account',
      name: 'deleteMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Recent`
  String get recent {
    return Intl.message('Recent', name: 'recent', desc: '', args: []);
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message('Clear all', name: 'clearAll', desc: '', args: []);
  }

  /// `Popular Search`
  String get popularSearch {
    return Intl.message(
      'Popular Search',
      name: 'popularSearch',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions For You`
  String get suggestionForYou {
    return Intl.message(
      'Suggestions For You',
      name: 'suggestionForYou',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Apply filters according to your needs`
  String get applyFiltersAccordingToYourNeed {
    return Intl.message(
      'Apply filters according to your needs',
      name: 'applyFiltersAccordingToYourNeed',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Unisex`
  String get unisex {
    return Intl.message('Unisex', name: 'unisex', desc: '', args: []);
  }

  /// `Woman`
  String get woman {
    return Intl.message('Woman', name: 'woman', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Awards`
  String get awards {
    return Intl.message('Awards', name: 'awards', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `For questions and queries`
  String get forQuestionsAndQueries {
    return Intl.message(
      'For questions and queries',
      name: 'forQuestionsAndQueries',
      desc: '',
      args: [],
    );
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `Navigate`
  String get navigate {
    return Intl.message('Navigate', name: 'navigate', desc: '', args: []);
  }

  /// `Subtotal`
  String get subTotal {
    return Intl.message('Subtotal', name: 'subTotal', desc: '', args: []);
  }

  /// `Place Booking`
  String get placeBooking {
    return Intl.message(
      'Place Booking',
      name: 'placeBooking',
      desc: '',
      args: [],
    );
  }

  /// `Ratings`
  String get ratings {
    return Intl.message('Ratings', name: 'ratings', desc: '', args: []);
  }

  /// `Confirm Booking`
  String get confirmBooking {
    return Intl.message(
      'Confirm Booking',
      name: 'confirmBooking',
      desc: '',
      args: [],
    );
  }

  /// `Select Slot`
  String get selectSlot {
    return Intl.message('Select Slot', name: 'selectSlot', desc: '', args: []);
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Make Payment`
  String get makePayment {
    return Intl.message(
      'Make Payment',
      name: 'makePayment',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Coupon Discount`
  String get couponDiscount {
    return Intl.message(
      'Coupon Discount',
      name: 'couponDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Apply Coupon`
  String get applyCoupon {
    return Intl.message(
      'Apply Coupon',
      name: 'applyCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message('Pay Now', name: 'payNow', desc: '', args: []);
  }

  /// `Tap on a coupon to apply it`
  String get tapOnACouponToApplyIt {
    return Intl.message(
      'Tap on a coupon to apply it',
      name: 'tapOnACouponToApplyIt',
      desc: '',
      args: [],
    );
  }

  /// `Offered By`
  String get offeredBy {
    return Intl.message('Offered By', name: 'offeredBy', desc: '', args: []);
  }

  /// `Book Service`
  String get bookService {
    return Intl.message(
      'Book Service',
      name: 'bookService',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get bookingDetails {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get reschedule {
    return Intl.message('Reschedule', name: 'reschedule', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Rate This Saloon`
  String get rateThisSaloon {
    return Intl.message(
      'Rate This Saloon',
      name: 'rateThisSaloon',
      desc: '',
      args: [],
    );
  }

  /// `Share your experience with us.`
  String get shareYourExperienceWithUs {
    return Intl.message(
      'Share your experience with us.',
      name: 'shareYourExperienceWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Rate Now`
  String get rateNow {
    return Intl.message('Rate Now', name: 'rateNow', desc: '', args: []);
  }

  /// `Add Ratings`
  String get addRatings {
    return Intl.message('Add Ratings', name: 'addRatings', desc: '', args: []);
  }

  /// `Share your experience in few words`
  String get shareYourExperienceInFewWords {
    return Intl.message(
      'Share your experience in few words',
      name: 'shareYourExperienceInFewWords',
      desc: '',
      args: [],
    );
  }

  /// `Your Review`
  String get yourReview {
    return Intl.message('Your Review', name: 'yourReview', desc: '', args: []);
  }

  /// `Show This QR at Salon`
  String get showThisQRAtSalon {
    return Intl.message(
      'Show This QR at Salon',
      name: 'showThisQRAtSalon',
      desc: '',
      args: [],
    );
  }

  /// `Offer this QR at salon shop, they will\nscan it and will have all the details`
  String get offerThisQRAtSalonShopTheyWillScanItAndWillHaveAllTheDetails {
    return Intl.message(
      'Offer this QR at salon shop, they will\nscan it and will have all the details',
      name: 'offerThisQRAtSalonShopTheyWillScanItAndWillHaveAllTheDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number (optional)`
  String get phoneNumberOptional {
    return Intl.message(
      'Phone Number (optional)',
      name: 'phoneNumberOptional',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message('Withdraw', name: 'withdraw', desc: '', args: []);
  }

  /// `Statement`
  String get statement {
    return Intl.message('Statement', name: 'statement', desc: '', args: []);
  }

  /// `Purchase`
  String get purchase {
    return Intl.message('Purchase', name: 'purchase', desc: '', args: []);
  }

  /// `Deposit`
  String get deposit {
    return Intl.message('Deposit', name: 'deposit', desc: '', args: []);
  }

  /// `-`
  String get dash {
    return Intl.message('-', name: 'dash', desc: '', args: []);
  }

  /// `Withdraw Request`
  String get withdrawRequest {
    return Intl.message(
      'Withdraw Request',
      name: 'withdrawRequest',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message('Bank Name', name: 'bankName', desc: '', args: []);
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter Account Number`
  String get reEnterAccountNumber {
    return Intl.message(
      'Re-Enter Account Number',
      name: 'reEnterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Holders Name`
  String get holdersName {
    return Intl.message(
      'Holders Name',
      name: 'holdersName',
      desc: '',
      args: [],
    );
  }

  /// `Swift Code`
  String get swiftCode {
    return Intl.message('Swift Code', name: 'swiftCode', desc: '', args: []);
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete your account?\nall of your data will deleted and you won’t\nbe able to recover it again !\n\nDo you really want to proceed?`
  String get deleteDesc {
    return Intl.message(
      'Do you really want to delete your account?\nall of your data will deleted and you won’t\nbe able to recover it again !\n\nDo you really want to proceed?',
      name: 'deleteDesc',
      desc: '',
      args: [],
    );
  }

  /// `Salons`
  String get salons {
    return Intl.message('Salons', name: 'salons', desc: '', args: []);
  }

  /// `Do you really want to logout?`
  String get logoutDec {
    return Intl.message(
      'Do you really want to logout?',
      name: 'logoutDec',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Jan`
  String get jan {
    return Intl.message('Jan', name: 'jan', desc: '', args: []);
  }

  /// `Feb`
  String get feb {
    return Intl.message('Feb', name: 'feb', desc: '', args: []);
  }

  /// `Mar`
  String get mar {
    return Intl.message('Mar', name: 'mar', desc: '', args: []);
  }

  /// `Apr`
  String get apr {
    return Intl.message('Apr', name: 'apr', desc: '', args: []);
  }

  /// `May`
  String get may {
    return Intl.message('May', name: 'may', desc: '', args: []);
  }

  /// `Jun`
  String get jun {
    return Intl.message('Jun', name: 'jun', desc: '', args: []);
  }

  /// `Jul`
  String get jul {
    return Intl.message('Jul', name: 'jul', desc: '', args: []);
  }

  /// `Aug`
  String get aug {
    return Intl.message('Aug', name: 'aug', desc: '', args: []);
  }

  /// `Sep`
  String get sep {
    return Intl.message('Sep', name: 'sep', desc: '', args: []);
  }

  /// `Oct`
  String get oct {
    return Intl.message('Oct', name: 'oct', desc: '', args: []);
  }

  /// `Nov`
  String get nov {
    return Intl.message('Nov', name: 'nov', desc: '', args: []);
  }

  /// `Dec`
  String get dec {
    return Intl.message('Dec', name: 'dec', desc: '', args: []);
  }

  /// `January`
  String get january {
    return Intl.message('January', name: 'january', desc: '', args: []);
  }

  /// `February`
  String get february {
    return Intl.message('February', name: 'february', desc: '', args: []);
  }

  /// `March`
  String get march {
    return Intl.message('March', name: 'march', desc: '', args: []);
  }

  /// `April`
  String get april {
    return Intl.message('April', name: 'april', desc: '', args: []);
  }

  /// `June`
  String get june {
    return Intl.message('June', name: 'june', desc: '', args: []);
  }

  /// `July`
  String get july {
    return Intl.message('July', name: 'july', desc: '', args: []);
  }

  /// `August`
  String get august {
    return Intl.message('August', name: 'august', desc: '', args: []);
  }

  /// `September`
  String get september {
    return Intl.message('September', name: 'september', desc: '', args: []);
  }

  /// `October`
  String get october {
    return Intl.message('October', name: 'october', desc: '', args: []);
  }

  /// `November`
  String get november {
    return Intl.message('November', name: 'november', desc: '', args: []);
  }

  /// `December`
  String get december {
    return Intl.message('December', name: 'december', desc: '', args: []);
  }

  /// `1`
  String get one {
    return Intl.message('1', name: 'one', desc: '', args: []);
  }

  /// `Please enter email address`
  String get pleaseEnterEmailAddress {
    return Intl.message(
      'Please enter email address',
      name: 'pleaseEnterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email address`
  String get pleaseEnterValidEmailAddress {
    return Intl.message(
      'Please enter valid email address',
      name: 'pleaseEnterValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get pleaseEnterConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'pleaseEnterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `User Already Exists`
  String get userAlreadyExist {
    return Intl.message(
      'User Already Exists',
      name: 'userAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Fullname`
  String get pleaseEnterFullname {
    return Intl.message(
      'Please enter Fullname',
      name: 'pleaseEnterFullname',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email first..!`
  String get pleaseVerifyEmailFirst {
    return Intl.message(
      'Please verify your email first..!',
      name: 'pleaseVerifyEmailFirst',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password..!`
  String get wrongPassword {
    return Intl.message(
      'Wrong password..!',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Complete registration first..!`
  String get pleaseRegistrationFirst {
    return Intl.message(
      'Complete registration first..!',
      name: 'pleaseRegistrationFirst',
      desc: '',
      args: [],
    );
  }

  /// `Enter your fullname..!`
  String get enterYourFullname {
    return Intl.message(
      'Enter your fullname..!',
      name: 'enterYourFullname',
      desc: '',
      args: [],
    );
  }

  /// `Monday - Friday`
  String get mondayFriday {
    return Intl.message(
      'Monday - Friday',
      name: 'mondayFriday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday - Sunday`
  String get saturdaySunday {
    return Intl.message(
      'Saturday - Sunday',
      name: 'saturdaySunday',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get by {
    return Intl.message('By', name: 'by', desc: '', args: []);
  }

  /// `Please select date`
  String get pleaseSelectDate {
    return Intl.message(
      'Please select date',
      name: 'pleaseSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select time`
  String get pleaseSelectTime {
    return Intl.message(
      'Please select time',
      name: 'pleaseSelectTime',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Payment Failed..!`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed..!',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Recharge Wallet`
  String get rechargeWallet {
    return Intl.message(
      'Recharge Wallet',
      name: 'rechargeWallet',
      desc: '',
      args: [],
    );
  }

  /// `Add money to your wallet`
  String get addMoneyToYourWalletToRecharge {
    return Intl.message(
      'Add money to your wallet',
      name: 'addMoneyToYourWalletToRecharge',
      desc: '',
      args: [],
    );
  }

  /// `Please recharge your wallet to continue booking`
  String get pleaseRechargeYourWalletToContinueBooking {
    return Intl.message(
      'Please recharge your wallet to continue booking',
      name: 'pleaseRechargeYourWalletToContinueBooking',
      desc: '',
      args: [],
    );
  }

  /// `Select Amount`
  String get selectAmount {
    return Intl.message(
      'Select Amount',
      name: 'selectAmount',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Enter Amount Of Your Choice`
  String get enterAmountOfYourChoice {
    return Intl.message(
      'Enter Amount Of Your Choice',
      name: 'enterAmountOfYourChoice',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message('Proceed', name: 'proceed', desc: '', args: []);
  }

  /// `Appointment Booked`
  String get appointmentBooked {
    return Intl.message(
      'Appointment Booked',
      name: 'appointmentBooked',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Successful`
  String get transactionSuccessful {
    return Intl.message(
      'Transaction Successful',
      name: 'transactionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Funds have been added\nto your account successfully!`
  String get fundsHaveBeenAddedntoYourAccountSuccessfully {
    return Intl.message(
      'Funds have been added\nto your account successfully!',
      name: 'fundsHaveBeenAddedntoYourAccountSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Now you can book appointments\nwith single click to avoid disturbance.`
  String get nowYouCanBookAppointmentsnwithSingleClickToAvoidDisturbance {
    return Intl.message(
      'Now you can book appointments\nwith single click to avoid disturbance.',
      name: 'nowYouCanBookAppointmentsnwithSingleClickToAvoidDisturbance',
      desc: '',
      args: [],
    );
  }

  /// `Payment Cancelled`
  String get paymentCancelled {
    return Intl.message(
      'Payment Cancelled',
      name: 'paymentCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Payable Amount`
  String get payableAmount {
    return Intl.message(
      'Payable Amount',
      name: 'payableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Completion OTP :`
  String get completionOtp {
    return Intl.message(
      'Completion OTP :',
      name: 'completionOtp',
      desc: '',
      args: [],
    );
  }

  /// `Please, provide this OTP at salon when asked, only after you get your services as per the order.`
  String get pleaseProvideThisOtpAtSalonWhenAskedOnlyAfter {
    return Intl.message(
      'Please, provide this OTP at salon when asked, only after you get your services as per the order.',
      name: 'pleaseProvideThisOtpAtSalonWhenAskedOnlyAfter',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least 1 star.`
  String get pleaseSelectAtLeast1Star {
    return Intl.message(
      'Please select at least 1 star.',
      name: 'pleaseSelectAtLeast1Star',
      desc: '',
      args: [],
    );
  }

  /// `Please write review..!`
  String get pleaseEnterReview {
    return Intl.message(
      'Please write review..!',
      name: 'pleaseEnterReview',
      desc: '',
      args: [],
    );
  }

  /// `Booking Pending`
  String get bookingPending {
    return Intl.message(
      'Booking Pending',
      name: 'bookingPending',
      desc: '',
      args: [],
    );
  }

  /// `Booking ID`
  String get bookingId {
    return Intl.message('Booking ID', name: 'bookingId', desc: '', args: []);
  }

  /// `Your appointment\nhas been booked successfully`
  String get yourAppointmentnhasBeenBookedSuccessfully {
    return Intl.message(
      'Your appointment\nhas been booked successfully',
      name: 'yourAppointmentnhasBeenBookedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Check Appointments tab\nfor all your upcoming appointments`
  String get checkAppointmentsTabnforAllYourUpcomingAppointments {
    return Intl.message(
      'Check Appointments tab\nfor all your upcoming appointments',
      name: 'checkAppointmentsTabnforAllYourUpcomingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Send Media`
  String get sendMedia {
    return Intl.message('Send Media', name: 'sendMedia', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Too large..!`
  String get tooLarge {
    return Intl.message('Too large..!', name: 'tooLarge', desc: '', args: []);
  }

  /// `Video?`
  String get video {
    return Intl.message('Video?', name: 'video', desc: '', args: []);
  }

  /// `This video is greater than 15 mb\nPlease select another...`
  String get thisVideoIsGreaterThan15MbnpleaseSelectAnother {
    return Intl.message(
      'This video is greater than 15 mb\nPlease select another...',
      name: 'thisVideoIsGreaterThan15MbnpleaseSelectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Select Another`
  String get selectAnother {
    return Intl.message(
      'Select Another',
      name: 'selectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Select Message`
  String get selectMsg {
    return Intl.message(
      'Select Message',
      name: 'selectMsg',
      desc: '',
      args: [],
    );
  }

  /// `Delete Message`
  String get deleteMessage {
    return Intl.message(
      'Delete Message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Request`
  String get withdrawTitle {
    return Intl.message(
      'Withdraw Request',
      name: 'withdrawTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to withdraw all amount from your wallet?`
  String get withdrawDescription {
    return Intl.message(
      'Do you really want to withdraw all amount from your wallet?',
      name: 'withdrawDescription',
      desc: '',
      args: [],
    );
  }

  /// `Complete Booking`
  String get completeBooking {
    return Intl.message(
      'Complete Booking',
      name: 'completeBooking',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Delete for me`
  String get deleteForMe {
    return Intl.message(
      'Delete for me',
      name: 'deleteForMe',
      desc: '',
      args: [],
    );
  }

  /// `Refund`
  String get refund {
    return Intl.message('Refund', name: 'refund', desc: '', args: []);
  }

  /// `Help & FAQ`
  String get helpAndFAQ {
    return Intl.message('Help & FAQ', name: 'helpAndFAQ', desc: '', args: []);
  }

  /// `Please Enter Old Password..!`
  String get pleaseEnterOldPassword {
    return Intl.message(
      'Please Enter Old Password..!',
      name: 'pleaseEnterOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password is wrong..!`
  String get oldPasswordIsWrong {
    return Intl.message(
      'Old Password is wrong..!',
      name: 'oldPasswordIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter New Password..!`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Please Enter New Password..!',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Appointment ID`
  String get appointmentId {
    return Intl.message(
      'Appointment ID',
      name: 'appointmentId',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get suggestions {
    return Intl.message('Suggestions', name: 'suggestions', desc: '', args: []);
  }

  /// `Enter Bank Name..!`
  String get enterBankName {
    return Intl.message(
      'Enter Bank Name..!',
      name: 'enterBankName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Account Number..!`
  String get enterAccountNumber {
    return Intl.message(
      'Enter Account Number..!',
      name: 'enterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter Account Number..!`
  String get enterReaccountNumber {
    return Intl.message(
      'Re-Enter Account Number..!',
      name: 'enterReaccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Account Number Doesn't Matched..!`
  String get accountNumberDoestMatched {
    return Intl.message(
      'Account Number Doesn\'t Matched..!',
      name: 'accountNumberDoestMatched',
      desc: '',
      args: [],
    );
  }

  /// `Enter Holders Name..!`
  String get enterHoldersName {
    return Intl.message(
      'Enter Holders Name..!',
      name: 'enterHoldersName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Swift Code..!`
  String get enterSwiftCode {
    return Intl.message(
      'Enter Swift Code..!',
      name: 'enterSwiftCode',
      desc: '',
      args: [],
    );
  }

  /// `Account :`
  String get account {
    return Intl.message('Account :', name: 'account', desc: '', args: []);
  }

  /// `Cancel Booking`
  String get cancelBooking {
    return Intl.message(
      'Cancel Booking',
      name: 'cancelBooking',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Requests`
  String get withdrawRequests {
    return Intl.message(
      'Withdraw Requests',
      name: 'withdrawRequests',
      desc: '',
      args: [],
    );
  }

  /// `do you really want to cancel this booking?\nthis action can't be undone`
  String get doYouReallyWantToCancelThisBookingnthisActionCant {
    return Intl.message(
      'do you really want to cancel this booking?\nthis action can\'t be undone',
      name: 'doYouReallyWantToCancelThisBookingnthisActionCant',
      desc: '',
      args: [],
    );
  }

  /// `Booking Confirmed`
  String get bookingConfirmed {
    return Intl.message(
      'Booking Confirmed',
      name: 'bookingConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Cancelled By Salon`
  String get cancelledBySalon {
    return Intl.message(
      'Cancelled By Salon',
      name: 'cancelledBySalon',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled By You`
  String get cancelledByYou {
    return Intl.message(
      'Cancelled By You',
      name: 'cancelledByYou',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `You can make bookings only for today or for the 90 days in future.`
  String get youCanMakeBookingsOnlyForTodayOrForThe {
    return Intl.message(
      'You can make bookings only for today or for the 90 days in future.',
      name: 'youCanMakeBookingsOnlyForTodayOrForThe',
      desc: '',
      args: [],
    );
  }

  /// `Not Available`
  String get notAvailable {
    return Intl.message(
      'Not Available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Slots Available`
  String get slotsAvailable {
    return Intl.message(
      'Slots Available',
      name: 'slotsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No Slots Available`
  String get noSlotsAvailable {
    return Intl.message(
      'No Slots Available',
      name: 'noSlotsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get completedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'completedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Barber`
  String get barber {
    return Intl.message('Barber', name: 'barber', desc: '', args: []);
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Total Orders :`
  String get totalOrders {
    return Intl.message(
      'Total Orders :',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Barber`
  String get confirmBarber {
    return Intl.message(
      'Confirm Barber',
      name: 'confirmBarber',
      desc: '',
      args: [],
    );
  }

  /// `Choose barber first...!`
  String get chooseBarberFirst {
    return Intl.message(
      'Choose barber first...!',
      name: 'chooseBarberFirst',
      desc: '',
      args: [],
    );
  }

  /// `Pay After Service`
  String get payAfterService {
    return Intl.message(
      'Pay After Service',
      name: 'payAfterService',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message('Staff', name: 'staff', desc: '', args: []);
  }

  /// `Payment Type`
  String get paymentType {
    return Intl.message(
      'Payment Type',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Pre-Paid`
  String get prepaid {
    return Intl.message('Pre-Paid', name: 'prepaid', desc: '', args: []);
  }

  /// `Addresses`
  String get addresses {
    return Intl.message('Addresses', name: 'addresses', desc: '', args: []);
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Locality / Area`
  String get localityArea {
    return Intl.message(
      'Locality / Area',
      name: 'localityArea',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `PIN Code`
  String get pinCode {
    return Intl.message('PIN Code', name: 'pinCode', desc: '', args: []);
  }

  /// `State`
  String get state {
    return Intl.message('State', name: 'state', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Office`
  String get office {
    return Intl.message('Office', name: 'office', desc: '', args: []);
  }

  /// `Address Type`
  String get addressType {
    return Intl.message(
      'Address Type',
      name: 'addressType',
      desc: '',
      args: [],
    );
  }

  /// `Click To Fetch Location`
  String get clickToFetchLocation {
    return Intl.message(
      'Click To Fetch Location',
      name: 'clickToFetchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location Service is Disabled`
  String get locationServiceIsDisabled {
    return Intl.message(
      'Location Service is Disabled',
      name: 'locationServiceIsDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Location Fetched`
  String get locationFetched {
    return Intl.message(
      'Location Fetched',
      name: 'locationFetched',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Attach Location`
  String get attachLocation {
    return Intl.message(
      'Attach Location',
      name: 'attachLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Phone Number...!`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please Enter Phone Number...!',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Address...!`
  String get pleaseEnterAddress {
    return Intl.message(
      'Please Enter Address...!',
      name: 'pleaseEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Locality/Area...!`
  String get pleaseEnterLocalityarea {
    return Intl.message(
      'Please Enter Locality/Area...!',
      name: 'pleaseEnterLocalityarea',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter City...!`
  String get pleaseEnterCity {
    return Intl.message(
      'Please Enter City...!',
      name: 'pleaseEnterCity',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter PIN Code...!`
  String get pleaseEnterPinCode {
    return Intl.message(
      'Please Enter PIN Code...!',
      name: 'pleaseEnterPinCode',
      desc: '',
      args: [],
    );
  }

  /// `Please select Location...!`
  String get pleaseSelectLocation {
    return Intl.message(
      'Please select Location...!',
      name: 'pleaseSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Country...!`
  String get pleaseEnterCountry {
    return Intl.message(
      'Please Enter Country...!',
      name: 'pleaseEnterCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter State...!`
  String get pleaseEnterState {
    return Intl.message(
      'Please Enter State...!',
      name: 'pleaseEnterState',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete Address`
  String get deleteAddress {
    return Intl.message(
      'Delete Address',
      name: 'deleteAddress',
      desc: '',
      args: [],
    );
  }

  /// `Service Location`
  String get serviceLocation {
    return Intl.message(
      'Service Location',
      name: 'serviceLocation',
      desc: '',
      args: [],
    );
  }

  /// `At Salon`
  String get atSalon {
    return Intl.message('At Salon', name: 'atSalon', desc: '', args: []);
  }

  /// `My Address`
  String get myAddress {
    return Intl.message('My Address', name: 'myAddress', desc: '', args: []);
  }

  /// `Select Address`
  String get selectAddress {
    return Intl.message(
      'Select Address',
      name: 'selectAddress',
      desc: '',
      args: [],
    );
  }

  /// `● Click on any address to select.`
  String get clickOnAnyAddressToSelect {
    return Intl.message(
      '● Click on any address to select.',
      name: 'clickOnAnyAddressToSelect',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Address...!`
  String get pleaseSelectAddress {
    return Intl.message(
      'Please Select Address...!',
      name: 'pleaseSelectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Other Location`
  String get otherLocation {
    return Intl.message(
      'Other Location',
      name: 'otherLocation',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Expert`
  String get chooseYourExpert {
    return Intl.message(
      'Choose Your Expert',
      name: 'chooseYourExpert',
      desc: '',
      args: [],
    );
  }

  /// `Select Barber`
  String get selectBarber {
    return Intl.message(
      'Select Barber',
      name: 'selectBarber',
      desc: '',
      args: [],
    );
  }

  /// `Please select barber`
  String get pleaseSelectBarber {
    return Intl.message(
      'Please select barber',
      name: 'pleaseSelectBarber',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message('Available', name: 'available', desc: '', args: []);
  }

  /// `Book your Haircut, Massage, Spa,\n Waxing, or Coloring—whenever \nthe moment calls for it.`
  String get bookYourHaircutMassageSpanWaxingOrColoringwheneverNtheMoment {
    return Intl.message(
      'Book your Haircut, Massage, Spa,\n Waxing, or Coloring—whenever \nthe moment calls for it.',
      name: 'bookYourHaircutMassageSpanWaxingOrColoringwheneverNtheMoment',
      desc: '',
      args: [],
    );
  }

  /// `Tap To Select The Expert`
  String get tapToSelectTheExpert {
    return Intl.message(
      'Tap To Select The Expert',
      name: 'tapToSelectTheExpert',
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
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
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
