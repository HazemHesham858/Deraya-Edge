# 🔧 دليل استكشاف الأخطاء

## المشاكل الشائعة والحلول

### 1. ❌ الموقع لا يعمل / صفحة بيضاء

**الأسباب المحتملة:**
- الفرونتند لم يتم بناؤه
- الاعتماديات لم تُثبت بشكل صحيح
- أخطاء في ملفات التكوين

**الحل:**
```bash
# 1. حذف node_modules والـ lock files
rm -rf node_modules package-lock.json
rm -rf server/node_modules server/package-lock.json

# 2. إعادة التثبيت
npm install
cd server && npm install && cd ..

# 3. تشغيل الفرونتند
npm run dev

# في طرفية أخرى، تشغيل الباكند
cd server && npm start
```

---

### 2. ❌ خطأ: "Cannot GET /"

**الأسباب:**
- الفرونتند لم يتم بناؤه
- Vite لم يبدأ بشكل صحيح
- المنفذ 8080 مستخدم من تطبيق آخر

**الحل:**
```bash
# تأكد من تشغيل npm run dev
npm run dev

# إذا كان المنفذ مشغول، غيّر المنفذ في vite.config.ts:
# server: {
#   host: '::',
#   port: 8081  // أو أي منفذ آخر متاح
# }
```

---

### 3. ❌ خطأ: "API_URL is not defined"

**السبب:** لم تتصل الفرونتند بالباكند بشكل صحيح

**الحل:**
```bash
# تأكد من تشغيل الباكند على المنفذ 5000
cd server && npm start

# تحقق من أن API_URL في src/services/api.ts صحيح:
# const API_URL = 'http://localhost:5000/api';

# تحقق من وحدة تحكم المتصفح (F12) للأخطاء
```

---

### 4. ❌ "EADDRINUSE: address already in use :::5000"

**السبب:** المنفذ 5000 مستخدم من عملية أخرى

**الحل:**
```bash
# البحث عن العملية التي تستخدم المنفذ
# على Windows:
netstat -ano | findstr :5000

# على macOS/Linux:
lsof -i :5000

# قتل العملية (استبدل PID برقم العملية الفعلي):
# على Windows:
taskkill /PID <PID> /F

# على macOS/Linux:
kill -9 <PID>

# أو استخدم منفذ مختلف في server/.env.development.local:
# PORT=5001
```

---

### 5. ❌ "Cannot find module 'express'" أو أخطاء اعتماديات

**السبب:** اعتماديات الباكند لم تُثبت

**الحل:**
```bash
# تثبيت اعتماديات الباكند
cd server
npm install
npm install express cors dotenv express-session passport passport-google-oauth20 passport-microsoft sequelize sqlite3 bcrypt jsonwebtoken multer

cd ..
```

---

### 6. ❌ خطأ في Supabase: "Invalid API key"

**السبب:** مفاتيح Supabase غير صحيحة

**الحل:**
1. تحقق من أن `.env.development.local` يحتوي على المفاتيح الصحيحة
2. انسخ المفاتيح من لوحة تحكم Supabase الخاصة بك
3. تأكد من عدم وجود مسافات إضافية في الملف

---

### 7. ❌ "CORS Error" أو "Access-Control-Allow-Origin"

**السبب:** مشكلة في CORS عند تواصل الفرونتند مع الباكند

**الحل:**
```bash
# تحقق من أن server.js يحتوي على:
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:8080',
  credentials: true
}));

# تأكد من أن FRONTEND_URL في server/.env.development.local صحيح:
FRONTEND_URL=http://localhost:8080
```

---

### 8. ❌ "Cannot GET /api/health"

**السبب:** الباكند لم يبدأ بشكل صحيح

**الحل:**
```bash
# تأكد من تشغيل:
cd server
npm start

# يجب أن ترى:
# Server is running on port 5000
# SQLite Database Synced Successfully

# اختبر الاتصال:
# في المتصفح أو Postman:
# GET http://localhost:5000/api/health
```

---

### 9. ❌ "Database Sync Error" أو مشاكل SQLite

**السبب:** مشكلة في قاعدة البيانات

**الحل:**
```bash
# حذف قاعدة البيانات القديمة
rm server/deraya_research.sqlite

# إعادة تشغيل الباكند لإعادة إنشاء قاعدة البيانات
cd server && npm start

# إذا استمرت المشكلة، تحقق من صلاحيات المجلد
# تأكد من أن لديك إذن بالكتابة في مجلد server/
```

---

### 10. ❌ "Module not found" أو أخطاء الاستيراد

**السبب:** المسارات أو الاستيرادات خاطئة

**الحل:**
```bash
# للفرونتند (React)
# تأكد من أن tsconfig.json يحتوي على:
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}

# للباكند (Express)
# استخدم require بشكل صحيح:
const express = require('express');
const User = require('../models/User');
```

---

## قائمة تحقق قبل البدء

- [ ] تثبيت Node.js 16+
- [ ] تثبيت جميع الاعتماديات: `npm install && cd server && npm install && cd ..`
- [ ] نسخ .env.example إلى .env.development.local
- [ ] الحصول على مفاتيح Supabase وإضافتها
- [ ] تشغيل الفرونتند: `npm run dev`
- [ ] تشغيل الباكند: `cd server && npm start`
- [ ] التحقق من الوصول إلى http://localhost:8080
- [ ] التحقق من الوصول إلى http://localhost:5000/api/health

## الأدوات المفيدة

### Postman أو Insomnia
لاختبار نقاط نهاية API بدون الحاجة إلى الفرونتند

### DevTools المتصفح (F12)
- Network tab: لرؤية طلبات API والأخطاء
- Console: لرؤية رسائل الخطأ من JavaScript
- Storage: للتحقق من localStorage والـ cookies

### Terminal/PowerShell
```bash
# اختبار الاتصال بالباكند
curl http://localhost:5000/api/health

# على Windows PowerShell:
Invoke-WebRequest http://localhost:5000/api/health
```

---

## هل لا تزال تواجه مشاكل؟

1. تحقق من رسائل الخطأ في console/terminal بعناية
2. تأكد من تشغيل كلا الخادمين (الفرونتند والباكند)
3. جرب مسح المتصفح cache (Ctrl+Shift+Delete)
4. أعد تشغيل كلا الخادمين
5. حاول في متصفح مختلف

---

**آخر تحديث**: 5/4/2026
