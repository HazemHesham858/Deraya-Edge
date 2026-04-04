# 📁 File Structure - بنية الملفات

شرح تفصيلي لبنية مشروع Deraya-Edge وأين تضع الملفات الجديدة.

## 🌳 هيكل المشروع الكامل

```
deraya-edge/
│
├── 📄 Configuration Files
│   ├── package.json              # اعتماديات الفرونتند
│   ├── vite.config.ts            # إعدادات Vite
│   ├── tsconfig.json             # إعدادات TypeScript
│   ├── tailwind.config.ts         # إعدادات Tailwind
│   ├── postcss.config.js          # معالج CSS
│   ├── eslint.config.js           # معايير الكود
│   └── index.html                 # ملف HTML الرئيسي
│
├── 📁 src/                        # كود التطبيق (React)
│   ├── 📄 main.tsx               # نقطة الدخول
│   ├── 📄 App.tsx                # المكون الرئيسي
│   ├── 📄 index.css              # الأنماط العامة
│   ├── 📄 App.css                # أنماط التطبيق
│   ├── 📄 vite-env.d.ts          # تعريفات البيئة
│   │
│   ├── 📁 components/            # مكونات React
│   │   ├── 📁 ui/                # مكونات UI الأساسية
│   │   │   ├── button.tsx
│   │   │   ├── input.tsx
│   │   │   ├── card.tsx
│   │   │   └── ... (30+ مكون)
│   │   │
│   │   ├── Navbar.tsx            # شريط التنقل
│   │   ├── Footer.tsx            # التذييل
│   │   ├── Hero.tsx              # الجزء العلوي
│   │   ├── About.tsx             # قسم عنا
│   │   ├── Courses.tsx           # قائمة الدورات
│   │   ├── Articles.tsx          # المقالات
│   │   ├── Community.tsx         # المجتمع
│   │   ├── Profile.tsx           # ملف المستخدم
│   │   ├── AuthModal.tsx         # نافذة المصادقة
│   │   ├── DonChatbot.tsx        # روبوت الدردشة
│   │   └── ... (المزيد من المكونات)
│   │
│   ├── 📁 pages/                 # صفحات التطبيق
│   │   ├── HomePage.tsx          # الصفحة الرئيسية
│   │   ├── CoursesPage.tsx       # صفحة الدورات
│   │   ├── ArticlesPage.tsx      # صفحة المقالات
│   │   ├── ResearchPage.tsx      # صفحة البحث
│   │   ├── CommunityPage.tsx     # صفحة المجتمع
│   │   ├── EventsPage.tsx        # صفحة الأحداث
│   │   ├── InternshipPage.tsx    # صفحة التدريب
│   │   ├── AboutPage.tsx         # صفحة من نحن
│   │   ├── NotFound.tsx          # صفحة 404
│   │   └── Index.tsx             # الفهرس
│   │
│   ├── 📁 contexts/              # React Context (State Management)
│   │   └── AuthContext.tsx       # سياق المصادقة
│   │
│   ├── 📁 hooks/                 # React Hooks مخصصة
│   │   ├── use-mobile.tsx        # التعرف على الهاتف
│   │   └── use-toast.ts          # إظهار التنبيهات
│   │
│   ├── 📁 services/              # خدمات API
│   │   └── api.ts                # دوال التواصل مع الباكند
│   │
│   ├── 📁 integrations/          # التكاملات الخارجية
│   │   ├── 📁 supabase/
│   │   │   ├── client.ts         # عميل Supabase
│   │   │   └── types.ts          # أنواع البيانات
│   │   └── 📁 lovable/
│   │       └── index.ts
│   │
│   ├── 📁 lib/                   # دوال مساعدة
│   │   └── utils.ts              # دوال عامة
│   │
│   └── 📁 assets/                # الصور والملفات
│       ├── images/
│       ├── icons/
│       └── ... (الصور والملفات)
│
├── 📁 server/                    # كود الباكند (Express)
│   ├── 📄 package.json          # اعتماديات الباكند
│   ├── 📄 server.js             # نقطة الدخول الرئيسية
│   │
│   ├── 📁 routes/               # مسارات API
│   │   ├── auth.routes.js       # المصادقة (register, login)
│   │   ├── user.routes.js       # بيانات المستخدم
│   │   ├── course.routes.js     # الدورات
│   │   ├── article.routes.js    # المقالات
│   │   ├── paper.routes.js      # الأوراق البحثية
│   │   ├── post.routes.js       # المنشورات
│   │   ├── chat.routes.js       # الدردشة
│   │   ├── upload.routes.js     # رفع الملفات
│   │   └── oauth.routes.js      # OAuth (Google, Microsoft)
│   │
│   ├── 📁 models/               # نماذج Sequelize (قاعدة البيانات)
│   │   ├── index.js             # تهيئة Sequelize
│   │   ├── User.js              # نموذج المستخدم
│   │   ├── Course.js            # نموذج الدورة
│   │   ├── Article.js           # نموذج المقالة
│   │   ├── ResearchPaper.js     # نموذج الورقة البحثية
│   │   └── CommunityPost.js     # نموذج منشور المجتمع
│   │
│   ├── 📁 config/               # التكوينات
│   │   └── passport.js          # إعدادات OAuth
│   │
│   ├── 📁 middlewares/          # Middlewares
│   │   └── auth.middleware.js   # التحقق من المصادقة
│   │
│   ├── 📄 seed.js               # بيانات اختبارية
│   ├── 📄 deraya_research.sqlite # قاعدة البيانات SQLite
│   ├── 📁 uploads/              # مجلد الملفات المرفوعة
│   └── .env.development.local   # متغيرات البيئة
│
├── 📁 public/                   # الملفات الثابتة
│   ├── favicon.ico
│   ├── robots.txt
│   └── images/
│       ├── deraya-graduation.png
│       ├── placeholder.svg
│       └── ...
│
├── 📁 supabase/                 # تكوينات Supabase
│   ├── 📄 config.toml
│   ├── 📁 functions/
│   │   └── don-chat/            # دالة الدردشة الذكية
│   │       └── index.ts
│   └── 📁 migrations/           # هجرات قاعدة البيانات
│       ├── 20260330015432_....sql
│       ├── 20260330021436_....sql
│       └── ...
│
├── 📄 Documentation Files
│   ├── README.md                # ملخص المشروع
│   ├── QUICK_START.md           # بدء سريع (هذا الملف أساسي!)
│   ├── SETUP_GUIDE.md           # إعداد تفصيلي
│   ├── DEVELOPER.md             # دليل المطورين
│   ├── TROUBLESHOOTING.md       # حل المشاكل
│   ├── DEPLOYMENT.md            # النشر في الإنتاج
│   ├── FILE_STRUCTURE.md        # هذا الملف
│   ├── QUICK_REFERENCE.md       # مرجع سريع
│   └── .env.example             # مثال متغيرات البيئة
│
├── 📄 Scripts
│   ├── start.sh                 # بدء سريع (Linux/Mac)
│   ├── start.bat                # بدء سريع (Windows)
│   ├── build.sh                 # بناء المشروع
│   ├── setup-dev.sh             # إعداد البيئة
│   └── check-health.js          # فحص الصحة
│
├── 📄 Configuration
│   ├── .gitignore               # الملفات المتجاهلة في Git
│   ├── components.json          # إعدادات shadcn/ui
│   └── package-lock.json        # قفل الإصدارات
│
└── 📁 dist/                     # البناء النهائي (بعد npm run build)
    ├── index.html
    └── assets/
```

---

## 📍 أين تضع الملفات الجديدة؟

### 🔵 مكون جديد (React Component)
```
src/components/MyNewComponent.tsx
```

### 📄 صفحة جديدة
```
src/pages/MyNewPage.tsx
```

### 🔗 مسار API جديد
```
server/routes/my-feature.routes.js
```

### 🗄️ نموذج قاعدة بيانات جديد
```
server/models/MyModel.js
```

### 🎨 خدمة جديدة
```
src/services/myService.ts
```

### 🪝 Custom Hook جديد
```
src/hooks/useMyHook.tsx
```

### 📁 Context جديد
```
src/contexts/MyContext.tsx
```

---

## 🎯 أمثلة عملية

### مثال 1: إضافة مكون زر جديد

```
src/components/MyButton.tsx
└── استخدمه في: src/pages/HomePage.tsx
```

### مثال 2: إضافة صفحة تسوق

```
src/pages/ShoppingPage.tsx          # الصفحة
server/routes/shop.routes.js        # API endpoints
server/models/Product.js            # نموذج المنتج
src/services/shopService.ts         # خدمات الشراء
```

### مثال 3: إضافة نموذج تسجيل متقدم

```
src/components/AdvancedForm.tsx     # مكون النموذج
src/contexts/FormContext.tsx        # إدارة حالة النموذج
src/hooks/useForm.tsx               # hook مخصص
src/services/formService.ts         # خدمات معالجة النموذج
server/routes/form.routes.js        # API endpoints
```

---

## 🔒 الملفات الحساسة (لا تعدلها بدون حذر)

- ⚠️ `vite.config.ts` - تكوينات البناء
- ⚠️ `tailwind.config.ts` - نظام الألوان والأنماط
- ⚠️ `tsconfig.json` - إعدادات TypeScript
- ⚠️ `server/server.js` - إعدادات الخادم الرئيسية
- ⚠️ `src/App.tsx` - التوجيه الرئيسي

---

## 📊 إحصائيات المشروع

```
Frontend Components:  30+
Backend Routes:      8+
Database Models:     5+
Total Files:         150+
Lines of Code:       10000+
```

---

## 🔍 البحث عن ملف

**البحث عن مكون معين:**
```bash
# البحث عن "Profile" في المكونات
find src/components -name "*Profile*"

# البحث عن "auth" في المسارات
find server/routes -name "*auth*"
```

---

## 📝 ملاحظات مهمة

1. **الأسماء بـ PascalCase**: `MyComponent.tsx`
2. **الملفات الصغيرة والمركزة**: مكون واحد = ملف واحد
3. **التصدير الصحيح**: `export function` أو `export default`
4. **التنظيم الهرمي**: التطبيقات الكبيرة في تطبيقات صغيرة

---

**آخر تحديث**: 5/4/2026
