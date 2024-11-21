
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizGameApp());
}

class QuizGameApp extends StatelessWidget {
  const QuizGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizGame(),
    );
  }
}

class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final List<Question> _questions = [
    Question("What's the capital of Pakistan?", ["Lahore", "Karachi", "Islamabad", "Multan"], 2),
    Question("What is the largest planet?", ["Earth", "Mars", "Jupiter", "Venus"], 2),
    Question("What is 5 + 3?", ["5", "8", "10", "15"], 1),
  ];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showResult = false;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Correct!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong answer!")),
      );
    }
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResult = true;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Game"),
      ),
      body: _showResult
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your score: $_score/${_questions.length}",
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetQuiz,
              child: const Text("Restart Quiz"),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ..._questions[_currentQuestionIndex].options.asMap().entries.map((option) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => _answerQuestion(option.key),
                child: Text(option.value),
              ),
            )),

          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question(this.questionText, this.options, this.correctAnswerIndex);
}
