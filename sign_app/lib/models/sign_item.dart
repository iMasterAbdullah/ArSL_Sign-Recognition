part of '../app.dart';

// MODELS (dummy)
//

class SignItem {
  final String label; // Arabic letter or word (doesn’t change)
  final String nameAr;
  final String nameEn;
  final String categoryAr;
  final String categoryEn;
  final String descriptionAr;
  final String descriptionEn;
  final String imageAsset;

  const SignItem({
    required this.label,
    required this.nameAr,
    required this.nameEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.imageAsset,
  });
}


final List<SignItem> mockSigns = [

  // ا
  SignItem(
    label: 'ا',
    nameAr: 'حرف الألف',
    nameEn: 'Letter Alef',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل مستقيم للأصابع مع رفع اليد بشكل بسيط.',
    descriptionEn: 'Straight fingers in an upright simple posture.',
    imageAsset: 'assets/signs/alef.jpg',
  ),

  // ب
  SignItem(
    label: 'ب',
    nameAr: 'حرف الباء',
    nameEn: 'Letter Baa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ الأصابع للأمام مع إخفاء الإبهام.',
    descriptionEn: 'Extend fingers forward while tucking the thumb in.',
    imageAsset: 'assets/signs/baa.jpg',
  ),

  // ت
  SignItem(
    label: 'ت',
    nameAr: 'حرف التاء',
    nameEn: 'Letter Taa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ ثلاثة أصابع مع إغلاق الخنصر والإبهام.',
    descriptionEn: 'Extend three fingers while keeping thumb and pinky closed.',
    imageAsset: 'assets/signs/taa.jpg',
  ),

  // ث
  SignItem(
    label: 'ث',
    nameAr: 'حرف الثاء',
    nameEn: 'Letter Thaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ثلاثة أصابع ممتدة مع فصل بسيط بينها.',
    descriptionEn: 'Three extended fingers with slight separation.',
    imageAsset: 'assets/signs/thaa.jpg',
  ),

  // ج
  SignItem(
    label: 'ج',
    nameAr: 'حرف الجيم',
    nameEn: 'Letter Jeem',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل منحني باليد كما لو أنك ترسم نصف دائرة.',
    descriptionEn: 'Curved hand shape as if drawing a small semicircle.',
    imageAsset: 'assets/signs/jeem.jpg',
  ),

  // ح
  SignItem(
    label: 'ح',
    nameAr: 'حرف الحاء',
    nameEn: 'Letter Haa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل حرف C مفتوح بخفة مع استرخاء الأصابع.',
    descriptionEn: 'A gentle C-shaped hand with relaxed fingers.',
    imageAsset: 'assets/signs/haa.jpg',
  ),

  // خ
  SignItem(
    label: 'خ',
    nameAr: 'حرف الخاء',
    nameEn: 'Letter Khaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'نفس شكل الحاء مع رفع اليد قليلاً.',
    descriptionEn: 'Same as Haa but with the hand raised slightly.',
    imageAsset: 'assets/signs/khaa.jpg',
  ),

  // د
  SignItem(
    label: 'د',
    nameAr: 'حرف الدال',
    nameEn: 'Letter Daal',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ السبابة للأمام مع ميل بسيط لليد.',
    descriptionEn: 'Extend the index finger forward with a slight tilt.',
    imageAsset: 'assets/signs/daal.jpg',
  ),

  // ذ
  SignItem(
    label: 'ذ',
    nameAr: 'حرف الذال',
    nameEn: 'Letter Thaal',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'السبابة ممتدة مع ميلها قليلاً للأعلى.',
    descriptionEn: 'Index finger extended and angled slightly upward.',
    imageAsset: 'assets/signs/thaal.jpg',
  ),

  // ر
  SignItem(
    label: 'ر',
    nameAr: 'حرف الراء',
    nameEn: 'Letter Raa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ السبابة للأسفل بشكل مسترخٍ.',
    descriptionEn: 'Relaxed index finger pointing downward.',
    imageAsset: 'assets/signs/raa.jpg',
  ),

  // ز
  SignItem(
    label: 'ز',
    nameAr: 'حرف الزاي',
    nameEn: 'Letter Zay',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'السبابة ممتدة مع حركة صغيرة بالمعصم.',
    descriptionEn: 'Index finger extended with a small wrist movement.',
    imageAsset: 'assets/signs/zay.jpg',
  ),

  // س
  SignItem(
    label: 'س',
    nameAr: 'حرف السين',
    nameEn: 'Letter Seen',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ثلاثة أصابع مستقيمة للأمام.',
    descriptionEn: 'Three straight fingers extended forward.',
    imageAsset: 'assets/signs/seen.jpg',
  ),

  // ش
  SignItem(
    label: 'ش',
    nameAr: 'حرف الشين',
    nameEn: 'Letter Sheen',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ثلاثة أصابع ممتدة ومتباعدة قليلاً.',
    descriptionEn: 'Three extended fingers, slightly separated.',
    imageAsset: 'assets/signs/sheen.jpg',
  ),

  // ص
  SignItem(
    label: 'ص',
    nameAr: 'حرف الصاد',
    nameEn: 'Letter Saad',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'اليد مستقيمة والأصابع متقاربة بقوة.',
    descriptionEn: 'Straight, firm hand with fingers together.',
    imageAsset: 'assets/signs/saad.jpg',
  ),

  // ض
  SignItem(
    label: 'ض',
    nameAr: 'حرف الضاد',
    nameEn: 'Letter Daad',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مثل الصاد مع ملامسة الإبهام للسبابة.',
    descriptionEn: 'Like Saad but thumb touches the index finger.',
    imageAsset: 'assets/signs/daad.jpg',
  ),

  // ط
  SignItem(
    label: 'ط',
    nameAr: 'حرف الطاء',
    nameEn: 'Letter Ttaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع السبابة للأعلى بثبات.',
    descriptionEn: 'Index finger extended upward firmly.',
    imageAsset: 'assets/signs/ttaa.jpg',
  ),

  // ظ
  SignItem(
    label: 'ظ',
    nameAr: 'حرف الظاء',
    nameEn: 'Letter Thaa (emphatic)',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع السبابة قليلاً للأعلى مع إبراز الحركة.',
    descriptionEn: 'Index finger raised slightly higher than usual.',
    imageAsset: 'assets/signs/thaa_emphatic.jpg',
  ),

  // ع
  SignItem(
    label: 'ع',
    nameAr: 'حرف العين',
    nameEn: 'Letter Ain',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل منحني يشبه رسم حرف ع.',
    descriptionEn: 'Curved hand shape resembling the Arabic Ain.',
    imageAsset: 'assets/signs/ain.jpg',
  ),

  // غ
  SignItem(
    label: 'غ',
    nameAr: 'حرف الغين',
    nameEn: 'Letter Ghayn',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مثل العين ولكن مع رفع اليد قليلاً.',
    descriptionEn: 'Same as Ain but slightly raised.',
    imageAsset: 'assets/signs/ghayn.jpg',
  ),

  // ف
  SignItem(
    label: 'ف',
    nameAr: 'حرف الفاء',
    nameEn: 'Letter Faa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ملامسة الإبهام للسبابة مع امتداد باقي الأصابع.',
    descriptionEn: 'Thumb touches index finger while others extend.',
    imageAsset: 'assets/signs/faa.jpg',
  ),

  // ق
  SignItem(
    label: 'ق',
    nameAr: 'حرف القاف',
    nameEn: 'Letter Qaaf',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'دائرة صغيرة بين الإبهام والسبابة.',
    descriptionEn: 'Small circle between thumb and index finger.',
    imageAsset: 'assets/signs/qaaf.jpg',
  ),

  // ك
  SignItem(
    label: 'ك',
    nameAr: 'حرف الكاف',
    nameEn: 'Letter Kaaf',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'راحة اليد للأمام مع أصابع مستقيمة.',
    descriptionEn: 'Palm forward with straight fingers.',
    imageAsset: 'assets/signs/kaaf.jpg',
  ),

  // ل
  SignItem(
    label: 'ل',
    nameAr: 'حرف اللام',
    nameEn: 'Letter Laam',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل L بين الإبهام والسبابة.',
    descriptionEn: 'An L shape between thumb and index finger.',
    imageAsset: 'assets/signs/laam.jpg',
  ),

  // م
  SignItem(
    label: 'م',
    nameAr: 'حرف الميم',
    nameEn: 'Letter Meem',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبض اليد مع وضع الإبهام فوق الأصابع.',
    descriptionEn: 'Closed fist with thumb resting on top.',
    imageAsset: 'assets/signs/meem.jpg',
  ),

  // ن
  SignItem(
    label: 'ن',
    nameAr: 'حرف النون',
    nameEn: 'Letter Noon',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ السبابة والوسطى للأمام.',
    descriptionEn: 'Extend index and middle fingers together.',
    imageAsset: 'assets/signs/noon.jpg',
  ),

  // هـ
  SignItem(
    label: 'هـ',
    nameAr: 'حرف الهاء',
    nameEn: 'Letter Haa (soft)',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل كأس صغير باليد.',
    descriptionEn: 'Cup-shaped gentle hand.',
    imageAsset: 'assets/signs/haa_soft.jpg',
  ),

  // و
  SignItem(
    label: 'و',
    nameAr: 'حرف الواو',
    nameEn: 'Letter Waw',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل دائرة صغيرة مع رفع اليد.',
    descriptionEn: 'Small circle shape with upward orientation.',
    imageAsset: 'assets/signs/waw.jpg',
  ),

  // ي
  SignItem(
    label: 'ي',
    nameAr: 'حرف الياء',
    nameEn: 'Letter Yaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع الخنصر والإبهام مع قبض باقي الأصابع.',
    descriptionEn: 'Extend pinky and thumb while others fold.',
    imageAsset: 'assets/signs/yaa.jpg',
  ),

 // ة 
  SignItem(
    label: 'ة',
    nameAr: 'حرف التاء المربوطة',
    nameEn: 'Letter Taa Marbuta',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل مستدير بسيط للدلالة على التاء المربوطة.',
    descriptionEn: 'A small rounded hand shape indicating the tied Taa.',
    imageAsset: 'assets/signs/taa_marbuta.jpg',
  ),

  // Word example
  SignItem(
    label: 'سلام',
    nameAr: 'سلام',
    nameEn: 'Salam',
    categoryAr: 'كلمة',
    categoryEn: 'Word',
    descriptionAr: 'تحية شائعة تعني السلام.',
    descriptionEn: 'A common greeting meaning "peace".',
    imageAsset: 'assets/signs/salam.jpg',
  ),
];
