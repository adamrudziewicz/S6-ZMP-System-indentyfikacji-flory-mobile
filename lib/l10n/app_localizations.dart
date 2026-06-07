import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flora Identification System'**
  String get appTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @polish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get polish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @biometricLoginEnabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric login enabled'**
  String get biometricLoginEnabled;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get logoutConfirmationContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @navHerbaria.
  ///
  /// In en, this message translates to:
  /// **'Herbaria'**
  String get navHerbaria;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover nature with your herbarium'**
  String get loginSubtitle;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordButton;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @noAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccountText;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get registerButton;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you instructions to reset your password.'**
  String get resetPasswordMessage;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailLabel;

  /// No description provided for @sendLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLinkButton;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Join us'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a free account to save your discoveries'**
  String get registerSubtitle;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @myHerbariaTitle.
  ///
  /// In en, this message translates to:
  /// **'My Herbaria'**
  String get myHerbariaTitle;

  /// No description provided for @emptyHerbariaTitle.
  ///
  /// In en, this message translates to:
  /// **'Your collection is empty'**
  String get emptyHerbariaTitle;

  /// No description provided for @emptyHerbariaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your adventure by adding your first herbarium.'**
  String get emptyHerbariaSubtitle;

  /// No description provided for @offlineSyncTooltip.
  ///
  /// In en, this message translates to:
  /// **'Waiting for sync (Offline)'**
  String get offlineSyncTooltip;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @newHerbariumTitle.
  ///
  /// In en, this message translates to:
  /// **'New Herbarium'**
  String get newHerbariumTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @descriptionOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptionalLabel;

  /// No description provided for @publicLabel.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get publicLabel;

  /// No description provided for @publicDescription.
  ///
  /// In en, this message translates to:
  /// **'Everyone will be able to see this herbarium.'**
  String get publicDescription;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// No description provided for @emptyPlantsTitle.
  ///
  /// In en, this message translates to:
  /// **'No plants in this herbarium'**
  String get emptyPlantsTitle;

  /// No description provided for @emptyPlantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Click \'Identify\' to add your first specimen.'**
  String get emptyPlantsSubtitle;

  /// No description provided for @unknownSpecies.
  ///
  /// In en, this message translates to:
  /// **'Unknown species'**
  String get unknownSpecies;

  /// No description provided for @confidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Confidence: '**
  String get confidenceLabel;

  /// No description provided for @identifyButton.
  ///
  /// In en, this message translates to:
  /// **'Identify'**
  String get identifyButton;

  /// No description provided for @scannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Plant Scanner'**
  String get scannerTitle;

  /// No description provided for @cameraInit.
  ///
  /// In en, this message translates to:
  /// **'Initializing camera...'**
  String get cameraInit;

  /// No description provided for @cameraError.
  ///
  /// In en, this message translates to:
  /// **'Camera error: '**
  String get cameraError;

  /// No description provided for @processingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Processing photo...'**
  String get processingPhoto;

  /// No description provided for @placePlantInFrame.
  ///
  /// In en, this message translates to:
  /// **'Place the plant inside the frame'**
  String get placePlantInFrame;

  /// No description provided for @plantSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plant successfully saved!'**
  String get plantSavedSuccess;

  /// No description provided for @identificationError.
  ///
  /// In en, this message translates to:
  /// **'Identification error: '**
  String get identificationError;

  /// No description provided for @plantDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Specimen details'**
  String get plantDetailsTitle;

  /// No description provided for @plantDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI will analyze your photo and try to recognize the species.'**
  String get plantDetailsSubtitle;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptionalLabel;

  /// No description provided for @plantRecognized.
  ///
  /// In en, this message translates to:
  /// **'Plant recognized!'**
  String get plantRecognized;

  /// No description provided for @plantNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'Failed to recognize species'**
  String get plantNotRecognized;

  /// No description provided for @identifyWithAiButton.
  ///
  /// In en, this message translates to:
  /// **'Identify with AI'**
  String get identifyWithAiButton;

  /// No description provided for @aiAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Artificial intelligence is analyzing the image...'**
  String get aiAnalyzing;

  /// No description provided for @markAsReadButton.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get markAsReadButton;

  /// No description provided for @noNewMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'No new messages'**
  String get noNewMessagesTitle;

  /// No description provided for @noNewMessagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Information about your plants will appear here.'**
  String get noNewMessagesSubtitle;

  /// No description provided for @loginErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during login.'**
  String get loginErrorMessage;

  /// No description provided for @loginInvalidCredentialsError.
  ///
  /// In en, this message translates to:
  /// **'Invalid login or password.'**
  String get loginInvalidCredentialsError;

  /// No description provided for @emailNotVerifiedError.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email address before logging in.'**
  String get emailNotVerifiedError;

  /// No description provided for @loginInvalidRequestError.
  ///
  /// In en, this message translates to:
  /// **'Invalid login request.'**
  String get loginInvalidRequestError;

  /// No description provided for @registerSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Registered successfully! You can now log in.'**
  String get registerSuccessMessage;

  /// No description provided for @registerErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Registration error. Please check your data.'**
  String get registerErrorMessage;

  /// No description provided for @registerConflictError.
  ///
  /// In en, this message translates to:
  /// **'Username or email is already taken.'**
  String get registerConflictError;

  /// No description provided for @registerInvalidRequestError.
  ///
  /// In en, this message translates to:
  /// **'Invalid data. Check the correctness of the entered information.'**
  String get registerInvalidRequestError;

  /// No description provided for @forgotPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Password reset instructions have been sent.'**
  String get forgotPasswordSuccessMessage;

  /// No description provided for @forgotPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to send link. Check your email address.'**
  String get forgotPasswordErrorMessage;

  /// No description provided for @pwdMinLength.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get pwdMinLength;

  /// No description provided for @pwdUppercase.
  ///
  /// In en, this message translates to:
  /// **'Uppercase letter'**
  String get pwdUppercase;

  /// No description provided for @pwdLowercase.
  ///
  /// In en, this message translates to:
  /// **'Lowercase letter'**
  String get pwdLowercase;

  /// No description provided for @pwdNumber.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get pwdNumber;

  /// No description provided for @pwdSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special character'**
  String get pwdSpecial;

  /// No description provided for @herbariaLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading herbaria.'**
  String get herbariaLoadError;

  /// No description provided for @plantsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading plants.'**
  String get plantsLoadError;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguageTitle;

  /// No description provided for @currentLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get currentLanguage;

  /// No description provided for @editNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editNameTitle;

  /// No description provided for @plantNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant name'**
  String get plantNameLabel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @familyLabel.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get familyLabel;

  /// No description provided for @genusLabel.
  ///
  /// In en, this message translates to:
  /// **'Genus'**
  String get genusLabel;

  /// No description provided for @commonNamesLabel.
  ///
  /// In en, this message translates to:
  /// **'Common names'**
  String get commonNamesLabel;

  /// No description provided for @createdAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get createdAtLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @unnamedPlant.
  ///
  /// In en, this message translates to:
  /// **'Unnamed plant'**
  String get unnamedPlant;

  /// No description provided for @plantDetailsHeader.
  ///
  /// In en, this message translates to:
  /// **'Plant Details'**
  String get plantDetailsHeader;

  /// No description provided for @navFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get navFriends;

  /// No description provided for @friendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friendsTitle;

  /// No description provided for @friendsTabList.
  ///
  /// In en, this message translates to:
  /// **'My friends'**
  String get friendsTabList;

  /// No description provided for @friendsTabRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get friendsTabRequests;

  /// No description provided for @addFriendTitle.
  ///
  /// In en, this message translates to:
  /// **'Add friend'**
  String get addFriendTitle;

  /// No description provided for @addFriendLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get addFriendLabel;

  /// No description provided for @sendRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendRequestButton;

  /// No description provided for @acceptRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptRequestButton;

  /// No description provided for @declineRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get declineRequestButton;

  /// No description provided for @removeFriendButton.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeFriendButton;

  /// No description provided for @noFriendsText.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any friends yet.'**
  String get noFriendsText;

  /// No description provided for @noRequestsText.
  ///
  /// In en, this message translates to:
  /// **'No pending requests.'**
  String get noRequestsText;

  /// No description provided for @sentRequestsHeader.
  ///
  /// In en, this message translates to:
  /// **'Sent requests'**
  String get sentRequestsHeader;

  /// No description provided for @incomingRequestsHeader.
  ///
  /// In en, this message translates to:
  /// **'Incoming requests'**
  String get incomingRequestsHeader;

  /// No description provided for @changeVisibility.
  ///
  /// In en, this message translates to:
  /// **'Change visibility'**
  String get changeVisibility;

  /// No description provided for @makePublicConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to make this herbarium public?'**
  String get makePublicConfirm;

  /// No description provided for @makePrivateConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to make this herbarium private?'**
  String get makePrivateConfirm;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @editDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit description'**
  String get editDescriptionTitle;

  /// No description provided for @addDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Add description...'**
  String get addDescriptionLabel;

  /// No description provided for @deleteHerbarium.
  ///
  /// In en, this message translates to:
  /// **'Delete herbarium'**
  String get deleteHerbarium;

  /// No description provided for @deleteHerbariumTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete herbarium'**
  String get deleteHerbariumTitle;

  /// No description provided for @deleteHerbariumContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the herbarium \"{name}\"? This action cannot be undone.'**
  String deleteHerbariumContent(String name);

  /// No description provided for @deletePlant.
  ///
  /// In en, this message translates to:
  /// **'Delete plant'**
  String get deletePlant;

  /// No description provided for @deletePlantTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete plant'**
  String get deletePlantTitle;

  /// No description provided for @deletePlantContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the plant \"{name}\"? This action cannot be undone.'**
  String deletePlantContent(String name);

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @chooseAction.
  ///
  /// In en, this message translates to:
  /// **'Choose action:'**
  String get chooseAction;

  /// No description provided for @addNewPlant.
  ///
  /// In en, this message translates to:
  /// **'Add as a new plant: {name}'**
  String addNewPlant(String name);

  /// No description provided for @unknownPlant.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownPlant;

  /// No description provided for @addToExisting.
  ///
  /// In en, this message translates to:
  /// **'Add to existing plant with this name:'**
  String get addToExisting;

  /// No description provided for @photoCount.
  ///
  /// In en, this message translates to:
  /// **'Number of photos: {count}'**
  String photoCount(int count);

  /// No description provided for @aiSuggestion.
  ///
  /// In en, this message translates to:
  /// **'AI suggestion:'**
  String get aiSuggestion;

  /// No description provided for @secureScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy screen protection'**
  String get secureScreenTitle;

  /// No description provided for @secureScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Block screenshots and app switcher previews'**
  String get secureScreenSubtitle;

  /// No description provided for @biometryTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric login'**
  String get biometryTitle;

  /// No description provided for @biometryEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get biometryEnabled;

  /// No description provided for @biometryDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get biometryDisabled;

  /// No description provided for @biometryNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Your device does not support biometrics.'**
  String get biometryNotSupported;

  /// No description provided for @removeFriendTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove friend'**
  String get removeFriendTitle;

  /// No description provided for @removeFriendContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove \"{name}\" from your friends?'**
  String removeFriendContent(String name);

  /// No description provided for @resendVerificationButton.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendVerificationButton;

  /// No description provided for @resendVerificationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Verification link has been resent.'**
  String get resendVerificationSuccessMessage;

  /// No description provided for @resendVerificationErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend verification link.'**
  String get resendVerificationErrorMessage;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Logging out...'**
  String get errorSessionExpired;

  /// No description provided for @errorAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied to this resource.'**
  String get errorAccessDenied;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found.'**
  String get errorNotFound;

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'Data conflict.'**
  String get errorConflict;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Server connection error.'**
  String get errorConnection;

  /// No description provided for @errorUnexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnexpected;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
