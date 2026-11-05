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


