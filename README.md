# System Identyfikacji Flory (Aplikacja Mobilna)

Aplikacja mobilna projektu **System Identyfikacji Flory** zrealizowana w ramach przedmiotu *Zaawansowane Metody Programowania*. Służy do automatycznego rozpoznawania i katalogowania roślin przy wykorzystaniu sztucznej inteligencji.

## Zespół Projektowy

Projekt składa się z czterech zintegrowanych modułów współpracujących ze sobą za pośrednictwem centralnego API. Poniżej znajdują się repozytoria członków grupy:

* **[API: Java + SpringBoot + Maven + PostgreSQL, Maksym Wilk 43900](https://github.com/maksym456/S6-ZMP-System-indentyfikacji-flory-API)**
* **[Aplikacja Mobilna: Dart + Flutter, Adam Rudziewicz 43882](https://github.com/adamrudziewicz/S6-ZMP-System-indentyfikacji-flory-mobile)** *(To repozytorium)*
* **[Aplikacja Webowa: TypeScript + React, Szymon Rogula 43880](https://github.com/SX2V/S6-ZMP-System-indentyfikacji-flory-Web)**
* **[Aplikacja Desktopowa: C# + .NET, Sebastian Waga 43894](https://github.com/sebastianwaga/S6-ZMP-System-indentyfikacji-flory-Desktop)**

---

## O aplikacji

Aplikacja mobilna została stworzona w środowisku **Flutter**. Pozwala użytkownikom na robienie zdjęć roślinom i błyskawiczne wysyłanie ich do serwera w celu natychmiastowej identyfikacji gatunku. Została zaprojektowana w oparciu o zaawansowane wzorce projektowe, co zapewnia solidną architekturę i najwyższe standardy bezpieczeństwa.

### Główne funkcjonalności
* **Logowanie i Autoryzacja:** Zaawansowana rejestracja konta, wsparcie dla przypominania hasła, bezpieczne uwierzytelnianie tokenami JWT (automatyczne odświeżanie sesji) oraz wsparcie dla biometrii (Odcisk palca / PIN).
* **Identyfikacja AI:** Wykorzystanie aparatu wbudowanego w telefon, wysyłka obrazu multipart i automatyczna interpretacja gatunku na podstawie odpowiedzi modelu ML z backendu.
* **Herbarium (Zielnik):** Organizacja zidentyfikowanych roślin oraz funkcja trybu **offline** (dane są buforowane lokalnie w celu późniejszego podglądu braku dostępu do internetu).
* **Powiadomienia Push:** Globalna integracja z Firebase Cloud Messaging (FCM) obsługująca zdarzenia o zakończonym procesie analizy obrazu.
* **Wielojęzyczność:** Wbudowane, dynamiczne wsparcie dla języka polskiego i angielskiego.

## Technologie i Architektura

Aplikacja została zbudowana zgodnie z rygorystycznymi wymogami **Clean Architecture**, wprowadzając modularny, warstwowy podział na *Domain*, *Data* i *Presentation*. Podejście to gwarantuje testowalność i separację logiki od interfejsu.

* **Framework:** Flutter (Dart)
* **Zarządzanie Stanem:** BLoC (Business Logic Component)
* **Warstwa Sieciowa (API):** Dio (wzbogacone o zaawansowane interceptory HTTP dla autoryzacji oraz scentralizowany Error Handler)
* **Baza Danych (Offline Cache):** Hive (bardzo wydajna baza NoSQL / klucz-wartość)
* **Bezpieczeństwo:** Flutter Secure Storage (szyfrowanie kluczy w zaufanym środowisku TEE systemu Android)
* **Wstrzykiwanie Zależności (DI):** GetIt
* **Generowanie Kodu:** Freezed & Json_Serializable (wymuszanie niemutowalności modeli oraz generowanie kodu serializacji DTO)

## Instalacja i Uruchomienie

### Wymagania systemowe
* Zestaw Flutter SDK (wersja ^3.11.1)
* Środowisko Android SDK / Emulator (lub fizyczne urządzenie z włączonym trybem debugowania USB)
* Plik `.env` definiujący klucze i środowisko API (np. `API_BASE_URL=http://...`) umieszczony w głównym katalogu projektu.

### Instrukcje deweloperskie
1. Zainstaluj wszystkie potrzebne pakiety:
   ```bash
   flutter pub get
   ```
2. Jeśli zmieniano pliki bazowe, wygeneruj pliki z kodem (odpowiedzialne m.in za modele Freezed):
   ```bash
   dart run build_runner build -d
   ```
3. Uruchom aplikację na podpiętym urządzeniu:
   ```bash
   flutter run
   ```

### Kompilacja do APK (Tryb Produkcyjny)
Aby stworzyć zoptymalizowany i skompresowany plik instalacyjny `.apk` (z wbudowaną autorską ikoną) wpisz komendę:
```bash
flutter build apk --release
```
Plik wynikowy zostanie wygenerowany pod ścieżką `build/app/outputs/flutter-apk/app-release.apk`.

## Testy

Platforma zawiera rygorystyczny zestaw **33 zautomatyzowanych testów jednostkowych**, które sprawdzają odporność aplikacji, logikę decyzyjną oraz obsługę nietypowych stanów sieci. Obejmują one pełne pokrycie w takich obszarach jak weryfikacja JWT, przechwytywanie błędów na warstwie repozytorium oraz weryfikację emitowanych strumieni stanów w blokach BLoC.

Aby wywołać testy:
```bash
flutter test
```
