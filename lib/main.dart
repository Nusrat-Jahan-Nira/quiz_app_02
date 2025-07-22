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

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
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

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Tab controller for different sections
  late TabController _tabController;

  int totalQuizzesPlayed = 0;
  int bestScore = 0;
  int totalCorrectAnswers = 0;
  int streakDays = 3; // Track user streak

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    _tabController = TabController(length: 3, vsync: this);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _updateStats(int score, int totalQuestions) {
    setState(() {
      totalQuizzesPlayed++;
      if (score > bestScore) bestScore = score;
      totalCorrectAnswers += score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Color(0xFF0250c5),
        //       Color(0xFF7A5FFF),
        //       Color(0xFFD264D0),
        //     ],
        //     stops: [0.1, 0.5, 0.9],
        //   ),
        // ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4158D0),
              Color(0xFFC850C0),
              Color(0xFFFFCC70),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          SizedBox(height: 24),
                          _buildUserProgress(),
                          SizedBox(height: 24),
                          _buildStatsCards(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: _buildTabBar(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildCategoriesTab(),
                  _buildLeaderboardTab(),
                  _buildAchievementsTab(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                onQuizCompleted: _updateStats,
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF667eea),
        label: Text(
          'Start Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        icon: Icon(Icons.play_arrow),
        elevation: 8,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Ready to challenge yourself?',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProgress() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.local_fire_department, color: Colors.amber, size: 24),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$streakDays Day Streak!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Keep going!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber, size: 18),
                    SizedBox(width: 5),
                    Text(
                      'Level 3',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 10,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '65%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '325 XP to Level 4',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Quizzes',
            '$totalQuizzesPlayed',
            Icons.quiz,
            Color(0xFF48BB78),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Best Score',
            '$bestScore',
            Icons.star,
            Color(0xFFFFD700),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Accuracy',
            totalQuizzesPlayed > 0
                ? '${((totalCorrectAnswers / (totalQuizzesPlayed * 5)) * 100).round()}%'
                : '0%',
            Icons.track_changes,
            Color(0xFFE53E3E),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D3748),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF718096),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        labelColor: Color(0xFF667eea),
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
       indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: 'Categories'),
          Tab(text: 'Leaderboard'),
          Tab(text: 'Achievements'),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(24),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final categories = [
                  {'title': 'General Knowledge', 'icon': Icons.lightbulb_outline, 'color': Color(0xFF667eea), 'progress': '4/5', 'locked': false},
                  {'title': 'Technology', 'icon': Icons.computer, 'color': Color(0xFF48BB78), 'progress': '3/5', 'locked': false},
                  {'title': 'Science', 'icon': Icons.science, 'color': Color(0xFFE53E3E), 'progress': '2/5', 'locked': false},
                  {'title': 'History', 'icon': Icons.history, 'color': Color(0xFFDD6B20), 'progress': '0/5', 'locked': false},
                  {'title': 'Geography', 'icon': Icons.public, 'color': Color(0xFF00B5D8), 'progress': '0/5', 'locked': true},
                  {'title': 'Entertainment', 'icon': Icons.movie, 'color': Color(0xFF805AD5), 'progress': '0/5', 'locked': true},
                ];

                return _buildCategoryTile(
                  categories[index]['title'] as String,
                  categories[index]['icon'] as IconData,
                  categories[index]['color'] as Color,
                  categories[index]['progress'] as String,
                  categories[index]['locked'] as bool,
                  index,
                );
              },
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(String title, IconData icon, Color color, String progress, bool locked, int index) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation((index * 0.2)),
      builder: (context, child) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          duration: Duration(milliseconds: 600 + (index * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: child!,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              child: InkWell(
                onTap: locked ? null : () {},
                splashColor: color.withOpacity(0.1),
                highlightColor: color.withOpacity(0.05),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'category_$title',
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                shape: BoxShape.circle,
                                border: Border.all(color: color.withOpacity(0.2), width: 1.5),
                              ),
                              child: Icon(icon, color: color, size: 34),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2D3748),
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: int.parse(progress.split('/')[0]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: int.parse(progress.split('/')[1]) - int.parse(progress.split('/')[0]),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                progress,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                'quizzes',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (locked)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock, color: Colors.white, size: 36),
                                SizedBox(height: 10),
                                Text(
                                  'Complete previous\nto unlock',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildCategoriesTab() {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverPadding(
  //         padding: EdgeInsets.all(24),
  //         sliver: SliverGrid(
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             mainAxisSpacing: 16,
  //             crossAxisSpacing: 16,
  //             childAspectRatio: 0.9,
  //           ),
  //           delegate: SliverChildListDelegate([
  //             _buildCategoryTile('General Knowledge', Icons.public, Color(0xFF667eea), '4/5'),
  //             _buildCategoryTile('Technology', Icons.computer, Color(0xFF48BB78), '3/5'),
  //             _buildCategoryTile('Science', Icons.science, Color(0xFFE53E3E), '2/5'),
  //             _buildCategoryTile('History', Icons.history, Color(0xFFDD6B20), '0/5'),
  //             _buildCategoryTile('Geography', Icons.public, Color(0xFF00B5D8), '0/5'),
  //             _buildCategoryTile('Entertainment', Icons.movie, Color(0xFF805AD5), '0/5'),
  //           ]),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildCategoryTile(String title, IconData icon, Color color, String progress) {
  //   return Material(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.circular(20),
  //     elevation: 2,
  //     child: InkWell(
  //       onTap: () {},
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         padding: EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: color.withOpacity(0.1),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Icon(icon, color: color, size: 36),
  //             ),
  //             SizedBox(height: 12),
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w700,
  //                 color: Color(0xFF2D3748),
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(height: 8),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: color.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Text(
  //                 progress,
  //                 style: TextStyle(
  //                   color: color,
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildLeaderboardTab() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'This Week\'s Top Performers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTopPlayer('Sarah', '2450', 2, Color(0xFFC0C0C0)),
                  _buildTopPlayer('John', '2780', 1, Color(0xFFFFD700)),
                  _buildTopPlayer('Mike', '2320', 3, Color(0xFFCD7F32)),
                ],
              ),
              SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return _buildLeaderboardItem(
                    index + 4,
                    'User ${index + 4}',
                    (2300 - (index * 120)).toString(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopPlayer(String name, String score, int position, Color color) {
    double size = position == 1 ? 80.0 : 70.0;
    double fontSize = position == 1 ? 18.0 : 16.0;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '#$position',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        Text(
          score,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF718096),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFF7FAFC),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF718096),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Spacer(),
          Text(
            score,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF667eea),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Achievements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: 16),
              _buildAchievementItem('First Quiz', 'Complete your first quiz', true),
              _buildAchievementItem('Perfect Score', 'Score 5/5 on any quiz', true),
              _buildAchievementItem('Quiz Master', 'Complete 10 quizzes', false),
              _buildAchievementItem('Streak Master', 'Maintain a 7-day streak', false),
              _buildAchievementItem('Category Expert', 'Complete all quizzes in a category', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(String title, String description, bool unlocked) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? Color(0xFFF0FFF4) : Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked ? Color(0xFF48BB78).withOpacity(0.3) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: unlocked ? Color(0xFF48BB78).withOpacity(0.1) : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              unlocked ? Icons.check_circle : Icons.lock_outline,
              color: unlocked ? Color(0xFF48BB78) : Colors.grey,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          if (unlocked)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF48BB78).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '+50 XP',
                style: TextStyle(
                  color: Color(0xFF48BB78),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// class _DashboardScreenState extends State<DashboardScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//
//   int totalQuizzesPlayed = 0;
//   int bestScore = 0;
//   int totalCorrectAnswers = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
//     _fadeController.forward();
//   }
//
//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }
//
//   void _updateStats(int score, int totalQuestions) {
//     setState(() {
//       totalQuizzesPlayed++;
//       if (score > bestScore) bestScore = score;
//       totalCorrectAnswers += score;
//     });
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
//               Color(0xFF4158D0),
//               Color(0xFFC850C0),
//               Color(0xFFFFCC70),
//             ],
//             // colors: [
//             //   Color(0xFF667eea),
//             //   Color(0xFF764ba2),
//             //   Color(0xFFf093fb),
//             // ],
//           ),
//         ),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Padding(
//               padding: EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(),
//                   SizedBox(height: 40),
//                   _buildStatsCards(),
//                   SizedBox(height: 40),
//                   _buildQuizCategories(),
//                   Spacer(),
//                   _buildStartButton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Welcome Back!',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Ready to challenge yourself?',
//           style: TextStyle(
//             color: Colors.white70,
//             fontSize: 18,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatsCards() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: _buildStatCard(
//             'Quizzes Played',
//             '$totalQuizzesPlayed',
//             Icons.quiz,
//             Color(0xFF48BB78),
//           ),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: _buildStatCard(
//             'Best Score',
//             '$bestScore',
//             Icons.star,
//             Color(0xFFFFD700),
//           ),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: _buildStatCard(
//             'Accuracy',
//             totalQuizzesPlayed > 0
//                 ? '${((totalCorrectAnswers / (totalQuizzesPlayed * 5)) * 100).round()}%'
//                 : '0%',
//             Icons.track_changes,
//             Color(0xFFE53E3E),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//             spreadRadius: 0,
//           ),
//         ],
//         border: Border.all(color: Colors.grey.shade100, width: 1.5),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color, size: 28),
//           ),
//           SizedBox(height: 14),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.w800,
//               color: Color(0xFF2D3748),
//               letterSpacing: -0.5,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF718096),
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuizCategories() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Quiz Categories',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 20),
//         Container(
//           height: 120,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               _buildCategoryCard('General Knowledge', Icons.public, Color(0xFF667eea)),
//               _buildCategoryCard('Technology', Icons.computer, Color(0xFF48BB78)),
//               _buildCategoryCard('Science', Icons.science, Color(0xFFE53E3E)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Widget _buildCategoryCard(String title, IconData icon, Color color) {
//   //   return Container(
//   //     width: 140,
//   //     margin: EdgeInsets.only(right: 16),
//   //     padding: EdgeInsets.all(20),
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(20),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black.withOpacity(0.1),
//   //           blurRadius: 15,
//   //           offset: Offset(0, 8),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: [
//   //         Icon(icon, color: color, size: 40),
//   //         SizedBox(height: 12),
//   //         Text(
//   //           title,
//   //           style: TextStyle(
//   //             fontSize: 14,
//   //             fontWeight: FontWeight.w600,
//   //             color: Color(0xFF2D3748),
//   //           ),
//   //           textAlign: TextAlign.center,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildCategoryCard(String title, IconData icon, Color color) {
//     return Container(
//       width: 140,
//       margin: EdgeInsets.only(right: 16),
//       padding: EdgeInsets.all(16), // Reduced from 20 to prevent overflow
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: color, size: 36), // Reduced from 40
//           SizedBox(height: 8), // Reduced from 12
//           Flexible(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 13, // Reduced from 14
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF2D3748),
//               ),
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStartButton() {
//     return Container(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => QuizScreen(
//                 onQuizCompleted: _updateStats,
//               ),
//             ),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Color(0xFF667eea),
//           padding: EdgeInsets.symmetric(vertical: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 10,
//           shadowColor: Colors.black.withOpacity(0.3),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.play_arrow, size: 28),
//             SizedBox(width: 12),
//             Text(
//               'Start Quiz',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class QuizScreen extends StatefulWidget {
  final Function(int score, int totalQuestions) onQuizCompleted;

  QuizScreen({required this.onQuizCompleted});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  int score = 0;
  bool showResult = false;
  bool isAnswered = false;

  // Timer variables
  Timer? _timer;
  int _timeLeft = 30; // 30 seconds per question
  final int _initialTime = 30;

  late AnimationController _progressController;
  late AnimationController _slideController;
  late AnimationController _timerController;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _timerAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the largest planet in our solar system?',
      'answers': ['Mars', 'Jupiter', 'Saturn', 'Neptune'],
      'correctAnswer': 1,
    },
    {
      'question': 'Which programming language is Flutter based on?',
      'answers': ['Java', 'Kotlin', 'Dart', 'Swift'],
      'correctAnswer': 2,
    },
    {
      'question': 'What year was the first iPhone released?',
      'answers': ['2006', '2007', '2008', '2009'],
      'correctAnswer': 1,
    },
    {
      'question': 'Which element has the chemical symbol "O"?',
      'answers': ['Gold', 'Silver', 'Oxygen', 'Iron'],
      'correctAnswer': 2,
    },
    {
      'question': 'What is the capital of Australia?',
      'answers': ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      'correctAnswer': 2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _startTimer();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _timerController = AnimationController(
      duration: Duration(seconds: _initialTime),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _timerAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _timerController,
      curve: Curves.linear,
    ));
  }

  void _startAnimations() {
    _progressController.forward();
    _slideController.forward();
  }

  void _startTimer() {
    _timeLeft = _initialTime;
    _timerController.reset();
    _timerController.forward();

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        timer.cancel();
        if (!isAnswered) {
          _timeUp();
        }
      }
    });
  }

  void _timeUp() {
    HapticFeedback.heavyImpact();
    setState(() {
      isAnswered = true;
    });

    Future.delayed(Duration(milliseconds: 1500), () {
      _nextQuestion();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _slideController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (isAnswered) return;

    _timer?.cancel();
    HapticFeedback.lightImpact();
    setState(() {
      selectedAnswer = index;
      isAnswered = true;
    });

    if (index == questions[currentQuestionIndex]['correctAnswer']) {
      score++;
    }

    Future.delayed(Duration(milliseconds: 1500), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        isAnswered = false;
      });
      _slideController.reset();
      _progressController.reset();
      _startAnimations();
      _startTimer();
    } else {
      widget.onQuizCompleted(score, questions.length);
      setState(() {
        showResult = true;
      });
    }
  }

  void _resetQuiz() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4158D0),
              Color(0xFFC850C0),
              Color(0xFFFFCC70),
            ],
            // colors: [
            //   Color(0xFF667eea),
            //   Color(0xFF764ba2),
            //   Color(0xFFf093fb),
            // ],
          ),
        ),
        child: SafeArea(
          child: showResult ? _buildResultScreen() : _buildQuizScreen(),
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                       MediaQuery.of(context).padding.top -
                       MediaQuery.of(context).padding.bottom - 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20), // Reduced from 30
              _buildTimerWidget(),
              SizedBox(height: 20), // Reduced from 30
              _buildProgressIndicator(),
              SizedBox(height: 30), // Reduced from 40
              _buildQuestionCard(),
              SizedBox(height: 24), // Reduced from 32
              _buildAnswerOptions(),
              SizedBox(height: 20), // Added spacing before bottom info
              _buildBottomInfo(),
              SizedBox(height: 20), // Added bottom padding
            ],
          ),
        ),
      ),
    );
  }
  // Widget _buildQuizScreen() {
  //   return Padding(
  //     padding: EdgeInsets.all(24.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildHeader(),
  //         SizedBox(height: 30),
  //         _buildTimerWidget(),
  //         SizedBox(height: 30),
  //         _buildProgressIndicator(),
  //         SizedBox(height: 40),
  //         _buildQuestionCard(),
  //         SizedBox(height: 32),
  //         _buildAnswerOptions(),
  //         Spacer(),
  //         _buildBottomInfo(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 8),
              Text(
                '$score',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimerWidget() {
    Color timerColor = _timeLeft > 10 ? Colors.white : Colors.red;

    return Center(
      child: Container(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: AnimatedBuilder(
                animation: _timerAnimation,
                builder: (context, child) {
                  return CircularProgressIndicator(
                    value: _timerAnimation.value,
                    strokeWidth: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _timeLeft > 10 ? Colors.white : Colors.red,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: timerColor,
                      size: 24,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$_timeLeft',
                      style: TextStyle(
                        color: timerColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${currentQuestionIndex + 1}/${questions.length}',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white.withOpacity(0.3),
          ),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (currentQuestionIndex + _progressAnimation.value) / questions.length,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.orange],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          questions[currentQuestionIndex]['question'],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3748),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAnswerOptions() {
    return Column(
      children: List.generate(
        questions[currentQuestionIndex]['answers'].length,
            (index) => _buildAnswerOption(index),
      ),
    );
  }

  Widget _buildAnswerOption(int index) {
    final isSelected = selectedAnswer == index;
    final isCorrect = index == questions[currentQuestionIndex]['correctAnswer'];
    final showCorrectAnswer = isAnswered && isCorrect;
    final showWrongAnswer = isAnswered && isSelected && !isCorrect;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.white.withOpacity(0.3);
    Color textColor = Color(0xFF2D3748);
    IconData? icon;

    if (showCorrectAnswer) {
      backgroundColor = Color(0xFF48BB78);
      borderColor = Color(0xFF48BB78);
      textColor = Colors.white;
      icon = Icons.check_circle;
    } else if (showWrongAnswer) {
      backgroundColor = Color(0xFFE53E3E);
      borderColor = Color(0xFFE53E3E);
      textColor = Colors.white;
      icon = Icons.cancel;
    } else if (isSelected) {
      backgroundColor = Color(0xFF667eea).withOpacity(0.1);
      borderColor = Color(0xFF667eea);
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectAnswer(index),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    questions[currentQuestionIndex]['answers'][index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: textColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.yellow, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Choose wisely! Time is running out...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = (score / questions.length * 100).round();
    String resultMessage;
    IconData resultIcon;
    Color resultColor;

    if (percentage >= 80) {
      resultMessage = 'Excellent!';
      resultIcon = Icons.emoji_events;
      resultColor = Color(0xFFFFD700);
    } else if (percentage >= 60) {
      resultMessage = 'Good Job!';
      resultIcon = Icons.thumb_up;
      resultColor = Color(0xFF48BB78);
    } else {
      resultMessage = 'Keep Learning!';
      resultIcon = Icons.school;
      resultColor = Color(0xFF667eea);
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    resultIcon,
                    size: 80,
                    color: resultColor,
                  ),
                  SizedBox(height: 24),
                  Text(
                    resultMessage,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'You scored $score out of ${questions.length}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF718096),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _resetQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF718096),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentQuestionIndex = 0;
                              selectedAnswer = null;
                              score = 0;
                              showResult = false;
                              isAnswered = false;
                            });
                            _slideController.reset();
                            _progressController.reset();
                            _startAnimations();
                            _startTimer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF667eea),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Play Again',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}