// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Conseils Santé';

  @override
  String get cancel => 'Annuler';

  @override
  String get healthCareTips => 'Conseils de Santé';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get name => 'Nom';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get orSignInWith => 'Ou se connecter avec';

  @override
  String get orSignUpWith => 'Ou s\'inscrire avec';

  @override
  String get dontHaveAccount => 'Pas encore de compte ?';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get continueWithApple => 'Continuer avec Apple';

  @override
  String get apple => 'Apple';

  @override
  String get emailRequired => 'L\'e-mail est requis';

  @override
  String get enterValidEmail => 'Entrez un e-mail valide';

  @override
  String get passwordRequired => 'Le mot de passe est requis';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit comporter au moins 6 caractères';

  @override
  String get nameRequired => 'Le nom est requis';

  @override
  String get pleaseVerifyEmail =>
      'Veuillez vérifier votre e-mail avant de vous connecter.';

  @override
  String get resendEmail => 'Renvoyer l\'e-mail';

  @override
  String get verificationEmailSent => 'E-mail de vérification envoyé !';

  @override
  String get accountCreated =>
      'Compte créé ! Vérifiez votre e-mail pour activer votre compte.';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordDesc =>
      'Entrez l\'adresse e-mail liée à votre compte. Nous vous enverrons un lien pour réinitialiser votre mot de passe.';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String get enterEmailFirst => 'Veuillez entrer votre adresse e-mail.';

  @override
  String get enterValidEmailFirst =>
      'Veuillez entrer une adresse e-mail valide.';

  @override
  String resetEmailSent(String email) {
    return 'Lien envoyé à $email.\nVérifiez votre boîte de réception (et les spams).';
  }

  @override
  String get noAccountFound => 'Aucun compte trouvé avec cette adresse e-mail.';

  @override
  String get emailInvalid => 'L\'adresse e-mail n\'est pas valide.';

  @override
  String get tooManyRequests =>
      'Trop de tentatives. Veuillez réessayer plus tard.';

  @override
  String get failedToSendReset =>
      'Échec de l\'envoi de l\'e-mail de réinitialisation.';

  @override
  String get selectInterests => 'Sélectionnez vos intérêts';

  @override
  String get chooseTopicsDesc =>
      'Choisissez des sujets qui vous intéressent pour personnaliser votre expérience';

  @override
  String get getStarted => 'Commencer';

  @override
  String get topicNutrition => 'Nutrition';

  @override
  String get topicSleep => 'Sommeil';

  @override
  String get topicFitness => 'Forme physique';

  @override
  String get topicMentalHealth => 'Santé mentale';

  @override
  String get topicStressManagement => 'Gestion du stress';

  @override
  String get topicMindfulness => 'Pleine conscience';

  @override
  String get navHome => 'Accueil';

  @override
  String get navDiscover => 'Découvrir';

  @override
  String get navDailyTips => 'Conseils du jour';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get article1Title => 'Manger consciemment pour réduire le stress';

  @override
  String get article1Desc =>
      'Apprenez à manger de manière plus consciente pour réduire le stress et améliorer votre bien-être général.';

  @override
  String get article1ReadTime => '5 min de lecture';

  @override
  String get article2Title => 'Routine de yoga matinal rapide';

  @override
  String get article2Desc =>
      'Commencez votre journée avec cette routine de yoga énergisante pour améliorer votre humeur et votre concentration.';

  @override
  String get article2ReadTime => '7 min de lecture';

  @override
  String get article3Title =>
      'Habitudes d\'hydratation pour une meilleure santé';

  @override
  String get article3Desc =>
      'Découvrez des moyens simples pour rester hydraté tout au long de la journée pour une santé optimale.';

  @override
  String get article3ReadTime => '6 min de lecture';

  @override
  String get searchTopicsHint => 'Rechercher des sujets';

  @override
  String get noMatchingTopics => 'Aucun sujet correspondant trouvé';

  @override
  String topicComingSoon(String topic) {
    return 'Détails sur $topic bientôt disponibles';
  }

  @override
  String get discoverNutritionKeywords =>
      'régime alimentation repas nourriture';

  @override
  String get discoverSleepKeywords => 'repos coucher insomnie nuit';

  @override
  String get discoverFitnessKeywords => 'exercice entraînement sport gym';

  @override
  String get discoverMentalHealthKeywords => 'esprit bien-être émotion anxiété';

  @override
  String get discoverStressKeywords => 'stress calme détente gestion';

  @override
  String get discoverMindfulnessKeywords =>
      'méditation présent conscience attention';

  @override
  String get tipOfTheDay => 'Conseil du jour';

  @override
  String get healthCategory => 'Santé';

  @override
  String get dailyTipTitle => 'Privilégiez le sommeil pour une santé optimale';

  @override
  String get dailyTipDesc =>
      'Dormez 7 à 9 heures par nuit pour soutenir votre bien-être physique et mental. Des habitudes de sommeil régulières améliorent l\'humeur, la concentration et la santé globale.';

  @override
  String get remindMe => 'Me rappeler';

  @override
  String get remindMeSubtitle =>
      'Recevez une notification quotidienne pour votre conseil du jour.';

  @override
  String get remindersEnabled =>
      '🔔 Rappels quotidiens activés ! Vous serez notifié chaque jour.';

  @override
  String get remindersDisabled => '🔕 Rappels quotidiens désactivés.';

  @override
  String get reminderBannerText =>
      'Vous recevrez un rappel quotidien pour consulter votre conseil santé.';

  @override
  String get notifications => 'Notifications';

  @override
  String get newTips => 'Nouveaux conseils';

  @override
  String get newTipsDesc => 'Être notifié des nouveaux conseils santé';

  @override
  String get newFeatures => 'Nouvelles fonctionnalités';

  @override
  String get newFeaturesDesc =>
      'Être notifié lors de l\'ajout de nouvelles fonctionnalités';

  @override
  String get updatesLabel => 'Mises à jour';

  @override
  String get updatesDesc => 'Être notifié des mises à jour de l\'application';

  @override
  String get appPreferences => 'Préférences';

  @override
  String get theme => 'Thème';

  @override
  String get themeDesc => 'Choisissez votre thème préféré';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get language => 'Langue';

  @override
  String get languageDesc => 'Sélectionnez votre langue préférée';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get loggingOut => 'Déconnexion en cours…';

  @override
  String get logOutConfirmTitle => 'Se déconnecter';

  @override
  String get logOutConfirmBody => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String logoutFailed(String error) {
    return 'Échec de la déconnexion : $error';
  }

  @override
  String memberSince(String date) {
    return 'Membre depuis $date';
  }

  @override
  String get searchFitnessHint => 'Rechercher des conseils fitness…';

  @override
  String get searchMentalHealthHint => 'Rechercher des conseils santé mentale…';

  @override
  String get searchStressHint => 'Rechercher des conseils anti-stress…';

  @override
  String get searchNutritionHint => 'Rechercher des conseils nutrition…';

  @override
  String get searchSleepHint => 'Rechercher des conseils sommeil…';

  @override
  String get searchMindfulnessHint =>
      'Rechercher des conseils pleine conscience…';

  @override
  String noResultsFor(String query) {
    return 'Aucun résultat pour « $query »';
  }

  @override
  String searchResultsCount(num count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats pour « $query »',
      one: '1 résultat pour « $query »',
    );
    return '$_temp0';
  }

  @override
  String get noTipsFound => 'Aucun conseil trouvé.';

  @override
  String get tryDifferentKeyword => 'Essayez un autre terme de recherche.';

  @override
  String get fitnessTip1Title => 'Commencez par un échauffement';

  @override
  String get fitnessTip1Desc =>
      'Commencez toujours votre entraînement par 5 à 10 minutes de cardio léger et d\'étirements dynamiques pour prévenir les blessures.';

  @override
  String get fitnessTip2Title => 'Bases de la musculation';

  @override
  String get fitnessTip2Desc =>
      'Intégrez la musculation 2 à 3 fois par semaine en ciblant les principaux groupes musculaires pour un développement équilibré.';

  @override
  String get fitnessTip3Title => 'Cardio pour la santé cardiaque';

  @override
  String get fitnessTip3Desc =>
      'Visez au moins 150 minutes d\'activité aérobique modérée ou 75 minutes d\'activité intense par semaine.';

  @override
  String get fitnessTip4Title => 'Repos et récupération';

  @override
  String get fitnessTip4Desc =>
      'Prenez des jours de repos entre les entraînements intenses pour permettre aux muscles de se réparer et de se renforcer.';

  @override
  String get fitnessTip5Title => 'La technique avant tout';

  @override
  String get fitnessTip5Desc =>
      'Concentrez-vous sur la bonne technique plutôt que sur les poids lourds pour maximiser les résultats et prévenir les blessures.';

  @override
  String get fitnessTip6Title => 'Restez régulier';

  @override
  String get fitnessTip6Desc =>
      'Établissez un programme d\'entraînement que vous pouvez maintenir sur le long terme plutôt que des séances intenses occasionnelles.';

  @override
  String get mentalTip1Title => 'Pratiquez la pleine conscience';

  @override
  String get mentalTip1Desc =>
      'Prenez 10 minutes par jour pour vous concentrer sur le moment présent grâce à la méditation ou aux exercices de respiration profonde.';

  @override
  String get mentalTip2Title => 'Détox numérique';

  @override
  String get mentalTip2Desc =>
      'Réservez du temps chaque jour pour vous déconnecter des écrans et pratiquer des activités hors ligne que vous appréciez.';

  @override
  String get mentalTip3Title => 'Journal de gratitude';

  @override
  String get mentalTip3Desc =>
      'Notez trois choses pour lesquelles vous êtes reconnaissant chaque jour pour cultiver un état d\'esprit positif.';

  @override
  String get mentalTip4Title => 'Connectez-vous aux autres';

  @override
  String get mentalTip4Desc =>
      'Entretenez des liens sociaux solides en restant régulièrement en contact avec vos amis et votre famille.';

  @override
  String get mentalTip5Title => 'Routine de soins personnels';

  @override
  String get mentalTip5Desc =>
      'Établissez une routine quotidienne de soins incluant des activités qui nourrissent votre bien-être mental.';

  @override
  String get mentalTip6Title => 'Limitez les pensées négatives';

  @override
  String get mentalTip6Desc =>
      'Remettez en question le discours intérieur négatif et remplacez-le par des affirmations positives.';

  @override
  String get mentalTip7Title => 'Consultez un professionnel';

  @override
  String get mentalTip7Desc =>
      'N\'hésitez pas à consulter un professionnel de la santé mentale lorsque vous vous sentez dépassé.';

  @override
  String get stressTip1Title => 'Exercices de respiration profonde';

  @override
  String get stressTip1Desc =>
      'Pratiquez la technique 4-7-8 : inspirez 4 secondes, retenez 7, expirez 8 pour calmer votre système nerveux.';

  @override
  String get stressTip2Title => 'Gestion du temps';

  @override
  String get stressTip2Desc =>
      'Décomposez les tâches en petites étapes et priorisez pour éviter de vous sentir dépassé par les responsabilités.';

  @override
  String get stressTip3Title => 'Activité physique';

  @override
  String get stressTip3Desc =>
      'L\'exercice régulier libère des endorphines et aide à réduire naturellement les niveaux de stress.';

  @override
  String get stressTip4Title => 'Relaxation musculaire progressive';

  @override
  String get stressTip4Desc =>
      'Contractez puis relâchez chaque groupe musculaire pour libérer les tensions physiques causées par le stress.';

  @override
  String get stressTip5Title => 'Fixez des limites';

  @override
  String get stressTip5Desc =>
      'Apprenez à dire non aux responsabilités supplémentaires lorsque vous vous sentez dépassé.';

  @override
  String get stressTip6Title => 'Marche en pleine conscience';

  @override
  String get stressTip6Desc =>
      'Faites une courte promenade en vous concentrant sur votre environnement, les sensations de la marche et votre respiration.';

  @override
  String get stressTip7Title => 'Écoutez de la musique';

  @override
  String get stressTip7Desc =>
      'Jouez de la musique apaisante ou des sons de la nature pour réduire le stress et améliorer votre humeur.';

  @override
  String get stressTip8Title => 'Aromathérapie';

  @override
  String get stressTip8Desc =>
      'Utilisez des huiles essentielles comme la lavande ou la camomille pour créer un environnement apaisant.';

  @override
  String get nutritionTip1Title => 'Augmentez votre apport en fibres';

  @override
  String get nutritionTip1Desc =>
      'Les fibres régulent la digestion et vous rassasient plus longtemps. Intégrez des fruits, légumes, légumineuses et céréales complètes à vos repas.';

  @override
  String get nutritionTip2Title => 'Composez des repas équilibrés';

  @override
  String get nutritionTip2Desc =>
      'Remplissez votre assiette de légumes, protéines maigres, graisses saines et glucides complexes pour obtenir tous les nutriments nécessaires.';

  @override
  String get nutritionTip3Title => 'Restez hydraté';

  @override
  String get nutritionTip3Desc =>
      'Buvez de l\'eau régulièrement tout au long de la journée pour soutenir l\'énergie et la concentration. Visez au moins 8 verres par jour.';

  @override
  String get nutritionTip4Title => 'Choisissez les céréales complètes';

  @override
  String get nutritionTip4Desc =>
      'Préférez les céréales complètes comme l\'avoine, le riz brun et le quinoa aux céréales raffinées pour une énergie durable.';

  @override
  String get nutritionTip5Title => 'Mangez plus de fruits et légumes';

  @override
  String get nutritionTip5Desc =>
      'Visez au moins cinq portions de fruits et légumes par jour pour apporter à votre corps vitamines, minéraux et antioxydants essentiels.';

  @override
  String get nutritionTip6Title => 'Limitez les aliments transformés';

  @override
  String get nutritionTip6Desc =>
      'Réduisez votre consommation de snacks ultra-transformés et de restauration rapide, souvent riches en sucre, sel et graisses malsaines.';

  @override
  String get nutritionTip7Title => 'Contrôlez les portions';

  @override
  String get nutritionTip7Desc =>
      'Soyez attentif à la quantité consommée à chaque repas. Utiliser de plus petites assiettes et manger lentement aide à éviter les excès.';

  @override
  String get nutritionTip8Title => 'Incluez des graisses saines';

  @override
  String get nutritionTip8Desc =>
      'Incorporez des sources de graisses saines comme les avocats, noix, graines et huile d\'olive pour soutenir la santé cérébrale et hormonale.';

  @override
  String get nutritionTip9Title => 'Privilégiez les protéines maigres';

  @override
  String get nutritionTip9Desc =>
      'Choisissez des sources de protéines maigres comme le poulet, le poisson, le tofu, les œufs et les légumineuses pour soutenir la réparation musculaire.';

  @override
  String get nutritionTip10Title => 'Réduisez le sucre ajouté';

  @override
  String get nutritionTip10Desc =>
      'Limitez les boissons sucrées, desserts et aliments emballés. Un excès de sucre peut entraîner une prise de poids, des baisses d\'énergie et des inflammations.';

  @override
  String get sleepTip1Title => 'Établissez une routine du coucher';

  @override
  String get sleepTip1Desc =>
      'Couchez-vous et levez-vous à la même heure chaque jour, week-ends compris.';

  @override
  String get sleepTip2Title => 'Limitez les écrans avant de dormir';

  @override
  String get sleepTip2Desc =>
      'Évitez les écrans au moins une heure avant de dormir pour réduire l\'exposition à la lumière bleue.';

  @override
  String get sleepTip3Title => 'Créez une routine de relaxation';

  @override
  String get sleepTip3Desc =>
      'Adoptez des habitudes apaisantes comme des étirements légers ou la lecture avant le coucher.';

  @override
  String get sleepTip4Title => 'Gardez votre chambre fraîche';

  @override
  String get sleepTip4Desc =>
      'Une chambre fraîche et sombre vous aide à vous endormir plus vite et à dormir plus profondément.';

  @override
  String get sleepTip5Title => 'Essayez la respiration profonde';

  @override
  String get sleepTip5Desc =>
      'Des respirations lentes et profondes avant de dormir activent le système nerveux parasympathique et favorisent la relaxation.';

  @override
  String get sleepTip6Title => 'Évitez la caféine en fin de journée';

  @override
  String get sleepTip6Desc =>
      'La caféine peut rester dans votre organisme 6 à 8 heures ; évitez-la après 14h pour une meilleure qualité de sommeil.';

  @override
  String get sleepTip7Title => 'Tenez un journal du sommeil';

  @override
  String get sleepTip7Desc =>
      'Suivez vos habitudes de sommeil pour identifier ce qui favorise ou perturbe votre repos.';

  @override
  String get sleepTip8Title => 'Limitez les siestes dans la journée';

  @override
  String get sleepTip8Desc =>
      'Si vous faites une sieste, limitez-la à 30 minutes et évitez de faire la sieste en fin d\'après-midi.';

  @override
  String get mindfulnessTip1Title => 'Pratiquez la respiration profonde';

  @override
  String get mindfulnessTip1Desc =>
      'Prenez quelques minutes pour respirer lentement et profondément afin de calmer l\'esprit et le corps.';

  @override
  String get mindfulnessTip2Title => 'Essayez la méditation';

  @override
  String get mindfulnessTip2Desc =>
      'Commencez par cinq minutes par jour et augmentez progressivement la durée de votre pratique.';

  @override
  String get mindfulnessTip3Title => 'Écrivez vos pensées';

  @override
  String get mindfulnessTip3Desc =>
      'Notez vos pensées et émotions pour développer votre conscience intérieure et réduire le stress.';

  @override
  String get mindfulnessTip4Title => 'Vivez l\'instant présent';

  @override
  String get mindfulnessTip4Desc =>
      'Concentrez-vous sur ce que vous voyez, entendez et ressentez sans juger l\'expérience.';

  @override
  String get mindfulnessTip5Title => 'Marche consciente';

  @override
  String get mindfulnessTip5Desc =>
      'Marchez lentement en prêtant attention à chaque pas, votre respiration et votre environnement.';

  @override
  String get mindfulnessTip6Title => 'Observez vos pensées';

  @override
  String get mindfulnessTip6Desc =>
      'Remarquez vos pensées à mesure qu\'elles surgissent sans vous y attacher — laissez-les passer comme des nuages.';

  @override
  String get mindfulnessTip7Title => 'Relaxation par balayage corporel';

  @override
  String get mindfulnessTip7Desc =>
      'Déplacez lentement votre attention à travers chaque partie de votre corps en relâchant les tensions au fur et à mesure.';

  @override
  String get mindfulnessTip8Title => 'Monotâche';

  @override
  String get mindfulnessTip8Desc =>
      'Concentrez-vous sur une seule tâche à la fois avec toute votre attention plutôt que de faire plusieurs choses simultanément.';
}
