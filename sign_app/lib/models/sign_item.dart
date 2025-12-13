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

  // أ 
  SignItem(
    label: 'ا',
    nameAr: 'حرف الألف',
    nameEn: 'Letter Alef',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع رفع الإبهام للأعلى (إشارة مثل 👍).',
    descriptionEn: 'Make a fist and raise the thumb upward (thumbs-up).',
    imageAsset: 'assets/signs/alef.jpg',
  ),

  // ب 
  SignItem(
    label: 'ب',
    nameAr: 'حرف الباء',
    nameEn: 'Letter Baa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع رفع السبابة للأعلى وبقية الأصابع مطوية.',
    descriptionEn: 'Make a fist and raise the index finger up; other fingers folded.',
    imageAsset: 'assets/signs/baa.jpg',
  ),

  // ت 
  SignItem(
    label: 'ت',
    nameAr: 'حرف التاء',
    nameEn: 'Letter Taa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع السبابة والوسطى للأعلى مع طيّ باقي الأصابع.',
    descriptionEn: 'Raise index and middle fingers up; fold the remaining fingers.',
    imageAsset: 'assets/signs/taa.jpg',
  ),

  // ث 
  SignItem(
    label: 'ث',
    nameAr: 'حرف الثاء',
    nameEn: 'Letter Thaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع ثلاث أصابع للأعلى (السبابة والوسطى والبنصر) مع طيّ الخنصر والإبهام.',
    descriptionEn: 'Raise three fingers (index, middle, ring); fold the thumb and pinky.',
    imageAsset: 'assets/signs/thaa.jpg',
  ),

  // ج 
  SignItem(
    label: 'ج',
    nameAr: 'حرف الجيم',
    nameEn: 'Letter Jeem',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'تكوين شكل حرف C بالسبابة والإبهام مع انحناء بسيط لباقي الأصابع.',
    descriptionEn: 'Form a “C” shape using the index finger and thumb; other fingers relaxed.',
    imageAsset: 'assets/signs/jeem.jpg',
  ),

  // ح 
  SignItem(
    label: 'ح',
    nameAr: 'حرف الحاء',
    nameEn: 'Letter Haa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'اليد بوضع جانبي، الأصابع مجتمعة وممتدة للأمام بشكل مستقيم نسبيًا.',
    descriptionEn: 'Side-facing hand with fingers together, extended forward in a flat shape.',
    imageAsset: 'assets/signs/haa.jpg',
  ),

  // خ 
  SignItem(
    label: 'خ',
    nameAr: 'حرف الخاء',
    nameEn: 'Letter Khaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مثل حرف (ح) لكن مع إبراز الإبهام للخارج أكثر ليكون الشكل أوسع.',
    descriptionEn: 'Similar to Haa, but with the thumb opened outward more to make the shape wider.',
    imageAsset: 'assets/signs/khaa.jpg',
  ),

  // د 
  SignItem(
    label: 'د',
    nameAr: 'حرف الدال',
    nameEn: 'Letter Daal',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'تكوين شكل C مفتوح باليد (الإبهام مقابل الأصابع بشكل منحني).',
    descriptionEn: 'Form an open “C” with the hand (thumb opposite curved fingers).',
    imageAsset: 'assets/signs/daal.jpg',
  ),

  // ذ 
  SignItem(
    label: 'ذ',
    nameAr: 'حرف الذال',
    nameEn: 'Letter Thaal',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل C أصغر/أضيق قليلًا من (د) مع انحناء واضح للأصابع.',
    descriptionEn: 'A slightly smaller/tighter “C” than Daal, with clearly curved fingers.',
    imageAsset: 'assets/signs/thaal.jpg',
  ),

  // ر 
  SignItem(
    label: 'ر',
    nameAr: 'حرف الراء',
    nameEn: 'Letter Raa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل C بالسبابة والإبهام مع حركة بسيطة باليد يمينًا ويسارًا.',
    descriptionEn: 'Make a “C” with index and thumb, then move the hand slightly left and right.',
    imageAsset: 'assets/signs/raa.jpg',
  ),

  // ز 
  SignItem(
    label: 'ز',
    nameAr: 'حرف الزاي',
    nameEn: 'Letter Zay',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'شكل C بالسبابة والإبهام بدون حركة إضافية.',
    descriptionEn: 'Form a “C” with the index and thumb, without extra motion.',
    imageAsset: 'assets/signs/zay.jpg',
  ),

  // س 
  SignItem(
    label: 'س',
    nameAr: 'حرف السين',
    nameEn: 'Letter Seen',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'فتح الكف للأمام، الأصابع الأربعة متلاصقة للأعلى والإبهام جانبي.',
    descriptionEn: 'Open palm facing forward; four fingers together up, thumb to the side.',
    imageAsset: 'assets/signs/seen.jpg',
  ),

  // ش 
  SignItem(
    label: 'ش',
    nameAr: 'حرف الشين',
    nameEn: 'Letter Sheen',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'فتح الكف للأمام مع تفريق الأصابع (كف مفتوح ومباعد).',
    descriptionEn: 'Open palm facing forward with fingers spread apart.',
    imageAsset: 'assets/signs/sheen.jpg',
  ),

  // ص 
  SignItem(
    label: 'ص',
    nameAr: 'حرف الصاد',
    nameEn: 'Letter Saad',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مغلقة مع ثبات الإبهام على جانب القبضة.',
    descriptionEn: 'Closed fist with the thumb resting along the side of the fist.',
    imageAsset: 'assets/signs/saad.jpg',
  ),

  // ض 
  SignItem(
    label: 'ض',
    nameAr: 'حرف الضاد',
    nameEn: 'Letter Daad',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مغلقة مع إخراج الإبهام للخارج جانبًا.',
    descriptionEn: 'Closed fist with the thumb extended outward to the side.',
    imageAsset: 'assets/signs/daad.jpg',
  ),

  // ط 
  SignItem(
    label: 'ط',
    nameAr: 'حرف الطاء',
    nameEn: 'Letter Ttaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع السبابة للأعلى، ومدّ الوسطى للأمام مع ملامسة الإبهام لطرف الوسطى.',
    descriptionEn: 'Raise the index finger up, extend the middle finger forward, and touch its tip with the thumb.',
    imageAsset: 'assets/signs/ttaa.jpg',
  ),

  // ظ 
  SignItem(
    label: 'ظ',
    nameAr: 'حرف الظاء',
    nameEn: 'Letter Thaa (emphatic)',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع السبابة للأعلى، ومدّ الوسطى للأمام، وبقية الأصابع مطوية.',
    descriptionEn: 'Raise the index finger up, extend the middle finger forward; keep the other fingers folded.',
    imageAsset: 'assets/signs/thaa_emphatic.jpg',
  ),

  // ع 
  SignItem(
    label: 'ع',
    nameAr: 'حرف العين',
    nameEn: 'Letter Ain',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'اليد بشكل جانبي أفقي، الأصابع مجتمعة وممتدة للأمام كأنها تشير.',
    descriptionEn: 'Side-facing horizontal hand with fingers together, extended forward as if pointing.',
    imageAsset: 'assets/signs/ain.jpg',
  ),

  // غ 
  SignItem(
    label: 'غ',
    nameAr: 'حرف الغين',
    nameEn: 'Letter Ghayn',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'مدّ السبابة والوسطى للأمام مع بقاء باقي الأصابع مطوية.',
    descriptionEn: 'Extend the index and middle fingers forward; fold the remaining fingers.',
    imageAsset: 'assets/signs/ghayn.jpg',
  ),

  // ف 
  SignItem(
    label: 'ف',
    nameAr: 'حرف الفاء',
    nameEn: 'Letter Faa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ضمّ الإبهام مع السبابة كقرصة صغيرة، وبقية الأصابع مطوية.',
    descriptionEn: 'Pinch the thumb and index finger together (small pinch); other fingers folded.',
    imageAsset: 'assets/signs/faa.jpg',
  ),

  // ق 
  SignItem(
    label: 'ق',
    nameAr: 'حرف القاف',
    nameEn: 'Letter Qaaf',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبض الأصابع مع قرصة بين الإبهام والسبابة (شكل صغير ومغلق).',
    descriptionEn: 'Curl the fingers into a fist and make a small pinch between thumb and index.',
    imageAsset: 'assets/signs/qaaf.jpg',
  ),

  // ك 
  SignItem(
    label: 'ك',
    nameAr: 'حرف الكاف',
    nameEn: 'Letter Kaaf',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'الكف للأمام، أربعة أصابع للأعلى متلاصقة، والإبهام مطوي عبر الكف.',
    descriptionEn: 'Palm forward; four fingers together up, with the thumb folded across the palm.',
    imageAsset: 'assets/signs/kaaf.jpg',
  ),

  // ل 
  SignItem(
    label: 'ل',
    nameAr: 'حرف اللام',
    nameEn: 'Letter Laam',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'تكوين شكل L برفع السبابة للأعلى ومدّ الإبهام جانبًا.',
    descriptionEn: 'Form an “L” by raising the index finger up and extending the thumb sideways.',
    imageAsset: 'assets/signs/laam.jpg',
  ),

  // م 
  SignItem(
    label: 'م',
    nameAr: 'حرف الميم',
    nameEn: 'Letter Meem',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع رفع السبابة فقط للأعلى.',
    descriptionEn: 'Make a fist and raise only the index finger upward.',
    imageAsset: 'assets/signs/meem.jpg',
  ),

  // ن 
  SignItem(
    label: 'ن',
    nameAr: 'حرف النون',
    nameEn: 'Letter Noon',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع رفع الخنصر للأعلى (وبقية الأصابع مطوية).',
    descriptionEn: 'Make a fist and raise the pinky finger upward; other fingers folded.',
    imageAsset: 'assets/signs/noon.jpg',
  ),

  // هـ 
  SignItem(
    label: 'هـ',
    nameAr: 'حرف الهاء',
    nameEn: 'Letter Haa (soft)',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع إدخال الإبهام بين الأصابع بحيث يظهر طرفه من الأمام.',
    descriptionEn: 'Make a fist and tuck the thumb between the fingers so its tip shows in front.',
    imageAsset: 'assets/signs/haa_soft.jpg',
  ),

  // و 
  SignItem(
    label: 'و',
    nameAr: 'حرف الواو',
    nameEn: 'Letter Waw',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'قبضة اليد مع توجيه الإبهام للأسفل (إشارة مثل 👎).',
    descriptionEn: 'Make a fist and point the thumb downward (thumbs-down).',
    imageAsset: 'assets/signs/waw.jpg',
  ),

  // ي 
  SignItem(
    label: 'ي',
    nameAr: 'حرف الياء',
    nameEn: 'Letter Yaa',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'رفع الإبهام والخنصر مع طيّ الأصابع الثلاثة الوسطى.',
    descriptionEn: 'Extend the thumb and pinky while folding the three middle fingers.',
    imageAsset: 'assets/signs/yaa.jpg',
  ),

  // ة 
  SignItem(
    label: 'ة',
    nameAr: 'حرف التاء المربوطة',
    nameEn: 'Letter Taa Marbuta',
    categoryAr: 'حرف',
    categoryEn: 'Letter',
    descriptionAr: 'ثني السبابة والوسطى للأعلى بشكل خطّاف/مخلب مع طيّ باقي الأصابع.',
    descriptionEn: 'Bend the index and middle fingers upward like small hooks; fold the other fingers.',
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