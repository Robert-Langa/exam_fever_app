import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../core/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isStreaming;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isStreaming = false,
  });
}

class AiSearchTab extends StatefulWidget {
  const AiSearchTab({super.key});

  @override
  State<AiSearchTab> createState() => _AiSearchTabState();
}

class _AiSearchTabState extends State<AiSearchTab> {
  final List<ChatMessage> messages = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GeminiService _geminiService = GeminiService();
  
  bool isTyping = false;
  bool isInitialized = false;
  String currentStreamingText = '';

  @override
  void initState() {
    super.initState();
    _initializeAI();
  }

  Future<void> _initializeAI() async {
    setState(() {
      isTyping = true;
    });

    try {
      await _geminiService.initialize();
      
      setState(() {
        messages.add(ChatMessage(
          text: "Hello! I'm Sasaharo 🤖, your AI study assistant powered by Google Gemini.\n\nI can help you with:\n• Answering any study questions\n• Explaining complex topics\n• Creating practice problems\n• Exam preparation tips\n\nWhat would you like to learn today?",
          isUser: false,
          timestamp: DateTime.now(),
        ));
        isInitialized = true;
        isTyping = false;
      });
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(
          text: "⚠️ Error: Could not initialize AI. Please check your API key in the .env file.\n\nMake sure you have:\n1. Created a .env file\n2. Added GEMINI_API_KEY=your_key_here\n3. Restarted the app",
          isUser: false,
          timestamp: DateTime.now(),
        ));
        isTyping = false;
      });
    }
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;
    if (!isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("AI is still initializing. Please wait...")),
      );
      return;
    }

    String userText = messageController.text.trim();
    messageController.clear();

    setState(() {
      messages.add(ChatMessage(
        text: userText,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      isTyping = true;
      currentStreamingText = '';
    });
    scrollToBottom();

    setState(() {
      messages.add(ChatMessage(
        text: '',
        isUser: false,
        timestamp: DateTime.now(),
        isStreaming: true,
      ));
    });
    scrollToBottom();

    String fullResponse = '';
    await for (String chunk in _geminiService.sendMessageStream(userText)) {
      fullResponse += chunk;
      setState(() {
        final lastIndex = messages.length - 1;
        if (lastIndex >= 0 && !messages[lastIndex].isUser) {
          messages[lastIndex] = ChatMessage(
            text: fullResponse,
            isUser: false,
            timestamp: messages[lastIndex].timestamp,
            isStreaming: true,
          );
        }
      });
      scrollToBottom();
    }

    setState(() {
      final lastIndex = messages.length - 1;
      if (lastIndex >= 0 && !messages[lastIndex].isUser) {
        messages[lastIndex] = ChatMessage(
          text: fullResponse,
          isUser: false,
          timestamp: messages[lastIndex].timestamp,
          isStreaming: false,
        );
      }
      isTyping = false;
      currentStreamingText = '';
    });
    scrollToBottom();
  }

  void clearChat() {
    setState(() {
      messages.clear();
      _geminiService.clearConversation();
      
      messages.add(ChatMessage(
        text: "Chat cleared! 👋\n\nI'm Sasaharo, your AI study assistant. Ask me anything about your studies!",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text("🤖", style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sasaharo AI",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isTyping ? "Thinking..." : (isInitialized ? "Powered by Gemini AI" : "Initializing..."),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: clearChat,
                tooltip: "Clear chat",
              ),
            ],
          ),
        ),

        // Chat messages area
        Expanded(
          child: messages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text("🤖", style: TextStyle(fontSize: 45)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sasaharo AI Assistant",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Powered by Google Gemini AI. Ask me anything about your studies!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 10,
                        children: [
                          _buildSuggestionChip("What is Flutter?"),
                          _buildSuggestionChip("Explain quantum physics"),
                          _buildSuggestionChip("Study tips for exams"),
                          _buildSuggestionChip("Help me with calculus"),
                        ],
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageBubble(message);
                  },
                ),
        ),

        // Input area
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: "Ask Sasaharo anything...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: sendMessage,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        messageController.text = text;
        sendMessage();
      },
      backgroundColor: AppColors.primary.withOpacity(0.1),
      side: BorderSide.none,
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.secondary : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                ),
              ),
              child: message.isStreaming
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message.text.isEmpty ? "Thinking" : message.text,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        if (message.text.isEmpty) ...[
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isUser ? Colors.white : AppColors.primary,
                            ),
                          ),
                        ],
                      ],
                    )
                  : Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}