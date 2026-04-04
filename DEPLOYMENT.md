# 🚀 Deployment Guide - دليل النشر

دليل شامل لنشر تطبيق Deraya-Edge في بيئات الإنتاج.

## متطلبات النشر

- Node.js 16+
- npm أو yarn
- حساب في Vercel أو أي منصة استضافة أخرى
- مفاتيح Supabase صحيحة

---

## 1️⃣ النشر على Vercel (الطريقة الموصى بها)

### أ. ربط المستودع بـ Vercel

```bash
# إذا لم تثبت Vercel CLI بعد
npm i -g vercel

# الدخول إلى حسابك
vercel login

# نشر المشروع
vercel
```

### ب. إعدادات Vercel

```plaintext
Project Name: deraya-edge
Framework: Vite
Build Command: npm run build
Output Directory: dist
Development Command: npm run dev
```

### ج. متغيرات البيئة في Vercel

في لوحة تحكم Vercel، أضف المتغيرات التالية:

```plaintext
NEXT_PUBLIC_SUPABASE_URL=<your_supabase_url>
NEXT_PUBLIC_SUPABASE_ANON_KEY=<your_anon_key>
SUPABASE_URL=<your_supabase_url>
SUPABASE_SECRET_KEY=<your_secret_key>
```

### د. نشر الخادم (Backend)

يمكنك نشر Express Server على:
- **Railway**: https://railway.app
- **Render**: https://render.com
- **Heroku**: https://heroku.com
- **DigitalOcean**: https://digitalocean.com

---

## 2️⃣ النشر على Railway (للخادم)

### أ. إنشاء مشروع جديد

1. اذهب إلى https://railway.app
2. انقر على "New Project"
3. اختر "Deploy from GitHub"
4. اختر مستودعك

### ب. إعداد الخادم

```bash
# في Railway Dashboard
# أضف Service جديد (Node.js)

# في متغيرات البيئة:
PORT=5000
JWT_SECRET=<strong_secret_key>
FRONTEND_URL=https://your-vercel-domain.com
SUPABASE_URL=<your_supabase_url>
SUPABASE_SECRET_KEY=<your_secret_key>
```

### ج. أوامر البناء

```plaintext
Build Command: cd server && npm install
Start Command: cd server && npm start
```

---

## 3️⃣ البناء المحلي للإنتاج

### خطوات البناء

```bash
# 1. تثبيت الاعتماديات
npm install
cd server && npm install && cd ..

# 2. بناء الفرونتند
npm run build

# 3. اختبار البناء محليًا
npm run preview

# في طرفية أخرى:
cd server && npm start
```

### التحقق من البناء

```bash
# يجب أن تجد مجلد 'dist' يحتوي على:
# - index.html
# - assets/
# - _app/
```

---

## 4️⃣ Docker Deployment (خيارمتقدم)

### Dockerfile للفرونتند والباكند المدمجين

```dockerfile
# البناء
FROM node:18-alpine AS builder

WORKDIR /app

# تثبيت اعتماديات الفرونتند
COPY package*.json ./
RUN npm ci

# بناء الفرونتند
RUN npm run build

# الإنتاج
FROM node:18-alpine

WORKDIR /app

# تثبيت اعتماديات الباكند
COPY server/package*.json ./server/
RUN cd server && npm ci --production

# نسخ الفرونتند المبني
COPY --from=builder /app/dist ./dist

# نسخ الباكند
COPY server ./server

EXPOSE 5000

CMD ["node", "server/server.js"]
```

### بناء و تشغيل الصورة

```bash
# بناء الصورة
docker build -t deraya-edge:latest .

# تشغيل الحاوية
docker run -p 5000:5000 \
  -e PORT=5000 \
  -e JWT_SECRET=your_secret \
  -e FRONTEND_URL=http://localhost:5000 \
  deraya-edge:latest
```

---

## 5️⃣ قائمة تحقق قبل النشر

- [ ] جميع المتغيرات البيئية محددة
- [ ] لا توجد أخطاء في console (بعد npm run build)
- [ ] تم اختبار الفرونتند محليًا
- [ ] تم اختبار الباكند محليًا
- [ ] قاعدة البيانات معدة وجاهزة
- [ ] المفاتيح الحساسة آمنة ولا توجد في الكود
- [ ] استخدم HTTPS في الإنتاج
- [ ] فعّل CORS بشكل آمن

---

## 6️⃣ متغيرات البيئة الحرجة

| المتغير | الإنتاج | ملاحظات |
|---------|---------|--------|
| NODE_ENV | production | يجب تعيينها إلى production |
| PORT | 5000 | قد يختلف حسب المنصة |
| JWT_SECRET | قوي جدًا | لا تشاركه أبدًا |
| FRONTEND_URL | https://your-domain | يجب أن يكون HTTPS |
| SUPABASE_* | مفاتيح الإنتاج | استخدم حساب Supabase الإنتاج |

---

## 7️⃣ الرقابة والتسجيل

### تسجيل الأخطاء (Error Logging)

```javascript
// أضف هذا في server/server.js
app.use((err, req, res, next) => {
  console.error('Error:', err);
  // يمكنك إرسال الخطأ إلى خدمة مثل Sentry
  res.status(500).json({ error: 'Internal Server Error' });
});
```

### المراقبة

استخدم أدوات مثل:
- **Sentry**: لتتبع الأخطاء
- **LogRocket**: لتسجيل جلسات المستخدم
- **New Relic**: لمراقبة الأداء

---

## 8️⃣ الأمان

### نصائح الأمان الحرجة

1. **لا تصدر المفاتيح الحساسة في الكود**
   ```bash
   # خطأ ❌
   const API_KEY = 'abc123...'; // لا تفعل هذا
   
   # صحيح ✓
   const API_KEY = process.env.API_KEY;
   ```

2. **استخدم HTTPS في الإنتاج**
   ```javascript
   // في server/server.js
   app.use(cors({
     origin: 'https://your-domain.com', // فقط HTTPS
     credentials: true
   }));
   ```

3. **قيّد CORS بشكل آمن**
   ```javascript
   const allowedOrigins = ['https://your-domain.com'];
   app.use(cors({
     origin: (origin, callback) => {
       if (allowedOrigins.includes(origin)) {
         callback(null, true);
       } else {
         callback(new Error('Not allowed by CORS'));
       }
     }
   }));
   ```

4. **استخدم متغيرات البيئة للحساسيات**
   - JWT_SECRET
   - Database credentials
   - API keys

---

## 9️⃣ استكشاف مشاكل النشر

### المشكلة: "Build failed"

```bash
# تحقق من:
npm run build

# إذا فشل، اعرض الخطأ كاملاً وحاول الحل
npm run lint  # للتحقق من الأخطاء
```

### المشكلة: "Port is already in use"

```bash
# استخدم متغير PORT في البيئة
PORT=5001 npm start
```

### المشكلة: "Cannot connect to database"

```bash
# تأكد من:
# 1. متغيرات قاعدة البيانات صحيحة
# 2. الخادم يستطيع الوصول إلى Supabase
# 3. لا توجد قوائم انتظار تحد من الوصول
```

---

## 🔟 بعد النشر

### اختبر التطبيق المنشور

```bash
# اختبر الصفحة الرئيسية
curl https://your-domain.com/

# اختبر API
curl https://your-domain.com/api/health

# اختبر المصادقة
curl -X POST https://your-domain.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test123"}'
```

### رقابة مستمرة

- تحقق من logs بانتظام
- راقب استهلاك الموارد
- تحديث الاعتماديات بانتظام
- أخذ نسخ احتياطية من البيانات

---

## المراجع المفيدة

- [Vercel Docs](https://vercel.com/docs)
- [Railway Docs](https://railway.app/docs)
- [Docker Docs](https://docs.docker.com)
- [Supabase Docs](https://supabase.com/docs)
- [Express Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)

---

**آخر تحديث**: 5/4/2026
