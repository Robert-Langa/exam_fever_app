import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();

  late GenerativeModel _model;
  ChatSession? _chatSession;
  bool _isInitialized = false;

  // Initialize the Gemini model
  Future<void> initialize() async {
    if (_isInitialized) return;

    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in .env file');
    }

    _model = GenerativeModel(
      model: 'gemini-2.0-flash',  // Fast and free model
      apiKey: apiKey,
      systemInstruction: Content.system('''
You are Sasaharo 🤖, a friendly and helpful AI study assistant for ExamFever app.

Your personality:
- Be warm, encouraging, and supportive
- Use emojis occasionally to be friendly 😊
- Keep responses concise but helpful
- Focus on educational topics: math, science, programming, exam prep, study tips
- If asked about non-educational topics, politely redirect to studying

Your capabilities:
- Answer academic questions
- Explain complex concepts simply
- Provide study strategies and tips
- Generate practice questions
- Help with homework and problem-solving

Remember: You're helping students prepare for exams. Be patient and encouraging!
      '''),
    );

    _chatSession = _model.startChat();
    _isInitialized = true;
  }

  // Send a message and get response
  Future<String> sendMessage(String userMessage) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final response = await _chatSession!.sendMessage(Content.text(userMessage));
      return response.text?.trim() ?? "I'm not sure how to respond to that. Could you rephrase your question?";
    } catch (e) {
      print('Gemini API Error: $e');
      return "Sorry, I'm having trouble connecting right now. Please check your internet connection and try again.";
    }
  }

  // Send message with streaming (real-time response)
  Stream<String> sendMessageStream(String userMessage) async* {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final response = _chatSession!.sendMessageStream(Content.text(userMessage));
      await for (final chunk in response) {
        yield chunk.text ?? '';
      }
    } catch (e) {
      yield "Sorry, I'm having trouble connecting. Please try again.";
    }
  }

  // Clear conversation history (start fresh)
  void clearConversation() {
    if (_isInitialized) {
      _chatSession = _model.startChat();
    }
  }

  // Check if API is working
  Future<bool> testConnection() async {
    try {
      await initialize();
      final response = await _model.generateContent([Content.text('Say "OK" if you can hear me')]);
      return response.text != null;
    } catch (e) {
      return false;
    }
  }
}