// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'System Identyfikacji Flory';

  @override
  String get profileTitle => 'Mój Profil';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get appLanguage => 'Język aplikacji';

  @override
  String get polish => 'Polski';

  @override
  String get english => 'Angielski';

  @override
  String get security => 'Bezpieczeństwo';

  @override
  String get biometricLoginEnabled => 'Logowanie biometryczne włączone';

  @override
  String get logout => 'Wyloguj się';

  @override
  String get logoutConfirmationTitle => 'Wylogowanie';

  @override
  String get logoutConfirmationContent =>
      'Czy na pewno chcesz się wylogować ze swojego konta?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get navHerbaria => 'Zielniki';

  @override
  String get navNotifications => 'Powiadomienia';

  @override
  String get navProfile => 'Profil';

  @override
  String get loginSubtitle => 'Odkrywaj naturę ze swoim zielnikiem';

  @override
  String get usernameLabel => 'Nazwa użytkownika';

  @override
  String get passwordLabel => 'Hasło';

  @override
  String get forgotPasswordButton => 'Zapomniałeś hasła?';

  @override
  String get loginButton => 'Zaloguj się';

  @override
  String get noAccountText => 'Nie masz konta? ';

  @override
  String get registerButton => 'Zarejestruj się';

  @override
  String get rememberMe => 'Zapamiętaj mnie';

  @override
  String get resetPasswordTitle => 'Zresetuj hasło';

  @override
  String get resetPasswordMessage =>
      'Podaj adres e-mail, na który wyślemy instrukcję resetowania hasła.';

  @override
  String get emailLabel => 'Adres e-mail';

  @override
  String get sendLinkButton => 'Wyślij link';

  @override
  String get registerTitle => 'Dołącz do nas';

  @override
  String get registerSubtitle =>
      'Załóż darmowe konto, aby zapisać swoje odkrycia';

  @override
  String get createAccountButton => 'Utwórz konto';

  @override
  String get myHerbariaTitle => 'Moje Zielniki';

  @override
  String get emptyHerbariaTitle => 'Twój zbiór jest pusty';

  @override
  String get emptyHerbariaSubtitle =>
      'Rozpocznij przygodę dodając pierwszy zielnik.';

  @override
  String get offlineSyncTooltip => 'Oczekuje na synchronizację (Offline)';

  @override
  String get noDescription => 'Brak opisu';

  @override
  String get newHerbariumTitle => 'Nowy Zielnik';

  @override
  String get nameLabel => 'Nazwa';

  @override
  String get descriptionOptionalLabel => 'Opis (opcjonalnie)';

  @override
  String get publicLabel => 'Publiczny';

  @override
  String get publicDescription => 'Wszyscy będą mogli zobaczyć ten zielnik.';

  @override
  String get createButton => 'Utwórz';

  @override
  String get emptyPlantsTitle => 'Brak roślin w tym zielniku';

  @override
  String get emptyPlantsSubtitle =>
      'Kliknij \"Zidentyfikuj\", aby dodać pierwszy okaz.';

  @override
  String get unknownSpecies => 'Nieznany gatunek';

  @override
  String get confidenceLabel => 'Pewność: ';

  @override
  String get identifyButton => 'Zidentyfikuj';

  @override
  String get scannerTitle => 'Skaner Roślin';

  @override
  String get cameraInit => 'Inicjalizacja kamery...';

  @override
  String get cameraError => 'Błąd kamery: ';

  @override
  String get processingPhoto => 'Przetwarzanie zdjęcia...';

  @override
  String get placePlantInFrame => 'Umieść roślinę wewnątrz ramki';

  @override
  String get plantSavedSuccess => 'Roślina pomyślnie zapisana!';

  @override
  String get identificationError => 'Błąd identyfikacji: ';

  @override
  String get plantDetailsTitle => 'Szczegóły znaleziska';

  @override
  String get plantDetailsSubtitle =>
      'Sztuczna inteligencja przeanalizuje Twoje zdjęcie i spróbuje rozpoznać gatunek.';

  @override
  String get notesOptionalLabel => 'Notatki (opcjonalnie)';

  @override
  String get plantRecognized => 'Rozpoznano roślinę!';

  @override
  String get plantNotRecognized => 'Nie udało się rozpoznać gatunku';

  @override
  String get identifyWithAiButton => 'Zidentyfikuj z AI';

  @override
  String get aiAnalyzing => 'Sztuczna inteligencja analizuje obraz...';

  @override
  String get markAsReadButton => 'Odczytaj';

  @override
  String get noNewMessagesTitle => 'Brak nowych wiadomości';

  @override
  String get noNewMessagesSubtitle =>
      'Tutaj pojawią się informacje o Twoich roślinach.';

  @override
  String get loginErrorMessage => 'Wystąpił błąd podczas logowania.';

  @override
  String get loginInvalidCredentialsError => 'Nieprawidłowy login lub hasło.';

  @override
  String get emailNotVerifiedError =>
      'Zweryfikuj swój adres e-mail przed logowaniem.';

  @override
  String get loginInvalidRequestError => 'Nieprawidłowe zapytanie logowania.';

  @override
  String get registerSuccessMessage =>
      'Zarejestrowano pomyślnie! Możesz się zalogować.';

  @override
  String get registerErrorMessage => 'Błąd rejestracji. Sprawdź dane.';

  @override
  String get registerConflictError =>
      'Nazwa użytkownika lub email są już zajęte.';

  @override
  String get registerInvalidRequestError =>
      'Błędne dane. Sprawdź poprawność wprowadzonych informacji.';

  @override
  String get forgotPasswordSuccessMessage =>
      'Instrukcje resetowania hasła zostały wysłane.';

  @override
  String get forgotPasswordErrorMessage =>
      'Nie udało się wysłać linku. Sprawdź adres e-mail.';

  @override
  String get pwdMinLength => 'Minimum 8 znaków';

  @override
  String get pwdUppercase => 'Wielka litera';

  @override
  String get pwdLowercase => 'Mała litera';

  @override
  String get pwdNumber => 'Cyfra';

  @override
  String get pwdSpecial => 'Znak specjalny';

  @override
  String get herbariaLoadError => 'Błąd ładowania zielników.';

  @override
  String get plantsLoadError => 'Błąd ładowania roślin.';

  @override
  String get chooseLanguageTitle => 'Wybierz język';

  @override
  String get currentLanguage => 'Polski';

  @override
  String get editNameTitle => 'Edytuj nazwę';

  @override
  String get plantNameLabel => 'Nazwa rośliny';

  @override
  String get saveButton => 'Zapisz';

  @override
  String get cancelButton => 'Anuluj';

  @override
  String get familyLabel => 'Rodzina';

  @override
  String get genusLabel => 'Rodzaj';

  @override
  String get commonNamesLabel => 'Nazwy zwyczajowe';

  @override
  String get createdAtLabel => 'Dodano';

  @override
  String get descriptionLabel => 'Opis';

  @override
  String get unnamedPlant => 'Nienazwana roślina';

  @override
  String get plantDetailsHeader => 'Szczegóły rośliny';

  @override
  String get navFriends => 'Znajomi';

  @override
  String get friendsTitle => 'Znajomi';

  @override
  String get friendsTabList => 'Moi znajomi';

  @override
  String get friendsTabRequests => 'Zaproszenia';

  @override
  String get addFriendTitle => 'Dodaj znajomego';

  @override
  String get addFriendLabel => 'Nazwa użytkownika';

  @override
  String get sendRequestButton => 'Wyślij';

  @override
  String get acceptRequestButton => 'Akceptuj';

  @override
  String get declineRequestButton => 'Odrzuć';

  @override
  String get removeFriendButton => 'Usuń';

  @override
  String get noFriendsText => 'Nie masz jeszcze żadnych znajomych.';

  @override
  String get noRequestsText => 'Brak oczekujących zaproszeń.';

  @override
  String get sentRequestsHeader => 'Wysłane zaproszenia';

  @override
  String get incomingRequestsHeader => 'Otrzymane zaproszenia';

  @override
  String get changeVisibility => 'Zmień widoczność';

  @override
  String get makePublicConfirm => 'Czy chcesz uczynić ten zielnik publicznym?';

  @override
  String get makePrivateConfirm => 'Czy chcesz uczynić ten zielnik prywatnym?';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get editDescriptionTitle => 'Edytuj opis';

  @override
  String get addDescriptionLabel => 'Dodaj opis...';

  @override
  String get deleteHerbarium => 'Usuń zielnik';

  @override
  String get herbariumCreatedSuccess => 'Zielnik utworzony pomyślnie';

  @override
  String get herbariumUpdatedSuccess => 'Zielnik zaktualizowany pomyślnie';

  @override
  String get herbariumDeletedSuccess => 'Zielnik został usunięty';

  @override
  String get herbariumMadePublicSuccess => 'Zielnik jest teraz publiczny';

  @override
  String get herbariumMadePrivateSuccess => 'Zielnik jest teraz prywatny';

  @override
  String get editHerbariumTitle => 'Edytuj zielnik';

  @override
  String get deleteHerbariumTitle => 'Usuń zielnik';

  @override
  String deleteHerbariumContent(String name) {
    return 'Czy na pewno chcesz usunąć zielnik \"$name\"? Tej operacji nie można cofnąć.';
  }

  @override
  String get deletePlant => 'Usuń roślinę';

  @override
  String get deletePlantTitle => 'Usuń roślinę';

  @override
  String deletePlantContent(String name) {
    return 'Czy na pewno chcesz usunąć roślinę \"$name\"? Tej operacji nie można cofnąć.';
  }

  @override
  String get cancelAction => 'Anuluj';

  @override
  String get deleteAction => 'Usuń';

  @override
  String get chooseAction => 'Wybierz działanie:';

  @override
  String addNewPlant(String name) {
    return 'Dodaj jako nową roślinę: $name';
  }

  @override
  String get unknownPlant => 'Nieznany';

  @override
  String get addToExisting => 'Dodaj do istniejącej rośliny o tej nazwie:';

  @override
  String photoCount(int count) {
    return 'Liczba zdjęć w bazie: $count';
  }

  @override
  String get aiSuggestion => 'Propozycja sztucznej inteligencji:';

  @override
  String get secureScreenTitle => 'Ochrona przed podglądem';

  @override
  String get secureScreenSubtitle =>
      'Zablokuj zrzuty ekranu i podgląd aplikacji';

  @override
  String get biometryTitle => 'Logowanie biometrią';

  @override
  String get biometryEnabled => 'Włączone';

  @override
  String get biometryDisabled => 'Wyłączone';

  @override
  String get biometryNotSupported =>
      'Twoje urządzenie nie obsługuje biometrii.';

  @override
  String get removeFriendTitle => 'Usuń znajomego';

  @override
  String removeFriendContent(String name) {
    return 'Czy na pewno chcesz usunąć użytkownika \"$name\" ze znajomych?';
  }

  @override
  String get resendVerificationButton => 'Wyślij ponownie';

  @override
  String get resendVerificationSuccessMessage =>
      'Link weryfikacyjny został wysłany ponownie.';

  @override
  String get resendVerificationErrorMessage =>
      'Nie udało się wysłać linku weryfikacyjnego.';

  @override
  String get errorSessionExpired => 'Sesja wygasła. Wylogowywanie...';

  @override
  String get errorAccessDenied => 'Brak dostępu do tego zasobu.';

  @override
  String get errorNotFound => 'Nie znaleziono zasobu.';

  @override
  String get errorConflict => 'Konflikt danych.';

  @override
  String get errorConnection => 'Błąd połączenia z serwerem.';

  @override
  String get errorUnexpected => 'Wystąpił nieoczekiwany błąd.';
}
