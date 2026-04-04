# ⚡ Quick Start - البدء السريع

الطريقة الأسرع للبدء مع Deraya-Edge.

## 30 ثانية للتثبيت

```bash
# 1. استنساخ المشروع
git clone <repo-url> && cd deraya-edge

# 2. تثبيت الاعتماديات
npm install && cd server && npm install && cd ..

# 3. تشغيل في طرفيتين:
# Terminal 1:
npm run dev

# Terminal 2:
cd server && npm start

# 4. افتح المتصفح
# http://localhost:8080 ✅
```

---

## هل واجهت مشكلة؟

### الموقع أبيض / لا يحمل
```bash
# تأكد من تشغيل كلا الخادمين
# Terminal 1: npm run dev
# Terminal 2: cd server && npm start

# إذا استمرت المشكلة:
rm -rf node_modules server/node_modules package-lock.json
npm install && cd server && npm install && cd ..
```

### "Cannot find module"
```bash
# أعد التثبيت
npm install
cd server && npm install && cd ..
```

### "Address already in use"
```bash
# المنفذ مشغول، استخدم منفذًا مختلفًا
# في vite.config.ts: port: 8081
# في server/.env: PORT=5001
```

---

## 📚 الملفات الموثقة

| الملف | الوصف |
|------|--------|
| **README.md** | نظرة عامة على المشروع |
| **SETUP_GUIDE.md** | إعداد تفصيلي |
| **QUICK_START.md** | هذا الملف - بدء سريع |
| **DEVELOPER.md** | دليل المطورين |
| **TROUBLESHOOTING.md** | حل المشاكل |
| **DEPLOYMENT.md** | نشر في الإنتاج |

## 🚀 الأوامر الأساسية

```bash
# تطوير
npm run dev          # فرونتند (Vite)
cd server && npm start  # باكند (Express)

# بناء
npm run build        # بناء الفرونتند

# فحص
npm run lint         # فحص الأخطاء

# معاينة
npm run preview      # معاينة البناء

# صحة النظام
node check-health.js # فحص جاهزية البيئة
```

## 🔗 المتطلبات

- ✅ Node.js 16+ (تحقق: `node --version`)
- ✅ npm أو yarn
- ✅ Git
- ✅ متصفح ويب حديث

## 🎯 الخطوات التالية

1. **تشغيل الفرونتند**: `npm run dev`
2. **تشغيل الباكند**: `cd server && npm start`
3. **الوصول للتطبيق**: http://localhost:8080
4. **عرض الوثائق**: اقرأ DEVELOPER.md

## ❓ أسئلة متكررة

**س: أين أضع ملفات .env؟**
> `.env.development.local` في الجذر و `server/.env.development.local` في مجلد server

**س: كيف أُضيف مسار API جديد؟**
> اقرأ قسم "إضافة مسار API" في DEVELOPER.md

**س: كيف أشغّل الاختبارات؟**
> حالياً لا توجد اختبارات مثبتة. يمكنك إضافتها باتباع قسم Testing في DEVELOPER.md

**س: كيف أنشر التطبيق؟**
> اقرأ DEPLOYMENT.md للتعليمات الكاملة

---

## 🆘 الحصول على الدعم

1. اقرأ **TROUBLESHOOTING.md** أولاً
2. افتح وحدة المطور (F12) واعرض أي أخطاء
3. تحقق من أن الخادمين يعملان
4. جرّب `node check-health.js`

---

**Happy Coding! 🎉**

آخر تحديث: 5/4/2026
