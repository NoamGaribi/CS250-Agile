![Project Banner](docs/imgs/DEGREE_PLANNER_BANNER.jpg)

# CS250-Agile

Team members:
- Jacobo Ramos
- Liliana Carrillo
- Ryder Garcia
- Noam Garibi

Inherited Group members:
Sunny Suarez

## Tech Stack
- React
- Next.js
- TypeScript
- MySQL
- Node.js / npm 


### In order to run code:
#### 1. Install Requirements
Make sure you have the following installed:
- Node.js
- npm
- MySQL
If you are not sure, you can verify Node.js and npm with:
```bash
node --version
npm --version
```

#### 2. Clone the repository
run:
```bash 
git clone https://github.com/NoamGaribi/CS250-Agile.git
```
```bash
cd CS250-Agile
```

#### 3. Enter the Next.js app
```bash
cd my-app
```

#### 4. Install dependencies
```bash
npm install
```

#### 5. Configue Database Connection
You will need to upload the SQL Database to a hosting service for it to function. The SQL Database build query is provided in the file on: (PLACEHOLDER DIRECTORY, will be provided later)

After that, create an .env.local file inside the my-app folder.

```env
Add: 
DB_HOST=your_database_host
DB_PORT=3306
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_NAME=degree_planner
AUTH_SECRET =  your_auth_secret, generate by "running npx auth secret"
```

Those values are used by app/lib/db.ts
(db stands for database). This is so the application can connect to MySQL.
The MySQL database and required tables must exist before using any database-dependen features.
In the same folder where the database file is, an EER Diagram picture is also provided, showing the general structure of the database.
Keep in mind that the database does NOT contain ALL of the SDSU courses, only a few selection necessary a Computer Science student to graduate. Personally, we used Aiven because it had a 30 day free trial which was enough for us.

#### 6. Start the development server
Run: 
```bash
npm run dev
```
If the server starts successfully then Next.js will display the local address, something like: ```http://localhost:3000```. Open that address in your browser of preference.

#### 7. Expected Result
You should see the log-in page with the sing-up options too.


##### Database Dependent Features
The project has backend support for:
- User Authentication
- Course Catalog Data
- Course Sections
- Prerequisites
- Degree Requiremetns
- Student Degree Progress
- Planning Preferences
- Degree Audit Parsing and Storing
- Future course recommendations and roadmap generation.



## How to run the tests
 
Our team has [automated unit tests / manual tests only: teammate to confirm] and manual browser tests. Each person's manual test cases are in `docs/testing/test-cases/` (one file per person) with exact steps, test data, and expected results.
 
### Setup (first time only)
1. Clone the repo: `git clone https://github.com/NoamGaribi/CS250-Agile.git`
2. Go to the app folder: `cd CS250-Agile/my-app`
3. Install dependencies: `npm install`
4. Create `my-app/.env.local` with the database settings. Ask a teammate for the values. Never commit this file.
5. Start the app: `npm run dev`, then open http://localhost:3000. Leave this terminal running.
6. To check the database, connect a MySQL client such as DBeaver to the `degree_planner` database using the same settings.

### Test account used by the Accounts and login tests
- Email: `blah@example.com`
- Password: `Password!`
Create it first by running test SS-03 below.

---
 
### (Sunny Suarez)
 
Keep the browser Console (F12) and the `npm run dev` terminal visible while testing.
 
| Test | What it checks | Steps | Expected result |
|---|---|---|---|
| SS-03 | Sign up, log in, reach the dashboard | 1. Open `/signup`. 2. Enter a name, `blah@example.com`, and `Password!` in both password boxes, then submit. 3. If you are not logged in automatically, log in at `/` with the same details. | You land on `/dashboard`. No error is shown. |
| SS-01 | Wrong password is rejected | 1. Open `/`. 2. Log in as `blah@example.com` with `WrongPass1`. | The page reloads at `/?error=CredentialsSignin` and shows "Invalid email or password." |
| SS-02 | Dashboard is protected | 1. Open a private browser window. 2. Go to `localhost:3000/dashboard`. | The browser ends up at `/` and shows the login form. |
| SS-04 | Password stored as a bcrypt hash | In DBeaver run: `SELECT email, password_hash FROM user WHERE email = 'blah@example.com';` | One row. `password_hash` starts with `$2b$12$` and is not `Password!`. |
| SS-05 | Returning user can sign back in | 1. Sign out from the dashboard. 2. Log in again as `blah@example.com` with `Password!`. | You reach `/dashboard` without creating a new account. |
| E1 | Empty signup form | Open `/signup`, leave all fields blank, submit. | A required-field message appears and no account is created. |
| E2 | Duplicate email | Sign up again with `blah@example.com`. | The page shows "An account with this email already exists." Only one row exists for that email in the `user` table. |
| E3 | Email capitalization | Log in as `BLAH@example.com` with `Password!`. | You reach `/dashboard`. |
| E4 | Short password | Sign up as `edge1@example.com` with the password `a`. | The signup is rejected and no account is created. |
| SS-06 | Email length limit (Issue fixed in PR) | 1. Create a 300-character email: run `python3 -c "print('a'*300 + '@example.com', end='')" \| pbcopy`. 2. Open `/signup`, paste it into the email field, enter a name and `Password!` in both password boxes, then submit. | The page shows "Email must be 255 characters or fewer." at `/signup?error=EmailTooLong`. The terminal shows no `ER_DATA_TOO_LONG` error. |
| SS-07 | Name length limit (Issue fixed in PR) | 1. Create a 300-letter name: run `python3 -c "print('a'*300, end='')" \| pbcopy`. 2. Open `/signup`, paste it into the name field, enter `edge4@example.com` and `Password!` in both password boxes, then submit. | The page shows "Name must be 100 characters or less." at `/signup?error=NameTooLong`. The terminal shows no `ER_DATA_TOO_LONG` error. |
 
---
 
### (Yuno Dela Pena)

---
 
### (Jania Little)
 
---
 
### After every merge to `main`
1. Pull the latest `main` and restart the app (`git pull`, then `npm run dev`).
2. Run every test above, not just the one that changed.
3. If an old test now fails, log it in the Regression Log in `docs/PR4/PR4_team_report.md` and file a new Issue.
