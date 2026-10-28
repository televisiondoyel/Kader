# Aastha Grocery — PHP + MySQL project

এই প্রজেক্টে HTML আলাদা standalone site হিসেবে ব্যবহার করা হয়নি; PHP page template, CSS stylesheet এবং JavaScript interaction ব্যবহার করা হয়েছে। ব্রাউজারে PHP চালাতে PHP-enabled server ও MySQL/MariaDB প্রয়োজন।

## অন্তর্ভুক্ত
- Reference-এর কাছাকাছি সবুজ grocery storefront layout
- Admin panel: dark navy sidebar, white header, Orders table + right-side Filter panel
- Admin login (password hash), one-time setup flow, CSRF token, session regeneration
- Product CRUD, category CRUD, product image upload validation
- Order list/filter/detail/status update, customer list, dashboard totals
- Customer storefront, search, category navigation, cart, COD checkout, stock decrement, order tracking
- Responsive CSS for desktop/tablet/mobile

## Local setup (XAMPP)
1. ZIP extract করে `aastha_php_project` folder-টি `C:/xampp/htdocs/`-এ রাখুন।
2. XAMPP থেকে Apache ও MySQL চালু করুন।
3. phpMyAdmin-এ `database.sql` import করুন। এটি `aastha_grocery` database ও demo products তৈরি করবে।
4. `config.php`-এ DB_HOST, DB_NAME, DB_USER, DB_PASS ঠিক আছে কিনা দেখুন।
5. ব্রাউজারে `http://localhost/aastha_php_project/setup-admin.php` খুলে admin username এবং শক্তিশালী password তৈরি করুন (password কমপক্ষে 12 characters)।
6. Admin তৈরি হলে **setup-admin.php মুছে ফেলুন**।
7. Store: `http://localhost/aastha_php_project/`
8. Admin: `http://localhost/aastha_php_project/admin/login.php`

## Hosting
- PHP 8.1+ এবং MySQL/MariaDB hosting ব্যবহার করুন।
- `config.php`-এ hosting-এর database credentials দিন।
- `uploads/` directory-তে PHP process-এর write permission দিন (প্রয়োজনে directory তৈরি হবে)।
- HTTPS চালু করুন; admin password শক্তিশালী রাখুন; নিয়মিত database backup রাখুন।
- `setup-admin.php` অবশ্যই মুছে ফেলুন।

## গুরুত্বপূর্ণ সীমাবদ্ধতা ও পরবর্তী কাজ
- Customer account/registration, email/SMS OTP, coupon, delivery-agent login, product gallery/banners, automated notification এবং live multi-user access এই starter build-এ সম্পূর্ণ করা হয়নি।
- Settings form values database-এ সেভ করে; delivery fee/brand name settings-এর সব জায়গায় dynamic wiring production setup-এর আগে সম্পূর্ণ করতে হবে।
- Uploaded product image path local server-এর `uploads/` folder-এ রাখা হয়।
- Demo product art CSS placeholder; আপনার reference-এর প্রকৃত পণ্যের ছবি ব্যবহার করতে admin থেকে product image upload করুন।
- Production-এর আগে server-side rate limiting, backup/restore, order audit logs, permissions/roles, secure cookie flags, upload hardening, deployment tests এবং privacy policy যুক্ত করুন।
- Reference ছবির সঙ্গে একেবারে pixel-perfect হওয়া সম্ভব নয়, কারণ original source assets, exact fonts, logo files ও product banner images দেওয়া হয়নি; layout, green storefront direction এবং navy/blue admin order/filter composition অনুসরণ করা হয়েছে.
