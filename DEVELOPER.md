# 👨‍💻 Developer Guide - دليل المطورين

دليل سريع للمطورين الذين يعملون على مشروع Deraya-Edge.

## 🎯 البدء السريع

```bash
# 1. استنساخ المستودع
git clone <repo-url>
cd deraya-edge

# 2. تثبيت الاعتماديات
npm install
cd server && npm install && cd ..

# 3. تشغيل البيئة
# Terminal 1: الفرونتند
npm run dev

# Terminal 2: الباكند
cd server && npm start
```

---

## 🗂️ هيكل المشروع

```
src/
├── components/          # مكونات React
│   ├── ui/             # مكونات UI الأساسية
│   ├── Navbar.tsx      # شريط التنقل
│   ├── Footer.tsx      # التذييل
│   └── ...             # مكونات أخرى
├── pages/              # الصفحات الرئيسية
│   ├── HomePage.tsx
│   ├── CoursesPage.tsx
│   └── ...
├── contexts/           # React Context للـ State
│   └── AuthContext.tsx # سياق المصادقة
├── services/           # خدمات API
│   └── api.ts
├── integrations/       # التكاملات الخارجية
│   └── supabase/
├── hooks/              # React Hooks مخصصة
└── App.tsx             # المكون الرئيسي

server/
├── routes/             # مسارات API
│   ├── auth.routes.js
│   ├── user.routes.js
│   └── ...
├── models/             # نماذج Sequelize
│   ├── User.js
│   ├── Post.js
│   └── ...
├── config/             # التكوينات
│   └── passport.js
├── middlewares/        # Middlewares
│   └── auth.middleware.js
└── server.js           # نقطة الدخول الرئيسية
```

---

## 💻 أوامر التطوير المهمة

```bash
# تشغيل الفرونتند (hot reload)
npm run dev

# بناء الفرونتند
npm run build

# معاينة البناء
npm run preview

# فحص الأخطاء
npm run lint

# تشغيل الباكند
cd server && npm start

# فحص التبعيات
npm outdated
npm audit
```

---

## 🔗 كيفية إضافة مسار API جديد

### 1. إنشاء ملف مسار جديد

```javascript
// server/routes/example.routes.js
const express = require('express');
const router = express.Router();
const { authMiddleware } = require('../middlewares/auth.middleware');

// GET /api/example
router.get('/', async (req, res) => {
  try {
    // منطقك هنا
    res.json({ message: 'Success' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/example
router.post('/', authMiddleware, async (req, res) => {
  try {
    const { data } = req.body;
    // منطقك هنا
    res.status(201).json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
```

### 2. تسجيل المسار في server.js

```javascript
// server/server.js
const exampleRoutes = require('./routes/example.routes');

app.use('/api/example', exampleRoutes);
```

### 3. استخدام المسار من الفرونتند

```typescript
// src/components/Example.tsx
import { apiFetch } from '@/services/api';

async function fetchExample() {
  try {
    const data = await apiFetch('/example');
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}
```

---

## 🎨 إضافة مكون جديد

### 1. إنشاء المكون

```typescript
// src/components/Example.tsx
import { useState } from 'react';

interface ExampleProps {
  title: string;
  onClick?: () => void;
}

export function Example({ title, onClick }: ExampleProps) {
  const [isLoading, setIsLoading] = useState(false);

  return (
    <div className="p-4 bg-card rounded-lg border border-border">
      <h2 className="text-lg font-semibold text-foreground">{title}</h2>
      <button
        onClick={onClick}
        className="mt-4 px-4 py-2 bg-primary text-primary-foreground rounded-md hover:opacity-90"
      >
        Click Me
      </button>
    </div>
  );
}
```

### 2. استخدام المكون

```typescript
// src/pages/HomePage.tsx
import { Example } from '@/components/Example';

export default function HomePage() {
  return (
    <div>
      <Example title="Welcome" onClick={() => console.log('clicked')} />
    </div>
  );
}
```

---

## 📝 نمط المصادقة

### تسجيل المستخدم

```typescript
// استخدم AuthContext
import { useAuth } from '@/contexts/AuthContext';

export function SignUp() {
  const { register } = useAuth();

  const handleSignUp = async (email: string, password: string) => {
    try {
      await register(email, password);
    } catch (error) {
      console.error('Sign up failed:', error);
    }
  };

  return (
    <form onSubmit={(e) => {
      e.preventDefault();
      // استدع handleSignUp
    }}>
      {/* form fields */}
    </form>
  );
}
```

### الوصول إلى بيانات المستخدم

```typescript
import { useAuth } from '@/contexts/AuthContext';

export function Profile() {
  const { user, loading } = useAuth();

  if (loading) return <div>Loading...</div>;
  if (!user) return <div>Not authenticated</div>;

  return <div>Welcome, {user.email}</div>;
}
```

---

## 🗄️ العمل مع Supabase

### نموذج Database

```typescript
// src/integrations/supabase/types.ts
export interface Tables {
  users: {
    Row: {
      id: string;
      email: string;
      display_name: string;
    };
    Insert: {
      email: string;
      display_name: string;
    };
    Update: {
      display_name?: string;
    };
  };
}
```

### استعلام البيانات

```typescript
import { supabase } from '@/integrations/supabase/client';

async function getUsers() {
  const { data, error } = await supabase
    .from('users')
    .select('*')
    .limit(10);

  if (error) throw error;
  return data;
}
```

---

## 🎯 أفضل الممارسات

### 1. معالجة الأخطاء

```typescript
// ✓ صحيح
try {
  const data = await apiFetch('/api/data');
  return data;
} catch (error) {
  console.error('Failed to fetch data:', error);
  throw new Error('Unable to load data');
}

// ✗ خطأ
const data = await apiFetch('/api/data'); // قد يفشل بدون معالجة
```

### 2. تجنب N+1 Queries

```javascript
// ✓ صحيح
const users = await User.findAll({
  include: [{ model: Post }] // تحميل العلاقات مع استعلام واحد
});

// ✗ خطأ
const users = await User.findAll();
users.forEach(user => {
  user.posts = await user.getPosts(); // استعلام منفصل لكل مستخدم!
});
```

### 3. استخدام React Query (Hooks)

```typescript
import { useQuery } from '@tanstack/react-query';

export function UsersList() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['users'],
    queryFn: () => apiFetch('/users'),
  });

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <ul>
      {data?.map(user => (
        <li key={user.id}>{user.email}</li>
      ))}
    </ul>
  );
}
```

### 4. تسمية المتغيرات

```typescript
// ✓ واضح ومفهوم
const isUserAuthenticated = user !== null;
const userEmail = user?.email;
const handleFormSubmit = () => { /* ... */ };

// ✗ غير واضح
const auth = user !== null;
const email = user?.email;
const submit = () => { /* ... */ };
```

---

## 🧪 الاختبار

### كتابة اختبار بسيط

```typescript
// src/components/Example.test.tsx
import { render, screen } from '@testing-library/react';
import { Example } from './Example';

describe('Example Component', () => {
  it('renders with title', () => {
    render(<Example title="Test Title" />);
    expect(screen.getByText('Test Title')).toBeInTheDocument();
  });

  it('calls onClick when button is clicked', () => {
    const handleClick = jest.fn();
    render(<Example title="Test" onClick={handleClick} />);
    
    const button = screen.getByRole('button', { name: /click me/i });
    button.click();
    
    expect(handleClick).toHaveBeenCalled();
  });
});
```

---

## 🔒 الأمان

### 1. التحقق من المدخلات (Input Validation)

```typescript
import { z } from 'zod';

const userSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

// استخدام
const result = userSchema.parse(userData); // سيرمي خطأ إذا كانت البيانات غير صحيحة
```

### 2. استخدام متغيرات البيئة

```typescript
// ✓ صحيح
const API_URL = process.env.VITE_API_URL || 'http://localhost:5000/api';

// ✗ خطأ - لا تكود المفاتيح!
const API_URL = 'sk_live_abc123...';
```

### 3. معالجة الـ CORS

```javascript
// server/server.js
app.use(cors({
  origin: process.env.FRONTEND_URL,
  credentials: true,
  optionsSuccessStatus: 200
}));
```

---

## 🐛 Debugging

### استخدام DevTools

```typescript
// في المتصفح
console.log('[Component Name]', variableName);
console.error('[Error]', errorMessage);
console.table(arrayData); // لعرض البيانات في جدول
```

### في الباكند

```javascript
// server/server.js
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});
```

---

## 📚 المراجع المفيدة

- [React Documentation](https://react.dev)
- [Vite Documentation](https://vitejs.dev)
- [Express Documentation](https://expressjs.com)
- [Supabase Documentation](https://supabase.com/docs)
- [Tailwind CSS](https://tailwindcss.com)

---

## ✅ قائمة تحقق للـ Code Review

- [ ] الكود يتبع أسلوب المشروع
- [ ] لا توجد تحذيرات في console
- [ ] تم اختبار جميع المسارات
- [ ] معالجة الأخطاء موجودة
- [ ] البيانات الحساسة غير معرضة
- [ ] الأداء مقبول
- [ ] التوثيق محدث

---

**آخر تحديث**: 5/4/2026
