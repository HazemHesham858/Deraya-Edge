# 🚀 Deraya-Edge Setup Guide

تطبيق Deraya-Edge يتكون من جزأين:
1. **الفرونتند (Frontend)**: تطبيق React مع Vite
2. **الباكند (Backend)**: خادم Express

## المتطلبات الأساسية

- Node.js 16+ و npm أو yarn
- Git
- متصفح ويب حديث

## التثبيت السريع

### 1. تثبيت الاعتماديات

```bash
# تثبيت اعتماديات الفرونتند
npm install

# تثبيت اعتماديات الباكند
cd server
npm install
cd ..
```

### 2. إعداد متغيرات البيئة

#### الفرونتند (.env.development.local)
```
# المتغيرات الموجودة بالفعل في الملف
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
```

#### الباكند (server/.env.development.local)
```
PORT=5000
JWT_SECRET=your_secret_key_here
FRONTEND_URL=http://localhost:8080
```

## طرق التشغيل

### الطريقة 1: تشغيل في نفس الوقت (موصى به للتطوير)

**الطرفية الأولى - تشغيل الفرونتند:**
```bash
npm run dev
```
الفرونتند سيكون متاح على: http://localhost:8080

**الطرفية الثانية - تشغيل الباكند:**
```bash
cd server
npm start
```
الباكند سيكون متاح على: http://localhost:5000

### الطريقة 2: البناء والإنتاج

```bash
# بناء الفرونتند
npm run build

# تثبيت اعتماديات الباكند
cd server
npm install
cd ..

# تشغيل التطبيق
npm start
```

## هيكل المشروع

```
deraya-edge/
├── src/                          # الكود الخاص بـ React
│   ├── components/              # مكونات React
│   ├── pages/                   # صفحات التطبيق
│   ├── contexts/                # React Context للـ State
│   ├── services/                # خدمات API
│   └── App.tsx                  # المكون الرئيسي
├── server/                       # الكود الخاص بـ Express
│   ├── routes/                  # مسارات API
│   ├── models/                  # نماذج قاعدة البيانات
│   ├── config/                  # التكوينات (Passport, إلخ)
│   └── server.js                # نقطة دخول الخادم
├── public/                       # الملفات الثابتة
└── package.json                 # الاعتماديات
```

## استكشاف الأخطاء

### المشكلة: "Cannot find module" أو أخطاء الاعتماديات
```bash
# حل: إعادة تثبيت الاعتماديات
npm install
cd server && npm install && cd ..
```

### المشكلة: الفرونتند لا يتصل بالباكند
- تأكد من تشغيل الباكند على المنفذ 5000
- تحقق من أن `API_URL` في `src/services/api.ts` صحيح
- افتح أدوات المطور (F12) وتحقق من رسائل الخطأ

### المشكلة: قاعدة البيانات SQLite تعطل
```bash
# حل: حذف قاعدة البيانات وإعادة إنشاؤها
rm server/deraya_research.sqlite
cd server && npm start
```

## متغيرات البيئة المهمة

| المتغير | المكان | الوصف |
|---------|-------|--------|
| PORT | server/.env | منفذ الخادم (default: 5000) |
| JWT_SECRET | server/.env | مفتاح التوقيع للرموز |
| FRONTEND_URL | server/.env | عنوان الفرونتند للـ CORS |
| NEXT_PUBLIC_SUPABASE_URL | .env | عنوان Supabase |
| NEXT_PUBLIC_SUPABASE_ANON_KEY | .env | مفتاح Supabase العام |

## أوامر مفيدة

```bash
# تشغيل الفرونتند في وضع التطوير
npm run dev

# بناء الفرونتند للإنتاج
npm run build

# معاينة البناء
npm run preview

# تشغيل الخادم
npm start

# فحص الأخطاء (ESLint)
npm run lint
```

## التوسع والتطوير

- **إضافة مسار API جديد**: أنشئ ملف في `server/routes/`
- **إضافة مكون جديد**: أنشئ ملف في `src/components/`
- **إضافة صفحة جديدة**: أنشئ ملف في `src/pages/`
- **تعديل النماذج**: عدّل الملفات في `server/models/`

## الدعم والمساعدة

إذا واجهت أي مشاكل، تحقق من:
1. معاينة الخادم في وحدة التحكم
2. أدوات تطوير المتصفح (F12)
3. ملفات السجل إن وجدت
4. التأكد من تثبيت جميع الاعتماديات

---

**آخر تحديث**: 5/4/2026
