enum AiProviderType {
  openAiCompatible,
  openAi,
  gemini;

  String get label {
    switch (this) {
      case AiProviderType.openAiCompatible:
        return 'OpenAI-compatible API';
      case AiProviderType.openAi:
        return 'OpenAI';
      case AiProviderType.gemini:
        return 'Google Gemini';
    }
  }
}
