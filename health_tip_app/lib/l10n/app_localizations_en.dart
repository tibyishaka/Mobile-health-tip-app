// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Health Tips';

  @override
  String get cancel => 'Cancel';

  @override
  String get healthCareTips => 'Health Care Tips';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get orSignInWith => 'Or sign in with';

  @override
  String get orSignUpWith => 'Or sign up with';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get apple => 'Apple';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get pleaseVerifyEmail => 'Please verify your email before logging in.';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String get verificationEmailSent => 'Verification email sent!';

  @override
  String get accountCreated =>
      'Account created! Please check your email to verify your account.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordDesc =>
      'Enter the email address linked to your account. We\'ll send you a link to reset your password.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get enterEmailFirst => 'Please enter your email address.';

  @override
  String get enterValidEmailFirst => 'Please enter a valid email address.';

  @override
  String resetEmailSent(String email) {
    return 'Password reset link sent to $email.\nCheck your inbox (and spam folder).';
  }

  @override
  String get noAccountFound => 'No account found with that email address.';

  @override
  String get emailInvalid => 'The email address is not valid.';

  @override
  String get tooManyRequests => 'Too many attempts. Please try again later.';

  @override
  String get failedToSendReset => 'Failed to send reset email.';

  @override
  String get selectInterests => 'Select Your Interests';

  @override
  String get chooseTopicsDesc =>
      'Choose topics that interest you to customize your app experience';

  @override
  String get getStarted => 'Get Started';

  @override
  String get topicNutrition => 'Nutrition';

  @override
  String get topicSleep => 'Sleep';

  @override
  String get topicFitness => 'Fitness';

  @override
  String get topicMentalHealth => 'Mental Health';

  @override
  String get topicStressManagement => 'Stress Management';

  @override
  String get topicMindfulness => 'Mindfulness';

  @override
  String get navHome => 'Home';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navDailyTips => 'Daily Tips';

  @override
  String get navSettings => 'Settings';

  @override
  String get article1Title => 'Mindful Eating for Stress Reduction';

  @override
  String get article1Desc =>
      'Learn how to eat more mindfully to reduce stress and improve your overall well-being.';

  @override
  String get article1ReadTime => '5 min read';

  @override
  String get article2Title => 'Quick Morning Yoga Routine';

  @override
  String get article2Desc =>
      'Start your day with this energizing yoga routine to boost your mood and focus.';

  @override
  String get article2ReadTime => '7 min read';

  @override
  String get article3Title => 'Hydration Habits for Better Health';

  @override
  String get article3Desc =>
      'Discover simple ways to stay hydrated throughout the day for optimal health.';

  @override
  String get article3ReadTime => '6 min read';

  @override
  String get searchTopicsHint => 'Search for topics';

  @override
  String get noMatchingTopics => 'No matching topics found';

  @override
  String topicComingSoon(String topic) {
    return '$topic details coming soon';
  }

  @override
  String get discoverNutritionKeywords => 'diet food healthy eating meal';

  @override
  String get discoverSleepKeywords => 'rest bedtime insomnia night';

  @override
  String get discoverFitnessKeywords => 'exercise workout training gym';

  @override
  String get discoverMentalHealthKeywords => 'mind wellbeing emotion anxiety';

  @override
  String get discoverStressKeywords => 'stress calm relax coping';

  @override
  String get discoverMindfulnessKeywords =>
      'meditation present awareness focus';

  @override
  String get tipOfTheDay => 'Tip of the Day';

  @override
  String get healthCategory => 'Health';

  @override
  String get dailyTipTitle => 'Prioritize Sleep for Optimal Health';

  @override
  String get dailyTipDesc =>
      'Aim for 7-9 hours of quality sleep each night to support physical and mental well-being. Consistent sleep patterns can improve mood, focus, and overall health.';

  @override
  String get remindMe => 'Remind Me';

  @override
  String get remindMeSubtitle =>
      'Get a daily notification to check your tip of the day.';

  @override
  String get remindersEnabled =>
      '🔔 Daily reminders enabled! You\'ll be notified every day.';

  @override
  String get remindersDisabled => '🔕 Daily reminders disabled.';

  @override
  String get reminderBannerText =>
      'You\'ll receive a daily reminder to check your health tip.';

  @override
  String get notifications => 'Notifications';

  @override
  String get newTips => 'New tips';

  @override
  String get newTipsDesc => 'Get notified about new health tips';

  @override
  String get newFeatures => 'New features';

  @override
  String get newFeaturesDesc => 'Get notified when new features are added';

  @override
  String get updatesLabel => 'Updates';

  @override
  String get updatesDesc => 'Get notified about app updates';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get themeDesc => 'Choose your preferred theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get languageDesc => 'Select your preferred language';

  @override
  String get logOut => 'Log Out';

  @override
  String get loggingOut => 'Logging out…';

  @override
  String get logOutConfirmTitle => 'Log Out';

  @override
  String get logOutConfirmBody => 'Are you sure you want to log out?';

  @override
  String logoutFailed(String error) {
    return 'Logout failed: $error';
  }

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get searchFitnessHint => 'Search fitness tips…';

  @override
  String get searchMentalHealthHint => 'Search mental health tips…';

  @override
  String get searchStressHint => 'Search stress tips…';

  @override
  String get searchNutritionHint => 'Search nutrition tips…';

  @override
  String get searchSleepHint => 'Search sleep tips…';

  @override
  String get searchMindfulnessHint => 'Search mindfulness tips…';

  @override
  String noResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String searchResultsCount(num count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results for \"$query\"',
      one: '1 result for \"$query\"',
    );
    return '$_temp0';
  }

  @override
  String get noTipsFound => 'No tips found.';

  @override
  String get tryDifferentKeyword => 'Try a different search term.';

  @override
  String get fitnessTip1Title => 'Start with warm-up';

  @override
  String get fitnessTip1Desc =>
      'Always begin your workout with 5-10 minutes of light cardio and dynamic stretches to prevent injuries.';

  @override
  String get fitnessTip2Title => 'Strength training basics';

  @override
  String get fitnessTip2Desc =>
      'Incorporate strength training 2-3 times per week focusing on major muscle groups for balanced development.';

  @override
  String get fitnessTip3Title => 'Cardio for heart health';

  @override
  String get fitnessTip3Desc =>
      'Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.';

  @override
  String get fitnessTip4Title => 'Rest and recovery';

  @override
  String get fitnessTip4Desc =>
      'Take rest days between intense workouts to allow muscles to repair and grow stronger.';

  @override
  String get fitnessTip5Title => 'Proper form matters';

  @override
  String get fitnessTip5Desc =>
      'Focus on correct form rather than heavy weights to maximize results and prevent injuries.';

  @override
  String get fitnessTip6Title => 'Stay consistent';

  @override
  String get fitnessTip6Desc =>
      'Create a workout schedule that you can maintain long-term rather than occasional intense sessions.';

  @override
  String get mentalTip1Title => 'Practice mindfulness';

  @override
  String get mentalTip1Desc =>
      'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.';

  @override
  String get mentalTip2Title => 'Digital detox';

  @override
  String get mentalTip2Desc =>
      'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.';

  @override
  String get mentalTip3Title => 'Gratitude journaling';

  @override
  String get mentalTip3Desc =>
      'Write down three things you\'re grateful for each day to cultivate a positive mindset.';

  @override
  String get mentalTip4Title => 'Connect with others';

  @override
  String get mentalTip4Desc =>
      'Maintain strong social connections by regularly reaching out to friends and family.';

  @override
  String get mentalTip5Title => 'Self-care routine';

  @override
  String get mentalTip5Desc =>
      'Establish a daily self-care routine that includes activities that nourish your mental well-being.';

  @override
  String get mentalTip6Title => 'Limit negative thoughts';

  @override
  String get mentalTip6Desc =>
      'Challenge negative self-talk and replace it with positive affirmations.';

  @override
  String get mentalTip7Title => 'Seek professional help';

  @override
  String get mentalTip7Desc =>
      'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.';

  @override
  String get stressTip1Title => 'Deep breathing exercises';

  @override
  String get stressTip1Desc =>
      'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.';

  @override
  String get stressTip2Title => 'Time management';

  @override
  String get stressTip2Desc =>
      'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.';

  @override
  String get stressTip3Title => 'Physical activity';

  @override
  String get stressTip3Desc =>
      'Regular exercise releases endorphins and helps reduce stress levels naturally.';

  @override
  String get stressTip4Title => 'Progressive muscle relaxation';

  @override
  String get stressTip4Desc =>
      'Tense and then relax each muscle group to release physical tension caused by stress.';

  @override
  String get stressTip5Title => 'Set boundaries';

  @override
  String get stressTip5Desc =>
      'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.';

  @override
  String get stressTip6Title => 'Mindful walking';

  @override
  String get stressTip6Desc =>
      'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.';

  @override
  String get stressTip7Title => 'Listen to music';

  @override
  String get stressTip7Desc =>
      'Play calming music or nature sounds to reduce stress and improve your mood.';

  @override
  String get stressTip8Title => 'Aromatherapy';

  @override
  String get stressTip8Desc =>
      'Use essential oils like lavender or chamomile to create a calming environment.';

  @override
  String get nutritionTip1Title => 'Increase fiber intake';

  @override
  String get nutritionTip1Desc =>
      'Fiber helps regulate digestion and keeps you feeling full longer. Include fruits, vegetables, legumes, and whole grains in your daily meals.';

  @override
  String get nutritionTip2Title => 'Build balanced meals';

  @override
  String get nutritionTip2Desc =>
      'Fill your plate with vegetables, lean protein, healthy fats, and complex carbs to ensure you get all the nutrients your body needs.';

  @override
  String get nutritionTip3Title => 'Stay hydrated';

  @override
  String get nutritionTip3Desc =>
      'Drink water consistently throughout the day to support energy, focus, and overall body function. Aim for at least 8 glasses daily.';

  @override
  String get nutritionTip4Title => 'Choose whole grains';

  @override
  String get nutritionTip4Desc =>
      'Prefer whole grains like oats, brown rice, and quinoa over refined grains for lasting energy and improved digestive health.';

  @override
  String get nutritionTip5Title => 'Eat more fruits and vegetables';

  @override
  String get nutritionTip5Desc =>
      'Aim for at least five servings of fruits and vegetables a day to supply your body with essential vitamins, minerals, and antioxidants.';

  @override
  String get nutritionTip6Title => 'Limit processed foods';

  @override
  String get nutritionTip6Desc =>
      'Reduce your intake of ultra-processed snacks and fast food, which are often high in sugar, sodium, and unhealthy fats.';

  @override
  String get nutritionTip7Title => 'Control portion sizes';

  @override
  String get nutritionTip7Desc =>
      'Be mindful of how much you eat at each meal. Using smaller plates and eating slowly can help prevent overeating.';

  @override
  String get nutritionTip8Title => 'Include healthy fats';

  @override
  String get nutritionTip8Desc =>
      'Incorporate sources of healthy fats such as avocados, nuts, seeds, and olive oil to support brain health and hormone production.';

  @override
  String get nutritionTip9Title => 'Prioritise lean protein';

  @override
  String get nutritionTip9Desc =>
      'Choose lean protein sources like chicken, fish, tofu, eggs, and legumes to support muscle repair and keep you satiated.';

  @override
  String get nutritionTip10Title => 'Reduce added sugar';

  @override
  String get nutritionTip10Desc =>
      'Cut back on sugary drinks, desserts, and packaged foods. Excess sugar can lead to weight gain, energy crashes, and inflammation.';

  @override
  String get sleepTip1Title => 'Establish a bedtime routine';

  @override
  String get sleepTip1Desc =>
      'Go to bed and wake up at the same time daily, including weekends.';

  @override
  String get sleepTip2Title => 'Limit screen time before bed';

  @override
  String get sleepTip2Desc =>
      'Avoid screens at least one hour before sleep to reduce blue light exposure.';

  @override
  String get sleepTip3Title => 'Create a wind-down routine';

  @override
  String get sleepTip3Desc =>
      'Use calming habits like light stretching or reading before bedtime.';

  @override
  String get sleepTip4Title => 'Keep your room cool';

  @override
  String get sleepTip4Desc =>
      'A cool, dark room helps you fall asleep faster and sleep more deeply.';

  @override
  String get sleepTip5Title => 'Try deep breathing exercises';

  @override
  String get sleepTip5Desc =>
      'Slow, deep breaths before bed activate the parasympathetic nervous system and promote relaxation.';

  @override
  String get sleepTip6Title => 'Avoid caffeine late in the day';

  @override
  String get sleepTip6Desc =>
      'Caffeine can stay in your system for 6-8 hours, so avoid it after 2 PM for better sleep quality.';

  @override
  String get sleepTip7Title => 'Keep a sleep journal';

  @override
  String get sleepTip7Desc =>
      'Track your sleep patterns and habits to identify what helps or hinders your rest.';

  @override
  String get sleepTip8Title => 'Limit naps during the day';

  @override
  String get sleepTip8Desc =>
      'If you must nap, keep it under 30 minutes and avoid napping late in the afternoon.';

  @override
  String get mindfulnessTip1Title => 'Practice deep breathing';

  @override
  String get mindfulnessTip1Desc =>
      'Take slow, deep breaths for a few minutes to calm the mind and body.';

  @override
  String get mindfulnessTip2Title => 'Try meditation';

  @override
  String get mindfulnessTip2Desc =>
      'Begin with five minutes daily and gradually increase your practice time.';

  @override
  String get mindfulnessTip3Title => 'Journal your thoughts';

  @override
  String get mindfulnessTip3Desc =>
      'Write down thoughts and emotions to increase awareness and reduce stress.';

  @override
  String get mindfulnessTip4Title => 'Be present in the moment';

  @override
  String get mindfulnessTip4Desc =>
      'Focus on what you can see, hear, and feel without judging the experience.';

  @override
  String get mindfulnessTip5Title => 'Mindful walking';

  @override
  String get mindfulnessTip5Desc =>
      'Walk slowly and pay close attention to each step, your breath, and your surroundings.';

  @override
  String get mindfulnessTip6Title => 'Observe your thoughts';

  @override
  String get mindfulnessTip6Desc =>
      'Notice your thoughts as they arise without attaching to them — let them pass like clouds.';

  @override
  String get mindfulnessTip7Title => 'Body scan relaxation';

  @override
  String get mindfulnessTip7Desc =>
      'Slowly move your attention through each part of your body, releasing tension as you go.';

  @override
  String get mindfulnessTip8Title => 'Single-tasking';

  @override
  String get mindfulnessTip8Desc =>
      'Focus on one task at a time with full attention instead of multitasking throughout the day.';
}
