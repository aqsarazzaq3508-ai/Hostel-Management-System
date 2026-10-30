HOSTELHUB - HOSTEL MANAGEMENT SYSTEM
====================================

This student project uses HTML for page structure, CSS for the design, JavaScript for browser interactions, PHP for a small backend/API, and MySQL for persistent data. Use it through XAMPP, not by double-clicking index.html.

FILES
-----
index.html             Login, registration and portal layout (HTML)
assets/style.css       Responsive visual design (CSS)
assets/app.js          Interactions, forms and API requests (JavaScript)
config.php             MySQL connection settings (small PHP backend)
api/index.php          Login, registration, permissions and database operations (PHP)
database.sql           Tables and demo room/student/fee/request data (MySQL)

SETUP ON WINDOWS WITH XAMPP
---------------------------
1. Extract this ZIP file.
2. Copy the folder named HostelHub_HTML_Project into C:\xampp\htdocs\
3. Open XAMPP Control Panel and click Start next to Apache and MySQL.
4. Visit http://localhost/phpmyadmin/
5. Click Import, choose this project's database.sql, and click Import/Go.
6. The SQL script creates a new database named hostelhub_student_portal, so it will not overwrite your earlier demo database. If your MySQL root account has a password, open config.php and set DB_PASS to it. The default XAMPP setup often uses an empty password.
7. Open http://localhost/HostelHub_HTML_Project/

DEMO ADMIN LOGIN
----------------
Email: admin@hostelhub.local
Password: Admin@123
This is a demonstration password. Do not use it for a public/real deployment.

STUDENT USE
-----------
- Click Student registration on the login screen.
- Enter your name, email, phone (optional), and a password of at least 8 characters.
- Log in; your student dashboard will show your room, request, fee and complaint information.
- Browse rooms and request an available room.
- Track your room request status.
- View fees assigned to your student record by the administrator.
- Submit complaints and check their status.
- Use Log out to end the session.

ADMIN USE
---------
- Log in with the demo admin credentials above.
- Review students and room requests, approve/decline requests, assign fee records, mark fees paid for demo tracking, and resolve complaints.
- To assign a fee, open Fee Records and choose Add fee.

IMPORTANT
---------
This is a learning/demo project, not a production-ready system. The fee status feature does not collect real payments. Change the demo admin password and apply a stronger security review before any public deployment. The project files were syntax-checked, but you should test them on your own XAMPP setup.
