// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flora Identification System';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appLanguage => 'App Language';

  @override
  String get polish => 'Polish';

  @override
  String get english => 'English';

  @override
  String get security => 'Security';

  @override
  String get biometricLoginEnabled => 'Biometric login enabled';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirmationTitle => 'Log out';

  @override
  String get logoutConfirmationContent =>
      'Are you sure you want to log out of your account?';

  @override
  String get cancel => 'Cancel';

  @override
  String get navHerbaria => 'Herbaria';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginSubtitle => 'Discover nature with your herbarium';

  @override
  String get usernameLabel => 'Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPasswordButton => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get noAccountText => 'Don\'t have an account? ';

  @override
  String get registerButton => 'Sign up';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordMessage =>
      'Enter your email address and we\'ll send you instructions to reset your password.';

  @override
  String get emailLabel => 'Email address';

  @override
  String get sendLinkButton => 'Send link';

  @override
  String get registerTitle => 'Join us';

  @override
  String get registerSubtitle =>
      'Create a free account to save your discoveries';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get myHerbariaTitle => 'My Herbaria';

  @override
  String get emptyHerbariaTitle => 'Your collection is empty';

  @override
  String get emptyHerbariaSubtitle =>
      'Start your adventure by adding your first herbarium.';

  @override
  String get offlineSyncTooltip => 'Waiting for sync (Offline)';

  @override
  String get noDescription => 'No description';

  @override
  String get newHerbariumTitle => 'New Herbarium';

  @override
  String get nameLabel => 'Name';

  @override
  String get descriptionOptionalLabel => 'Description (optional)';

  @override
  String get publicLabel => 'Public';

  @override
  String get publicDescription =>
      'Everyone will be able to see this herbarium.';

  @override
  String get createButton => 'Create';

  @override
  String get emptyPlantsTitle => 'No plants in this herbarium';

  @override
  String get emptyPlantsSubtitle =>
      'Click \'Identify\' to add your first specimen.';

  @override
  String get unknownSpecies => 'Unknown species';

  @override
  String get confidenceLabel => 'Confidence: ';

  @override
  String get identifyButton => 'Identify';

  @override
  String get scannerTitle => 'Plant Scanner';

  @override
  String get cameraInit => 'Initializing camera...';

  @override
  String get cameraError => 'Camera error: ';

  @override
  String get processingPhoto => 'Processing photo...';

  @override
  String get placePlantInFrame => 'Place the plant inside the frame';

  @override
  String get plantSavedSuccess => 'Plant successfully saved!';

  @override
  String get identificationError => 'Identification error: ';

  @override
  String get plantDetailsTitle => 'Specimen details';

  @override
  String get plantDetailsSubtitle =>
      'AI will analyze your photo and try to recognize the species.';

  @override
  String get notesOptionalLabel => 'Notes (optional)';

  @override
  String get plantRecognized => 'Plant recognized!';

  @override
  String get plantNotRecognized => 'Failed to recognize species';

  @override
  String get identifyWithAiButton => 'Identify with AI';

  @override
  String get aiAnalyzing => 'Artificial intelligence is analyzing the image...';

  @override
  String get markAsReadButton => 'Read';

  @override
  String get noNewMessagesTitle => 'No new messages';

  @override
  String get noNewMessagesSubtitle =>
      'Information about your plants will appear here.';

  @override
  String get loginErrorMessage => 'An error occurred during login.';

  @override
  String get loginInvalidCredentialsError => 'Invalid login or password.';

  @override
  String get emailNotVerifiedError =>
      'Please verify your email address before logging in.';

  @override
  String get loginInvalidRequestError => 'Invalid login request.';

  @override
  String get registerSuccessMessage =>
      'Registered successfully! You can now log in.';

  @override
  String get registerErrorMessage =>
      'Registration error. Please check your data.';

  @override
  String get registerConflictError => 'Username or email is already taken.';

  @override
  String get registerInvalidRequestError =>
      'Invalid data. Check the correctness of the entered information.';

  @override
  String get forgotPasswordSuccessMessage =>
      'Password reset instructions have been sent.';

  @override
  String get forgotPasswordErrorMessage =>
      'Failed to send link. Check your email address.';

  @override
  String get pwdMinLength => 'Minimum 8 characters';

  @override
  String get pwdUppercase => 'Uppercase letter';

  @override
  String get pwdLowercase => 'Lowercase letter';

  @override
  String get pwdNumber => 'Number';

  @override
  String get pwdSpecial => 'Special character';

  @override
  String get herbariaLoadError => 'Error loading herbaria.';

  @override
  String get plantsLoadError => 'Error loading plants.';

  @override
  String get chooseLanguageTitle => 'Choose language';

  @override
  String get currentLanguage => 'English';

  @override
  String get editNameTitle => 'Edit name';

  @override
  String get plantNameLabel => 'Plant name';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get familyLabel => 'Family';

  @override
  String get genusLabel => 'Genus';

  @override
  String get commonNamesLabel => 'Common names';

  @override
  String get createdAtLabel => 'Added';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get unnamedPlant => 'Unnamed plant';

  @override
  String get plantDetailsHeader => 'Plant Details';

  @override
  String get navFriends => 'Friends';

  @override
  String get friendsTitle => 'Friends';

  @override
  String get friendsTabList => 'My friends';

  @override
  String get friendsTabRequests => 'Requests';

  @override
  String get addFriendTitle => 'Add friend';

  @override
  String get addFriendLabel => 'Username';

  @override
  String get sendRequestButton => 'Send';

  @override
  String get acceptRequestButton => 'Accept';

  @override
  String get declineRequestButton => 'Decline';

  @override
  String get removeFriendButton => 'Remove';

  @override
  String get noFriendsText => 'You don\'t have any friends yet.';

  @override
  String get noRequestsText => 'No pending requests.';

  @override
  String get sentRequestsHeader => 'Sent requests';

  @override
  String get incomingRequestsHeader => 'Incoming requests';

  @override
  String get changeVisibility => 'Change visibility';

  @override
  String get makePublicConfirm => 'Do you want to make this herbarium public?';

  @override
  String get makePrivateConfirm =>
      'Do you want to make this herbarium private?';

  @override
  String get confirm => 'Confirm';

  @override
  String get editDescriptionTitle => 'Edit description';

  @override
  String get addDescriptionLabel => 'Add description...';

  @override
  String get deleteHerbarium => 'Delete herbarium';

  @override
  String get deleteHerbariumTitle => 'Delete herbarium';

  @override
  String deleteHerbariumContent(String name) {
    return 'Are you sure you want to delete the herbarium \"$name\"? This action cannot be undone.';
  }

  @override
  String get deletePlant => 'Delete plant';

  @override
  String get deletePlantTitle => 'Delete plant';

  @override
  String deletePlantContent(String name) {
    return 'Are you sure you want to delete the plant \"$name\"? This action cannot be undone.';
  }

  @override
  String get cancelAction => 'Cancel';

  @override
  String get deleteAction => 'Delete';

  @override
  String get chooseAction => 'Choose action:';

  @override
  String addNewPlant(String name) {
    return 'Add as a new plant: $name';
  }

  @override
  String get unknownPlant => 'Unknown';

  @override
  String get addToExisting => 'Add to existing plant with this name:';

  @override
  String photoCount(int count) {
    return 'Number of photos: $count';
  }

  @override
  String get aiSuggestion => 'AI suggestion:';

  @override
  String get secureScreenTitle => 'Privacy screen protection';

  @override
  String get secureScreenSubtitle =>
      'Block screenshots and app switcher previews';

  @override
  String get biometryTitle => 'Biometric login';

  @override
  String get biometryEnabled => 'Enabled';

  @override
  String get biometryDisabled => 'Disabled';

  @override
  String get biometryNotSupported => 'Your device does not support biometrics.';
}
