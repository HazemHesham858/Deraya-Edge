# Deraya-Edge 🎓

منصة تعليمية وبحثية متقدمة تجمع بين المجتمع الأكاديمي والبحث العلمي والتعليم المستمر.

## البدء السريع ⚡

### المتطلبات
- Node.js 16+ و npm
- Git

### التثبيت والتشغيل

```bash
# 1. تثبيت جميع الاعتماديات
npm install
cd server && npm install && cd ..

# 2. في طرفية (Terminal 1) - تشغيل الفرونتند
npm run dev

# 3. في طرفية أخرى (Terminal 2) - تشغيل الباكند
cd server
npm start
```

**سيكون التطبيق متاح على**: http://localhost:8080  
**الـ API متاح على**: http://localhost:5000/api

---

## دليل البدء التفصيلي 📖

للحصول على شرح مفصل للإعداد والتطوير، اطلع على:
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)** - دليل الإعداد الكامل
- **[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - حل المشاكل الشائعة

---

## كيفية تعديل الكود

**استخدام Lovable** (محررك الأصلي)

ببساطة زر [مشروع Lovable](https://lovable.dev/projects/1169db3a-30f3-49bc-bd0b-9cda42ae0ebe) وابدأ في التعديل.

**استخدام محرر النصوص المفضل لديك**

إذا أردت العمل محليًا، يمكنك استنساخ المستودع والمتابعة كالتالي:

---

## هيكل المشروع 📁

```
deraya-edge/
├── src/                     # كود React
│   ├── components/         # مكونات إعادة الاستخدام
│   ├── pages/              # صفحات التطبيق
│   ├── contexts/           # إدارة الحالة (State)
│   ├── services/           # خدمات API
│   └── integrations/       # التكاملات الخارجية
├── server/                  # خادم Express
│   ├── routes/             # مسارات API
│   ├── models/             # نماذج قاعدة البيانات
│   ├── config/             # التكوينات
│   └── server.js           # نقطة الدخول
├── public/                  # الملفات الثابتة
└── package.json            # الاعتماديات
```

---

## الميزات الرئيسية ✨

- 🎓 إدارة الدورات والتعليم
- 🔬 منصة البحث العلمي
- 📚 مكتبة المقالات والموارد
- 👥 المجتمع والتعاون
- 🤖 روبوت الدردشة الذكي (Don Chatbot)
- 🏆 نظام المشاريع والجوائز
- 👔 برامج التدريب الداخلي

---

## أوامر مفيدة 🛠️

```bash
# تشغيل الفرونتند في وضع التطوير
npm run dev

# بناء الفرونتند للإنتاج
npm run build

# معاينة البناء
npm run preview

# فحص الأخطاء
npm run lint

# تشغيل الباكند
cd server && npm start
```

---

## التكاملات المستخدمة 🔗

- **Supabase**: قاعدة البيانات والمصادقة
- **Vercel**: الاستضافة والنشر
- **Lucide Icons**: أيقونات الواجهة
- **shadcn/ui**: مكونات الواجهة
- **Tailwind CSS**: تنسيق الواجهة
- **Framer Motion**: الرسوم المتحركة

---

## الدعم والمساعدة 💬

هل تواجه مشاكل؟ جرب:
1. قراءة [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
2. فتح وحدة التحكم (F12) للبحث عن الأخطاء
3. التحقق من أن كلا الخادمين يعملان
4. إعادة تثبيت الاعتماديات

---

## الترخيص 📄

هذا المشروع مرخص تحت MIT License.

**آخر تحديث**: 5/4/2026
- Edit files directly within the Codespace and commit and push your changes once you're done.

## What technologies are used for this project?

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## How can I deploy this project?

Simply open [Lovable](https://lovable.dev/projects/1169db3a-30f3-49bc-bd0b-9cda42ae0ebe) and click on Share -> Publish.

## Can I connect a custom domain to my Lovable project?

Yes, you can!

To connect a domain, navigate to Project > Settings > Domains and click Connect Domain.

Read more here: [Setting up a custom domain](https://docs.lovable.dev/features/custom-domain#custom-domain)
