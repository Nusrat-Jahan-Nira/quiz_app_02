// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(QuizApp());
// }
//
// class QuizApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Modern Quiz App',
//       theme: ThemeData(
//         primarySwatch: Colors.purple,
//         fontFamily: 'SF Pro Display',
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: QuizScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen>
//     with TickerProviderStateMixin {
//   int currentQuestionIndex = 0;
//   int? selectedAnswer;
//   int score = 0;
//   bool showResult = false;
//   bool isAnswered = false;
//
//   late AnimationController _progressController;
//   late AnimationController _slideController;
//   late Animation<double> _progressAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final List<Map<String, dynamic>> questions = [
//     {
//       'question': 'What is the largest planet in our solar system?',
//       'answers': ['Mars', 'Jupiter', 'Saturn', 'Neptune'],
//       'correctAnswer': 1,
//     },
//     {
//       'question': 'Which programming language is Flutter based on?',
//       'answers': ['Java', 'Kotlin', 'Dart', 'Swift'],
//       'correctAnswer': 2,
//     },
//     {
//       'question': 'What year was the first iPhone released?',
//       'answers': ['2006', '2007', '2008', '2009'],
//       'correctAnswer': 1,
//     },
//     {
//       'question': 'Which element has the chemical symbol "O"?',
//       'answers': ['Gold', 'Silver', 'Oxygen', 'Iron'],
//       'correctAnswer': 2,
//     },
//     {
//       'question': 'What is the capital of Australia?',
//       'answers': ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
//       'correctAnswer': 2,
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _progressController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _slideController = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//
//     _progressAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _progressController,
//       curve: Curves.easeInOut,
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(1.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.elasticOut,
//     ));
//
//     _startAnimations();
//   }
//
//   void _startAnimations() {
//     _progressController.forward();
//     _slideController.forward();
//   }
//
//   @override
//   void dispose() {
//     _progressController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   void _selectAnswer(int index) {
//     if (isAnswered) return;
//
//     HapticFeedback.lightImpact();
//     setState(() {
//       selectedAnswer = index;
//       isAnswered = true;
//     });
//
//     if (index == questions[currentQuestionIndex]['correctAnswer']) {
//       score++;
//     }
//
//     Future.delayed(Duration(milliseconds: 1500), () {
//       _nextQuestion();
//     });
//   }
//
//   void _nextQuestion() {
//     if (currentQuestionIndex < questions.length - 1) {
//       setState(() {
//         currentQuestionIndex++;
//         selectedAnswer = null;
//         isAnswered = false;
//       });
//       _slideController.reset();
//       _progressController.reset();
//       _startAnimations();
//     } else {
//       setState(() {
//         showResult = true;
//       });
//     }
//   }
//
//   void _resetQuiz() {
//     setState(() {
//       currentQuestionIndex = 0;
//       selectedAnswer = null;
//       score = 0;
//       showResult = false;
//       isAnswered = false;
//     });
//     _slideController.reset();
//     _progressController.reset();
//     _startAnimations();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF667eea),
//               Color(0xFF764ba2),
//               Color(0xFFf093fb),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: showResult ? _buildResultScreen() : _buildQuizScreen(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuizScreen() {
//     return Padding(
//       padding: EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(),
//           SizedBox(height: 40),
//           _buildProgressIndicator(),
//           SizedBox(height: 40),
//           _buildQuestionCard(),
//           SizedBox(height: 32),
//           _buildAnswerOptions(),
//           Spacer(),
//           _buildBottomInfo(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.white.withOpacity(0.3)),
//           ),
//           child: Text(
//             'Quiz Challenge',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.white.withOpacity(0.3)),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.star, color: Colors.amber, size: 20),
//               SizedBox(width: 8),
//               Text(
//                 '$score',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProgressIndicator() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Question ${currentQuestionIndex + 1}',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               '${currentQuestionIndex + 1}/${questions.length}',
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         Container(
//           height: 6,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(3),
//             color: Colors.white.withOpacity(0.3),
//           ),
//           child: AnimatedBuilder(
//             animation: _progressAnimation,
//             builder: (context, child) {
//               return FractionallySizedBox(
//                 alignment: Alignment.centerLeft,
//                 widthFactor: (currentQuestionIndex + _progressAnimation.value) / questions.length,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     gradient: LinearGradient(
//                       colors: [Colors.yellow, Colors.orange],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuestionCard() {
//     return SlideTransition(
//       position: _slideAnimation,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(28),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Text(
//           questions[currentQuestionIndex]['question'],
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF2D3748),
//             height: 1.4,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnswerOptions() {
//     return Column(
//       children: List.generate(
//         questions[currentQuestionIndex]['answers'].length,
//             (index) => _buildAnswerOption(index),
//       ),
//     );
//   }
//
//   Widget _buildAnswerOption(int index) {
//     final isSelected = selectedAnswer == index;
//     final isCorrect = index == questions[currentQuestionIndex]['correctAnswer'];
//     final showCorrectAnswer = isAnswered && isCorrect;
//     final showWrongAnswer = isAnswered && isSelected && !isCorrect;
//
//     Color backgroundColor = Colors.white;
//     Color borderColor = Colors.white.withOpacity(0.3);
//     Color textColor = Color(0xFF2D3748);
//     IconData? icon;
//
//     if (showCorrectAnswer) {
//       backgroundColor = Color(0xFF48BB78);
//       borderColor = Color(0xFF48BB78);
//       textColor = Colors.white;
//       icon = Icons.check_circle;
//     } else if (showWrongAnswer) {
//       backgroundColor = Color(0xFFE53E3E);
//       borderColor = Color(0xFFE53E3E);
//       textColor = Colors.white;
//       icon = Icons.cancel;
//     } else if (isSelected) {
//       backgroundColor = Color(0xFF667eea).withOpacity(0.1);
//       borderColor = Color(0xFF667eea);
//     }
//
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       margin: EdgeInsets.only(bottom: 16),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => _selectAnswer(index),
//           borderRadius: BorderRadius.circular(16),
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: backgroundColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: borderColor, width: 2),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     color: textColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       String.fromCharCode(65 + index),
//                       style: TextStyle(
//                         color: textColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Text(
//                     questions[currentQuestionIndex]['answers'][index],
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: textColor,
//                     ),
//                   ),
//                 ),
//                 if (icon != null)
//                   Icon(
//                     icon,
//                     color: textColor,
//                     size: 24,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomInfo() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.lightbulb_outline, color: Colors.yellow, size: 24),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'Take your time and think carefully!',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildResultScreen() {
//     final percentage = (score / questions.length * 100).round();
//     String resultMessage;
//     IconData resultIcon;
//     Color resultColor;
//
//     if (percentage >= 80) {
//       resultMessage = 'Excellent!';
//       resultIcon = Icons.emoji_events;
//       resultColor = Color(0xFFFFD700);
//     } else if (percentage >= 60) {
//       resultMessage = 'Good Job!';
//       resultIcon = Icons.thumb_up;
//       resultColor = Color(0xFF48BB78);
//     } else {
//       resultMessage = 'Keep Learning!';
//       resultIcon = Icons.school;
//       resultColor = Color(0xFF667eea);
//     }
//
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 30,
//                     offset: Offset(0, 15),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     resultIcon,
//                     size: 80,
//                     color: resultColor,
//                   ),
//                   SizedBox(height: 24),
//                   Text(
//                     resultMessage,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'You scored $score out of ${questions.length}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xFF718096),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '$percentage%',
//                     style: TextStyle(
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                       color: resultColor,
//                     ),
//                   ),
//                   SizedBox(height: 32),
//                   ElevatedButton(
//                     onPressed: _resetQuiz,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF667eea),
//                       foregroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: Text(
//                       'Play Again',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'dashboard_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'SF Pro Display',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}





