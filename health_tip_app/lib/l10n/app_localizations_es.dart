// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Consejos de Salud';

  @override
  String get cancel => 'Cancelar';

  @override
  String get healthCareTips => 'Consejos de Salud';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get name => 'Nombre';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get orSignInWith => 'O inicia sesión con';

  @override
  String get orSignUpWith => 'O regístrate con';

  @override
  String get dontHaveAccount => '¿No tienes cuenta?';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get apple => 'Apple';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get enterValidEmail => 'Introduce un correo electrónico válido';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get nameRequired => 'El nombre es obligatorio';

  @override
  String get pleaseVerifyEmail =>
      'Por favor verifica tu correo electrónico antes de iniciar sesión.';

  @override
  String get resendEmail => 'Reenviar correo';

  @override
  String get verificationEmailSent => '¡Correo de verificación enviado!';

  @override
  String get accountCreated =>
      '¡Cuenta creada! Por favor revisa tu correo electrónico para verificar tu cuenta.';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get resetPasswordDesc =>
      'Introduce la dirección de correo electrónico vinculada a tu cuenta. Te enviaremos un enlace para restablecer tu contraseña.';

  @override
  String get emailAddress => 'Dirección de correo electrónico';

  @override
  String get sendResetLink => 'Enviar enlace';

  @override
  String get enterEmailFirst =>
      'Por favor introduce tu dirección de correo electrónico.';

  @override
  String get enterValidEmailFirst =>
      'Por favor introduce una dirección de correo electrónico válida.';

  @override
  String resetEmailSent(String email) {
    return 'Enlace de restablecimiento enviado a $email.\nRevisa tu bandeja de entrada (y la carpeta de spam).';
  }

  @override
  String get noAccountFound =>
      'No se encontró ninguna cuenta con esa dirección de correo electrónico.';

  @override
  String get emailInvalid => 'La dirección de correo electrónico no es válida.';

  @override
  String get tooManyRequests =>
      'Demasiados intentos. Por favor inténtalo más tarde.';

  @override
  String get failedToSendReset =>
      'No se pudo enviar el correo de restablecimiento.';

  @override
  String get selectInterests => 'Selecciona tus intereses';

  @override
  String get chooseTopicsDesc =>
      'Elige los temas que te interesan para personalizar tu experiencia';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get topicNutrition => 'Nutrición';

  @override
  String get topicSleep => 'Sueño';

  @override
  String get topicFitness => 'Ejercicio';

  @override
  String get topicMentalHealth => 'Salud mental';

  @override
  String get topicStressManagement => 'Manejo del estrés';

  @override
  String get topicMindfulness => 'Mindfulness';

  @override
  String get navHome => 'Inicio';

  @override
  String get navDiscover => 'Explorar';

  @override
  String get navDailyTips => 'Consejos del día';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get article1Title => 'Alimentación consciente para reducir el estrés';

  @override
  String get article1Desc =>
      'Aprende a comer de forma más consciente para reducir el estrés y mejorar tu bienestar general.';

  @override
  String get article1ReadTime => '5 min de lectura';

  @override
  String get article2Title => 'Rutina de yoga matutino rápida';

  @override
  String get article2Desc =>
      'Comienza tu día con esta energizante rutina de yoga para mejorar tu estado de ánimo y concentración.';

  @override
  String get article2ReadTime => '7 min de lectura';

  @override
  String get article3Title => 'Hábitos de hidratación para una mejor salud';

  @override
  String get article3Desc =>
      'Descubre formas sencillas de mantenerte hidratado durante todo el día para una salud óptima.';

  @override
  String get article3ReadTime => '6 min de lectura';

  @override
  String get searchTopicsHint => 'Buscar temas';

  @override
  String get noMatchingTopics => 'No se encontraron temas coincidentes';

  @override
  String topicComingSoon(String topic) {
    return 'Detalles sobre $topic próximamente';
  }

  @override
  String get discoverNutritionKeywords => 'dieta alimentación comida saludable';

  @override
  String get discoverSleepKeywords => 'descanso acostarse insomnio noche';

  @override
  String get discoverFitnessKeywords =>
      'ejercicio entrenamiento gimnasio deporte';

  @override
  String get discoverMentalHealthKeywords => 'mente bienestar emoción ansiedad';

  @override
  String get discoverStressKeywords => 'estrés calma relajación afrontamiento';

  @override
  String get discoverMindfulnessKeywords =>
      'meditación presente conciencia atención';

  @override
  String get tipOfTheDay => 'Consejo del día';

  @override
  String get healthCategory => 'Salud';

  @override
  String get dailyTipTitle => 'Prioriza el sueño para una salud óptima';

  @override
  String get dailyTipDesc =>
      'Duerme entre 7 y 9 horas cada noche para apoyar tu bienestar físico y mental. Los patrones de sueño regulares pueden mejorar el estado de ánimo, la concentración y la salud en general.';

  @override
  String get remindMe => 'Recordarme';

  @override
  String get remindMeSubtitle =>
      'Recibe una notificación diaria para revisar el consejo del día.';

  @override
  String get remindersEnabled =>
      '🔔 ¡Recordatorios diarios activados! Serás notificado cada día.';

  @override
  String get remindersDisabled => '🔕 Recordatorios diarios desactivados.';

  @override
  String get reminderBannerText =>
      'Recibirás un recordatorio diario para revisar tu consejo de salud.';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get newTips => 'Nuevos consejos';

  @override
  String get newTipsDesc =>
      'Recibe notificaciones sobre nuevos consejos de salud';

  @override
  String get newFeatures => 'Nuevas funciones';

  @override
  String get newFeaturesDesc =>
      'Recibe notificaciones cuando se añadan nuevas funciones';

  @override
  String get updatesLabel => 'Actualizaciones';

  @override
  String get updatesDesc =>
      'Recibe notificaciones sobre las actualizaciones de la app';

  @override
  String get appPreferences => 'Preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get themeDesc => 'Elige tu tema preferido';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get languageDesc => 'Selecciona tu idioma preferido';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String get loggingOut => 'Cerrando sesión…';

  @override
  String get logOutConfirmTitle => 'Cerrar sesión';

  @override
  String get logOutConfirmBody => '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String logoutFailed(String error) {
    return 'Error al cerrar sesión: $error';
  }

  @override
  String memberSince(String date) {
    return 'Miembro desde $date';
  }

  @override
  String get searchFitnessHint => 'Buscar consejos de ejercicio…';

  @override
  String get searchMentalHealthHint => 'Buscar consejos de salud mental…';

  @override
  String get searchStressHint => 'Buscar consejos para el estrés…';

  @override
  String get searchNutritionHint => 'Buscar consejos de nutrición…';

  @override
  String get searchSleepHint => 'Buscar consejos de sueño…';

  @override
  String get searchMindfulnessHint => 'Buscar consejos de mindfulness…';

  @override
  String noResultsFor(String query) {
    return 'Sin resultados para \"$query\"';
  }

  @override
  String searchResultsCount(num count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados para \"$query\"',
      one: '1 resultado para \"$query\"',
    );
    return '$_temp0';
  }

  @override
  String get noTipsFound => 'No se encontraron consejos.';

  @override
  String get tryDifferentKeyword => 'Prueba con otro término de búsqueda.';

  @override
  String get fitnessTip1Title => 'Comienza con el calentamiento';

  @override
  String get fitnessTip1Desc =>
      'Empieza siempre tu entrenamiento con 5-10 minutos de cardio ligero y estiramientos dinámicos para prevenir lesiones.';

  @override
  String get fitnessTip2Title => 'Fundamentos del entrenamiento de fuerza';

  @override
  String get fitnessTip2Desc =>
      'Incorpora el entrenamiento de fuerza 2-3 veces por semana enfocándote en los principales grupos musculares para un desarrollo equilibrado.';

  @override
  String get fitnessTip3Title => 'Cardio para la salud del corazón';

  @override
  String get fitnessTip3Desc =>
      'Apunta a al menos 150 minutos de actividad aeróbica moderada o 75 minutos de actividad vigorosa a la semana.';

  @override
  String get fitnessTip4Title => 'Descanso y recuperación';

  @override
  String get fitnessTip4Desc =>
      'Toma días de descanso entre entrenamientos intensos para permitir que los músculos se reparen y se fortalezcan.';

  @override
  String get fitnessTip5Title => 'La técnica correcta importa';

  @override
  String get fitnessTip5Desc =>
      'Concéntrate en la técnica correcta en lugar de los pesos pesados para maximizar resultados y prevenir lesiones.';

  @override
  String get fitnessTip6Title => 'Mantén la constancia';

  @override
  String get fitnessTip6Desc =>
      'Crea una rutina de ejercicios que puedas mantener a largo plazo en lugar de sesiones intensas ocasionales.';

  @override
  String get mentalTip1Title => 'Practica la atención plena';

  @override
  String get mentalTip1Desc =>
      'Dedica 10 minutos diarios a enfocarte en el momento presente mediante la meditación o ejercicios de respiración profunda.';

  @override
  String get mentalTip2Title => 'Desintoxicación digital';

  @override
  String get mentalTip2Desc =>
      'Reserva tiempo cada día para desconectarte de las pantallas y dedicarte a actividades fuera de línea que disfrutes.';

  @override
  String get mentalTip3Title => 'Diario de gratitud';

  @override
  String get mentalTip3Desc =>
      'Anota tres cosas por las que estás agradecido cada día para cultivar una mentalidad positiva.';

  @override
  String get mentalTip4Title => 'Conéctate con los demás';

  @override
  String get mentalTip4Desc =>
      'Mantén vínculos sociales sólidos comunicándote regularmente con amigos y familiares.';

  @override
  String get mentalTip5Title => 'Rutina de autocuidado';

  @override
  String get mentalTip5Desc =>
      'Establece una rutina diaria de autocuidado con actividades que nutran tu bienestar mental.';

  @override
  String get mentalTip6Title => 'Limita los pensamientos negativos';

  @override
  String get mentalTip6Desc =>
      'Desafía el diálogo interno negativo y reemplázalo con afirmaciones positivas.';

  @override
  String get mentalTip7Title => 'Busca ayuda profesional';

  @override
  String get mentalTip7Desc =>
      'No dudes en consultar a un profesional de salud mental cuando te sientas abrumado.';

  @override
  String get stressTip1Title => 'Ejercicios de respiración profunda';

  @override
  String get stressTip1Desc =>
      'Practica la técnica 4-7-8: inhala 4 segundos, mantén 7, exhala 8 para calmar tu sistema nervioso.';

  @override
  String get stressTip2Title => 'Gestión del tiempo';

  @override
  String get stressTip2Desc =>
      'Divide las tareas en pasos más pequeños y prioriza para evitar sentirte abrumado por las responsabilidades.';

  @override
  String get stressTip3Title => 'Actividad física';

  @override
  String get stressTip3Desc =>
      'El ejercicio regular libera endorfinas y ayuda a reducir los niveles de estrés de forma natural.';

  @override
  String get stressTip4Title => 'Relajación muscular progresiva';

  @override
  String get stressTip4Desc =>
      'Tensa y luego relaja cada grupo muscular para liberar la tensión física causada por el estrés.';

  @override
  String get stressTip5Title => 'Establece límites';

  @override
  String get stressTip5Desc =>
      'Aprende a decir no a responsabilidades adicionales cuando te sientas abrumado.';

  @override
  String get stressTip6Title => 'Caminata consciente';

  @override
  String get stressTip6Desc =>
      'Da un corto paseo y concéntrate en tu entorno, la sensación de caminar y tu respiración.';

  @override
  String get stressTip7Title => 'Escucha música';

  @override
  String get stressTip7Desc =>
      'Pon música relajante o sonidos de la naturaleza para reducir el estrés y mejorar tu estado de ánimo.';

  @override
  String get stressTip8Title => 'Aromaterapia';

  @override
  String get stressTip8Desc =>
      'Usa aceites esenciales como lavanda o manzanilla para crear un ambiente tranquilizador.';

  @override
  String get nutritionTip1Title => 'Aumenta tu consumo de fibra';

  @override
  String get nutritionTip1Desc =>
      'La fibra regula la digestión y te mantiene saciado por más tiempo. Incluye frutas, verduras, legumbres y cereales integrales en tus comidas.';

  @override
  String get nutritionTip2Title => 'Crea comidas equilibradas';

  @override
  String get nutritionTip2Desc =>
      'Llena tu plato con verduras, proteínas magras, grasas saludables y carbohidratos complejos para obtener todos los nutrientes que necesitas.';

  @override
  String get nutritionTip3Title => 'Mantente hidratado';

  @override
  String get nutritionTip3Desc =>
      'Bebe agua regularmente durante el día para mantener la energía, la concentración y el buen funcionamiento del cuerpo. Apunta a al menos 8 vasos diarios.';

  @override
  String get nutritionTip4Title => 'Elige cereales integrales';

  @override
  String get nutritionTip4Desc =>
      'Prefiere los cereales integrales como avena, arroz integral y quinoa a los cereales refinados para obtener energía duradera.';

  @override
  String get nutritionTip5Title => 'Come más frutas y verduras';

  @override
  String get nutritionTip5Desc =>
      'Apunta a al menos cinco porciones de frutas y verduras al día para aportar a tu cuerpo vitaminas, minerales y antioxidantes esenciales.';

  @override
  String get nutritionTip6Title => 'Limita los alimentos procesados';

  @override
  String get nutritionTip6Desc =>
      'Reduce tu consumo de snacks ultraprocesados y comida rápida, que suelen ser ricos en azúcar, sodio y grasas poco saludables.';

  @override
  String get nutritionTip7Title => 'Controla las porciones';

  @override
  String get nutritionTip7Desc =>
      'Sé consciente de cuánto comes en cada comida. Usar platos más pequeños y comer despacio puede ayudar a evitar comer en exceso.';

  @override
  String get nutritionTip8Title => 'Incluye grasas saludables';

  @override
  String get nutritionTip8Desc =>
      'Incorpora fuentes de grasas saludables como aguacates, nueces, semillas y aceite de oliva para apoyar la salud cerebral y hormonal.';

  @override
  String get nutritionTip9Title => 'Prioriza la proteína magra';

  @override
  String get nutritionTip9Desc =>
      'Elige fuentes de proteína magra como pollo, pescado, tofu, huevos y legumbres para apoyar la recuperación muscular.';

  @override
  String get nutritionTip10Title => 'Reduce el azúcar añadido';

  @override
  String get nutritionTip10Desc =>
      'Reduce las bebidas azucaradas, los postres y los alimentos envasados. El exceso de azúcar puede provocar aumento de peso e inflamación.';

  @override
  String get sleepTip1Title => 'Establece una rutina antes de dormir';

  @override
  String get sleepTip1Desc =>
      'Acuéstate y levántate a la misma hora todos los días, incluyendo los fines de semana.';

  @override
  String get sleepTip2Title => 'Limita el uso de pantallas antes de dormir';

  @override
  String get sleepTip2Desc =>
      'Evita las pantallas al menos una hora antes de dormir para reducir la exposición a la luz azul.';

  @override
  String get sleepTip3Title => 'Crea una rutina de relajación';

  @override
  String get sleepTip3Desc =>
      'Usa hábitos tranquilizadores como estiramientos suaves o leer antes de acostarte.';

  @override
  String get sleepTip4Title => 'Mantén tu habitación fresca';

  @override
  String get sleepTip4Desc =>
      'Una habitación fresca y oscura te ayuda a conciliar el sueño más rápido y a dormir más profundamente.';

  @override
  String get sleepTip5Title => 'Practica la respiración profunda';

  @override
  String get sleepTip5Desc =>
      'Las respiraciones lentas y profundas antes de dormir activan el sistema nervioso parasimpático y favorecen la relajación.';

  @override
  String get sleepTip6Title => 'Evita la cafeína al final del día';

  @override
  String get sleepTip6Desc =>
      'La cafeína puede permanecer en tu sistema 6-8 horas, así que evítala después de las 14:00 para mejorar la calidad del sueño.';

  @override
  String get sleepTip7Title => 'Lleva un diario de sueño';

  @override
  String get sleepTip7Desc =>
      'Registra tus patrones y hábitos de sueño para identificar qué te ayuda o perjudica el descanso.';

  @override
  String get sleepTip8Title => 'Limita las siestas durante el día';

  @override
  String get sleepTip8Desc =>
      'Si necesitas dormir la siesta, que sea menos de 30 minutos y evita hacerla tarde en la tarde.';

  @override
  String get mindfulnessTip1Title => 'Practica la respiración profunda';

  @override
  String get mindfulnessTip1Desc =>
      'Toma respiraciones lentas y profundas durante unos minutos para calmar la mente y el cuerpo.';

  @override
  String get mindfulnessTip2Title => 'Prueba la meditación';

  @override
  String get mindfulnessTip2Desc =>
      'Empieza con cinco minutos diarios y aumenta gradualmente tu tiempo de práctica.';

  @override
  String get mindfulnessTip3Title => 'Escribe tus pensamientos';

  @override
  String get mindfulnessTip3Desc =>
      'Anota pensamientos y emociones para aumentar la conciencia y reducir el estrés.';

  @override
  String get mindfulnessTip4Title => 'Vive el momento presente';

  @override
  String get mindfulnessTip4Desc =>
      'Concéntrate en lo que puedes ver, escuchar y sentir sin juzgar la experiencia.';

  @override
  String get mindfulnessTip5Title => 'Caminata consciente';

  @override
  String get mindfulnessTip5Desc =>
      'Camina despacio y presta atención a cada paso, tu respiración y tu entorno.';

  @override
  String get mindfulnessTip6Title => 'Observa tus pensamientos';

  @override
  String get mindfulnessTip6Desc =>
      'Nota tus pensamientos tal como surgen sin aferrarte a ellos — déjalos pasar como nubes.';

  @override
  String get mindfulnessTip7Title => 'Relajación por exploración corporal';

  @override
  String get mindfulnessTip7Desc =>
      'Mueve lentamente tu atención por cada parte de tu cuerpo, liberando la tensión a medida que avanzas.';

  @override
  String get mindfulnessTip8Title => 'Monotarea';

  @override
  String get mindfulnessTip8Desc =>
      'Concéntrate en una sola tarea a la vez con total atención en lugar de hacer varias cosas a la vez.';
}
