# SmartStudy AI

A local-first Flutter study assistant starter.

## Included in this starter
- Arabic RTL home screen
- Light, dark, and system theme selection
- Multi-provider selection scaffold
- API key storage using `flutter_secure_storage`
- Document picker for PDF, DOCX, TXT and image files
- GitHub Actions workflow to analyze and build a release APK

## Run locally
```bash
flutter pub get
flutter analyze
flutter run
```

## Build APK
```bash
flutter build apk --release
```

## GitHub Actions
Push to `main` or `master`, or run **Build SmartStudy AI APK** manually from the Actions tab. Download the APK from the workflow run's Artifacts section.

## Important
This is the foundation, not the complete AI application yet. Document parsing, OCR, local database, RAG retrieval, summaries, mind maps, and quizzes are planned as subsequent implementation stages.

Never commit API keys. The app stores the entered key locally using secure storage. Direct mobile API calls cannot fully conceal a key from a determined device owner.
