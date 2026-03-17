import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Tips'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @healthCareTips.
  ///
  /// In en, this message translates to:
  /// **'Health Care Tips'**
  String get healthCareTips;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get orSignInWith;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get orSignUpWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @pleaseVerifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before logging in.'**
  String get pleaseVerifyEmail;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent!'**
  String get verificationEmailSent;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created! Please check your email to verify your account.'**
  String get accountCreated;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address linked to your account. We\'ll send you a link to reset your password.'**
  String get resetPasswordDesc;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @enterEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address.'**
  String get enterEmailFirst;

  /// No description provided for @enterValidEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get enterValidEmailFirst;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to {email}.\nCheck your inbox (and spam folder).'**
  String resetEmailSent(String email);

  /// No description provided for @noAccountFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with that email address.'**
  String get noAccountFound;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid.'**
  String get emailInvalid;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get tooManyRequests;

  /// No description provided for @failedToSendReset.
  ///
  /// In en, this message translates to:
  /// **'Failed to send reset email.'**
  String get failedToSendReset;

  /// No description provided for @selectInterests.
  ///
  /// In en, this message translates to:
  /// **'Select Your Interests'**
  String get selectInterests;

  /// No description provided for @chooseTopicsDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose topics that interest you to customize your app experience'**
  String get chooseTopicsDesc;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @topicNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get topicNutrition;

  /// No description provided for @topicSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get topicSleep;

  /// No description provided for @topicFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get topicFitness;

  /// No description provided for @topicMentalHealth.
  ///
  /// In en, this message translates to:
  /// **'Mental Health'**
  String get topicMentalHealth;

  /// No description provided for @topicStressManagement.
  ///
  /// In en, this message translates to:
  /// **'Stress Management'**
  String get topicStressManagement;

  /// No description provided for @topicMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get topicMindfulness;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navDailyTips.
  ///
  /// In en, this message translates to:
  /// **'Daily Tips'**
  String get navDailyTips;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @article1Title.
  ///
  /// In en, this message translates to:
  /// **'Mindful Eating for Stress Reduction'**
  String get article1Title;

  /// No description provided for @article1Desc.
  ///
  /// In en, this message translates to:
  /// **'Learn how to eat more mindfully to reduce stress and improve your overall well-being.'**
  String get article1Desc;

  /// No description provided for @article1ReadTime.
  ///
  /// In en, this message translates to:
  /// **'5 min read'**
  String get article1ReadTime;

  /// No description provided for @article2Title.
  ///
  /// In en, this message translates to:
  /// **'Quick Morning Yoga Routine'**
  String get article2Title;

  /// No description provided for @article2Desc.
  ///
  /// In en, this message translates to:
  /// **'Start your day with this energizing yoga routine to boost your mood and focus.'**
  String get article2Desc;

  /// No description provided for @article2ReadTime.
  ///
  /// In en, this message translates to:
  /// **'7 min read'**
  String get article2ReadTime;

  /// No description provided for @article3Title.
  ///
  /// In en, this message translates to:
  /// **'Hydration Habits for Better Health'**
  String get article3Title;

  /// No description provided for @article3Desc.
  ///
  /// In en, this message translates to:
  /// **'Discover simple ways to stay hydrated throughout the day for optimal health.'**
  String get article3Desc;

  /// No description provided for @article3ReadTime.
  ///
  /// In en, this message translates to:
  /// **'6 min read'**
  String get article3ReadTime;

  /// No description provided for @searchTopicsHint.
  ///
  /// In en, this message translates to:
  /// **'Search for topics'**
  String get searchTopicsHint;

  /// No description provided for @noMatchingTopics.
  ///
  /// In en, this message translates to:
  /// **'No matching topics found'**
  String get noMatchingTopics;

  /// No description provided for @topicComingSoon.
  ///
  /// In en, this message translates to:
  /// **'{topic} details coming soon'**
  String topicComingSoon(String topic);

  /// No description provided for @discoverNutritionKeywords.
  ///
  /// In en, this message translates to:
  /// **'diet food healthy eating meal'**
  String get discoverNutritionKeywords;

  /// No description provided for @discoverSleepKeywords.
  ///
  /// In en, this message translates to:
  /// **'rest bedtime insomnia night'**
  String get discoverSleepKeywords;

  /// No description provided for @discoverFitnessKeywords.
  ///
  /// In en, this message translates to:
  /// **'exercise workout training gym'**
  String get discoverFitnessKeywords;

  /// No description provided for @discoverMentalHealthKeywords.
  ///
  /// In en, this message translates to:
  /// **'mind wellbeing emotion anxiety'**
  String get discoverMentalHealthKeywords;

  /// No description provided for @discoverStressKeywords.
  ///
  /// In en, this message translates to:
  /// **'stress calm relax coping'**
  String get discoverStressKeywords;

  /// No description provided for @discoverMindfulnessKeywords.
  ///
  /// In en, this message translates to:
  /// **'meditation present awareness focus'**
  String get discoverMindfulnessKeywords;

  /// No description provided for @tipOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Tip of the Day'**
  String get tipOfTheDay;

  /// No description provided for @healthCategory.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get healthCategory;

  /// No description provided for @dailyTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Prioritize Sleep for Optimal Health'**
  String get dailyTipTitle;

  /// No description provided for @dailyTipDesc.
  ///
  /// In en, this message translates to:
  /// **'Aim for 7-9 hours of quality sleep each night to support physical and mental well-being. Consistent sleep patterns can improve mood, focus, and overall health.'**
  String get dailyTipDesc;

  /// No description provided for @remindMe.
  ///
  /// In en, this message translates to:
  /// **'Remind Me'**
  String get remindMe;

  /// No description provided for @remindMeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get a daily notification to check your tip of the day.'**
  String get remindMeSubtitle;

  /// No description provided for @remindersEnabled.
  ///
  /// In en, this message translates to:
  /// **'🔔 Daily reminders enabled! You\'ll be notified every day.'**
  String get remindersEnabled;

  /// No description provided for @remindersDisabled.
  ///
  /// In en, this message translates to:
  /// **'🔕 Daily reminders disabled.'**
  String get remindersDisabled;

  /// No description provided for @reminderBannerText.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive a daily reminder to check your health tip.'**
  String get reminderBannerText;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @newTips.
  ///
  /// In en, this message translates to:
  /// **'New tips'**
  String get newTips;

  /// No description provided for @newTipsDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified about new health tips'**
  String get newTipsDesc;

  /// No description provided for @newFeatures.
  ///
  /// In en, this message translates to:
  /// **'New features'**
  String get newFeatures;

  /// No description provided for @newFeaturesDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified when new features are added'**
  String get newFeaturesDesc;

  /// No description provided for @updatesLabel.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updatesLabel;

  /// No description provided for @updatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified about app updates'**
  String get updatesDesc;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get themeDesc;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDesc.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get languageDesc;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out…'**
  String get loggingOut;

  /// No description provided for @logOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOutConfirmTitle;

  /// No description provided for @logOutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutConfirmBody;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed: {error}'**
  String logoutFailed(String error);

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSince(String date);

  /// No description provided for @searchFitnessHint.
  ///
  /// In en, this message translates to:
  /// **'Search fitness tips…'**
  String get searchFitnessHint;

  /// No description provided for @searchMentalHealthHint.
  ///
  /// In en, this message translates to:
  /// **'Search mental health tips…'**
  String get searchMentalHealthHint;

  /// No description provided for @searchStressHint.
  ///
  /// In en, this message translates to:
  /// **'Search stress tips…'**
  String get searchStressHint;

  /// No description provided for @searchNutritionHint.
  ///
  /// In en, this message translates to:
  /// **'Search nutrition tips…'**
  String get searchNutritionHint;

  /// No description provided for @searchSleepHint.
  ///
  /// In en, this message translates to:
  /// **'Search sleep tips…'**
  String get searchSleepHint;

  /// No description provided for @searchMindfulnessHint.
  ///
  /// In en, this message translates to:
  /// **'Search mindfulness tips…'**
  String get searchMindfulnessHint;

  /// No description provided for @noResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String noResultsFor(String query);

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result for \"{query}\"} other{{count} results for \"{query}\"}}'**
  String searchResultsCount(num count, String query);

  /// No description provided for @noTipsFound.
  ///
  /// In en, this message translates to:
  /// **'No tips found.'**
  String get noTipsFound;

  /// No description provided for @tryDifferentKeyword.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term.'**
  String get tryDifferentKeyword;

  /// No description provided for @fitnessTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Start with warm-up'**
  String get fitnessTip1Title;

  /// No description provided for @fitnessTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Always begin your workout with 5-10 minutes of light cardio and dynamic stretches to prevent injuries.'**
  String get fitnessTip1Desc;

  /// No description provided for @fitnessTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Strength training basics'**
  String get fitnessTip2Title;

  /// No description provided for @fitnessTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Incorporate strength training 2-3 times per week focusing on major muscle groups for balanced development.'**
  String get fitnessTip2Desc;

  /// No description provided for @fitnessTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Cardio for heart health'**
  String get fitnessTip3Title;

  /// No description provided for @fitnessTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.'**
  String get fitnessTip3Desc;

  /// No description provided for @fitnessTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Rest and recovery'**
  String get fitnessTip4Title;

  /// No description provided for @fitnessTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'Take rest days between intense workouts to allow muscles to repair and grow stronger.'**
  String get fitnessTip4Desc;

  /// No description provided for @fitnessTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Proper form matters'**
  String get fitnessTip5Title;

  /// No description provided for @fitnessTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Focus on correct form rather than heavy weights to maximize results and prevent injuries.'**
  String get fitnessTip5Desc;

  /// No description provided for @fitnessTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Stay consistent'**
  String get fitnessTip6Title;

  /// No description provided for @fitnessTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Create a workout schedule that you can maintain long-term rather than occasional intense sessions.'**
  String get fitnessTip6Desc;

  /// No description provided for @mentalTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Practice mindfulness'**
  String get mentalTip1Title;

  /// No description provided for @mentalTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.'**
  String get mentalTip1Desc;

  /// No description provided for @mentalTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Digital detox'**
  String get mentalTip2Title;

  /// No description provided for @mentalTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.'**
  String get mentalTip2Desc;

  /// No description provided for @mentalTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Gratitude journaling'**
  String get mentalTip3Title;

  /// No description provided for @mentalTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Write down three things you\'re grateful for each day to cultivate a positive mindset.'**
  String get mentalTip3Desc;

  /// No description provided for @mentalTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Connect with others'**
  String get mentalTip4Title;

  /// No description provided for @mentalTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain strong social connections by regularly reaching out to friends and family.'**
  String get mentalTip4Desc;

  /// No description provided for @mentalTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Self-care routine'**
  String get mentalTip5Title;

  /// No description provided for @mentalTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Establish a daily self-care routine that includes activities that nourish your mental well-being.'**
  String get mentalTip5Desc;

  /// No description provided for @mentalTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Limit negative thoughts'**
  String get mentalTip6Title;

  /// No description provided for @mentalTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Challenge negative self-talk and replace it with positive affirmations.'**
  String get mentalTip6Desc;

  /// No description provided for @mentalTip7Title.
  ///
  /// In en, this message translates to:
  /// **'Seek professional help'**
  String get mentalTip7Title;

  /// No description provided for @mentalTip7Desc.
  ///
  /// In en, this message translates to:
  /// **'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.'**
  String get mentalTip7Desc;

  /// No description provided for @stressTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Deep breathing exercises'**
  String get stressTip1Title;

  /// No description provided for @stressTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.'**
  String get stressTip1Desc;

  /// No description provided for @stressTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Time management'**
  String get stressTip2Title;

  /// No description provided for @stressTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.'**
  String get stressTip2Desc;

  /// No description provided for @stressTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Physical activity'**
  String get stressTip3Title;

  /// No description provided for @stressTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Regular exercise releases endorphins and helps reduce stress levels naturally.'**
  String get stressTip3Desc;

  /// No description provided for @stressTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Progressive muscle relaxation'**
  String get stressTip4Title;

  /// No description provided for @stressTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'Tense and then relax each muscle group to release physical tension caused by stress.'**
  String get stressTip4Desc;

  /// No description provided for @stressTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Set boundaries'**
  String get stressTip5Title;

  /// No description provided for @stressTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.'**
  String get stressTip5Desc;

  /// No description provided for @stressTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Mindful walking'**
  String get stressTip6Title;

  /// No description provided for @stressTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.'**
  String get stressTip6Desc;

  /// No description provided for @stressTip7Title.
  ///
  /// In en, this message translates to:
  /// **'Listen to music'**
  String get stressTip7Title;

  /// No description provided for @stressTip7Desc.
  ///
  /// In en, this message translates to:
  /// **'Play calming music or nature sounds to reduce stress and improve your mood.'**
  String get stressTip7Desc;

  /// No description provided for @stressTip8Title.
  ///
  /// In en, this message translates to:
  /// **'Aromatherapy'**
  String get stressTip8Title;

  /// No description provided for @stressTip8Desc.
  ///
  /// In en, this message translates to:
  /// **'Use essential oils like lavender or chamomile to create a calming environment.'**
  String get stressTip8Desc;

  /// No description provided for @nutritionTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Increase fiber intake'**
  String get nutritionTip1Title;

  /// No description provided for @nutritionTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Fiber helps regulate digestion and keeps you feeling full longer. Include fruits, vegetables, legumes, and whole grains in your daily meals.'**
  String get nutritionTip1Desc;

  /// No description provided for @nutritionTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Build balanced meals'**
  String get nutritionTip2Title;

  /// No description provided for @nutritionTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Fill your plate with vegetables, lean protein, healthy fats, and complex carbs to ensure you get all the nutrients your body needs.'**
  String get nutritionTip2Desc;

  /// No description provided for @nutritionTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated'**
  String get nutritionTip3Title;

  /// No description provided for @nutritionTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Drink water consistently throughout the day to support energy, focus, and overall body function. Aim for at least 8 glasses daily.'**
  String get nutritionTip3Desc;

  /// No description provided for @nutritionTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Choose whole grains'**
  String get nutritionTip4Title;

  /// No description provided for @nutritionTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'Prefer whole grains like oats, brown rice, and quinoa over refined grains for lasting energy and improved digestive health.'**
  String get nutritionTip4Desc;

  /// No description provided for @nutritionTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Eat more fruits and vegetables'**
  String get nutritionTip5Title;

  /// No description provided for @nutritionTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Aim for at least five servings of fruits and vegetables a day to supply your body with essential vitamins, minerals, and antioxidants.'**
  String get nutritionTip5Desc;

  /// No description provided for @nutritionTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Limit processed foods'**
  String get nutritionTip6Title;

  /// No description provided for @nutritionTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Reduce your intake of ultra-processed snacks and fast food, which are often high in sugar, sodium, and unhealthy fats.'**
  String get nutritionTip6Desc;

  /// No description provided for @nutritionTip7Title.
  ///
  /// In en, this message translates to:
  /// **'Control portion sizes'**
  String get nutritionTip7Title;

  /// No description provided for @nutritionTip7Desc.
  ///
  /// In en, this message translates to:
  /// **'Be mindful of how much you eat at each meal. Using smaller plates and eating slowly can help prevent overeating.'**
  String get nutritionTip7Desc;

  /// No description provided for @nutritionTip8Title.
  ///
  /// In en, this message translates to:
  /// **'Include healthy fats'**
  String get nutritionTip8Title;

  /// No description provided for @nutritionTip8Desc.
  ///
  /// In en, this message translates to:
  /// **'Incorporate sources of healthy fats such as avocados, nuts, seeds, and olive oil to support brain health and hormone production.'**
  String get nutritionTip8Desc;

  /// No description provided for @nutritionTip9Title.
  ///
  /// In en, this message translates to:
  /// **'Prioritise lean protein'**
  String get nutritionTip9Title;

  /// No description provided for @nutritionTip9Desc.
  ///
  /// In en, this message translates to:
  /// **'Choose lean protein sources like chicken, fish, tofu, eggs, and legumes to support muscle repair and keep you satiated.'**
  String get nutritionTip9Desc;

  /// No description provided for @nutritionTip10Title.
  ///
  /// In en, this message translates to:
  /// **'Reduce added sugar'**
  String get nutritionTip10Title;

  /// No description provided for @nutritionTip10Desc.
  ///
  /// In en, this message translates to:
  /// **'Cut back on sugary drinks, desserts, and packaged foods. Excess sugar can lead to weight gain, energy crashes, and inflammation.'**
  String get nutritionTip10Desc;

  /// No description provided for @sleepTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Establish a bedtime routine'**
  String get sleepTip1Title;

  /// No description provided for @sleepTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Go to bed and wake up at the same time daily, including weekends.'**
  String get sleepTip1Desc;

  /// No description provided for @sleepTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Limit screen time before bed'**
  String get sleepTip2Title;

  /// No description provided for @sleepTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Avoid screens at least one hour before sleep to reduce blue light exposure.'**
  String get sleepTip2Desc;

  /// No description provided for @sleepTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Create a wind-down routine'**
  String get sleepTip3Title;

  /// No description provided for @sleepTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Use calming habits like light stretching or reading before bedtime.'**
  String get sleepTip3Desc;

  /// No description provided for @sleepTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Keep your room cool'**
  String get sleepTip4Title;

  /// No description provided for @sleepTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'A cool, dark room helps you fall asleep faster and sleep more deeply.'**
  String get sleepTip4Desc;

  /// No description provided for @sleepTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Try deep breathing exercises'**
  String get sleepTip5Title;

  /// No description provided for @sleepTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Slow, deep breaths before bed activate the parasympathetic nervous system and promote relaxation.'**
  String get sleepTip5Desc;

  /// No description provided for @sleepTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Avoid caffeine late in the day'**
  String get sleepTip6Title;

  /// No description provided for @sleepTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Caffeine can stay in your system for 6-8 hours, so avoid it after 2 PM for better sleep quality.'**
  String get sleepTip6Desc;

  /// No description provided for @sleepTip7Title.
  ///
  /// In en, this message translates to:
  /// **'Keep a sleep journal'**
  String get sleepTip7Title;

  /// No description provided for @sleepTip7Desc.
  ///
  /// In en, this message translates to:
  /// **'Track your sleep patterns and habits to identify what helps or hinders your rest.'**
  String get sleepTip7Desc;

  /// No description provided for @sleepTip8Title.
  ///
  /// In en, this message translates to:
  /// **'Limit naps during the day'**
  String get sleepTip8Title;

  /// No description provided for @sleepTip8Desc.
  ///
  /// In en, this message translates to:
  /// **'If you must nap, keep it under 30 minutes and avoid napping late in the afternoon.'**
  String get sleepTip8Desc;

  /// No description provided for @mindfulnessTip1Title.
  ///
  /// In en, this message translates to:
  /// **'Practice deep breathing'**
  String get mindfulnessTip1Title;

  /// No description provided for @mindfulnessTip1Desc.
  ///
  /// In en, this message translates to:
  /// **'Take slow, deep breaths for a few minutes to calm the mind and body.'**
  String get mindfulnessTip1Desc;

  /// No description provided for @mindfulnessTip2Title.
  ///
  /// In en, this message translates to:
  /// **'Try meditation'**
  String get mindfulnessTip2Title;

  /// No description provided for @mindfulnessTip2Desc.
  ///
  /// In en, this message translates to:
  /// **'Begin with five minutes daily and gradually increase your practice time.'**
  String get mindfulnessTip2Desc;

  /// No description provided for @mindfulnessTip3Title.
  ///
  /// In en, this message translates to:
  /// **'Journal your thoughts'**
  String get mindfulnessTip3Title;

  /// No description provided for @mindfulnessTip3Desc.
  ///
  /// In en, this message translates to:
  /// **'Write down thoughts and emotions to increase awareness and reduce stress.'**
  String get mindfulnessTip3Desc;

  /// No description provided for @mindfulnessTip4Title.
  ///
  /// In en, this message translates to:
  /// **'Be present in the moment'**
  String get mindfulnessTip4Title;

  /// No description provided for @mindfulnessTip4Desc.
  ///
  /// In en, this message translates to:
  /// **'Focus on what you can see, hear, and feel without judging the experience.'**
  String get mindfulnessTip4Desc;

  /// No description provided for @mindfulnessTip5Title.
  ///
  /// In en, this message translates to:
  /// **'Mindful walking'**
  String get mindfulnessTip5Title;

  /// No description provided for @mindfulnessTip5Desc.
  ///
  /// In en, this message translates to:
  /// **'Walk slowly and pay close attention to each step, your breath, and your surroundings.'**
  String get mindfulnessTip5Desc;

  /// No description provided for @mindfulnessTip6Title.
  ///
  /// In en, this message translates to:
  /// **'Observe your thoughts'**
  String get mindfulnessTip6Title;

  /// No description provided for @mindfulnessTip6Desc.
  ///
  /// In en, this message translates to:
  /// **'Notice your thoughts as they arise without attaching to them — let them pass like clouds.'**
  String get mindfulnessTip6Desc;

  /// No description provided for @mindfulnessTip7Title.
  ///
  /// In en, this message translates to:
  /// **'Body scan relaxation'**
  String get mindfulnessTip7Title;

  /// No description provided for @mindfulnessTip7Desc.
  ///
  /// In en, this message translates to:
  /// **'Slowly move your attention through each part of your body, releasing tension as you go.'**
  String get mindfulnessTip7Desc;

  /// No description provided for @mindfulnessTip8Title.
  ///
  /// In en, this message translates to:
  /// **'Single-tasking'**
  String get mindfulnessTip8Title;

  /// No description provided for @mindfulnessTip8Desc.
  ///
  /// In en, this message translates to:
  /// **'Focus on one task at a time with full attention instead of multitasking throughout the day.'**
  String get mindfulnessTip8Desc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
