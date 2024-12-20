import 'package:newproject/core/utils/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _voiceInput = '';

  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  static const apiKey = "AIzaSyDTDUuG_ns2O3yCGOcLmF16MHjQvW0qWhM";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];
  bool isLoading = false;

  static const assistantText =
      "انت مساعد تقوم بالاجابة عن الاسئلة القانونية وليس الشخصيه عن ثلاثه اسطر";

  Future<void> sendMessage() async {
    final userMessageText = _voiceInput.isNotEmpty ? _voiceInput : _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
          isUser: true, message: userMessageText, date: DateTime.now()));
      isLoading = true;
    });

    _scrollToBottom();

    final messageWithInstruction = "$assistantText\n\n$userMessageText";
    final content = [Content.text(messageWithInstruction)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
      isLoading = false;
      _voiceInput = ''; // Reset voice input after sending the message

    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Function to start or stop listening
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _voiceInput = val.recognizedWords;
          });

          // عند الانتهاء من التسجيل، أرسل الرسالة تلقائيًا
          if (val.hasConfidenceRating && val.confidence > 0.5) {
            _speech.stop(); // إيقاف التسجيل
            _isListening = false; // تحديث الحالة
            sendMessage(); // إرسال الرسالة
          }
        },
          localeId: 'ar_SA',   //    تحديد اللغة
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استفسارات'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            if (isLoading)
              LinearProgressIndicator(color: MyTheme.primaryColor,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    color: MyTheme.primaryColor,
                    iconSize: 30,
                    onPressed: _listen, // Start or stop listening
                  ),
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userMessage,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        hintText:  "إكتب استفسارك...",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      validator: (value) {
                        if (value!.isEmpty && _voiceInput.isEmpty) {
                          return 'يجب تعبئة الحقل';
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    splashRadius: 25,
                    color: MyTheme.primaryColor,
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        sendMessage();
                        _focusNode.requestFocus();
                      } else {
                        autoValidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key, required this.isUser, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? MyTheme.primaryColor : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
          topRight: const Radius.circular(20),
          bottomRight: isUser ? Radius.zero : const Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              color: isUser ? Colors.white70 : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}