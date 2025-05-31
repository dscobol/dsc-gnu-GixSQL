# Creating COBOL/PostgreSQL programs with GnuCOBOL using GixSQL

## NOTE: This is a "first attempt" at GnuCOBOL/PostgreSQL/GixSQL

"It works" but this is what I would call "the bare minimum" to get an application to run.

In the future, I hope to post better, more robust examples.

Running this program requires: (Versions used for this example in ()).

- PostgreSQL (14)
- GnuCOBOL (3.2.0)
- GixSQL (1.0.20a)

Here is the list of program names and descriptions in the code directory:

| Program  | Description                                                                                               |
| :------- | :-------------------------------------------------------------------------------------------------------- |
|          |                                                                                                           |
| TSQL001A | Sample program provided by GixSQL. Returns a count of the number of records. Modified to use a .env file. |

## A guide to working with this repository.

I have a certain structure on my computer.

For this application:

```
code
│   ├───bin
│   ├───cbl
│   ├───cpy
│   ├───docs
│   ├───jcl
│   └───tcbl
database
│   ├───scripts
│   └───Makefile
```

Within code:

- bin: the executables
- cbl: the COBOL source code
- cpy: the copybooks
- docs: public: examples of the files needed to run the programs
- jcl: the scripts used to compile and run
- tcbl: not public: temporary COBOL output

Within database:

- scripts: the SQL DDL code.
- Makefile: Create the table and insert the data.

### What's the difference between the cbl and the tcbl directories?

A convention when writing regular COBOL programs is to use the extension ".cbl".

When writing COBOL programs with embedded SQL EXEC statements, a convention is to use the extension ".sqb".

In the prep step, prep will convert all the SQL EXEC statements in the .sqb program to a CALL statement and write a new file out with an extension of .cbl to the tcbl directory.

In the compile step, the compiler will look for the "program.cbl" COBOL program in the tcbl directory.

Creating this temporary file could be done away with but if there is an error in the compile step, it is helpful to have the "fully expanded" version of the code available to look at to find the problem.

### Why are they not present?

Only the following directories are pushed to a public repository:

code: cbl, cpy, docs, jcl

database: all

The others are not public because they are either binary, temporary or they contain usernames and passwords. For examples of some of these, look in the docs directory.

## Running these programs on your system

Make sure your system meets the requirements listed above and you have cloned the repository to your system.

Complete these steps in this order:

Expanded instructions for the steps follow:

1. Create the missing directories
2. Create the gixsql DB
3. Run the Makefile to create the table and insert data
4. Create the .env file
5. Alter the ROLE to add password
6. Running the program

### Create the missing directories

Open Terminal, at the root of the code directory, Run:

```bash
mkdir bin tcbl
```

### Create the gixsql DB

As the normal userid:

In Terminal, Run:

```bash
createdb gixsql
```

**NOTE**: If this is the first time you are running "psql" as the normal userid, it will ERROR with a message about:
"database 'userid' does not exist".

If this is the case, In Terminal Run:

```bash
createdb xxxxxx
```

replacing xxxxx with your userid.

Then re-run the "createdb gixsql" command above.

**End NOTE**

### Run the Makefile to create the table and insert data

In Terminal, cd into the database directory

Run:

```bash
make
```

This will create a file "build.sql" containing the Create and Insert DDL code and then pass that into the DB.

Examine the Makefile for more info.

### Create the .env file

**IMPORTANT NOTE:**
The .env file will contain the userid and password to the database. **MAKE SURE** to add ".env" to your .gitignore(either global or local) so when you commit changes, the .env file will NOT be included.

Copy docs/Code-env.txt to the code root and rename to .env .

- Edit .env changing DB1name to the correct connection string , DB1role to your userid and DB1pswd to your password.

## Alter the ROLE to add password

As the "normal" userid, Run:

```bash
psql
```

This will take you into the PostgreSQL database system.

Run the following SQL statement BUT replace "userid" with your userid and "'password'" with your password (note: make sure to surround your password with single quotes as seen here.)

```sql
ALTER ROLE userid WITH PASSWORD 'password';
```

### Running the program - TSQL0001A

The "job" is divided into 2 scripts:

1. "prep, compile, and link"
2. "run".

In Terminal, cd into the code/jcl/ directory and Run:

```bash
./TSQL0001A-compile.sh
```

Watch the output. There should be 0 errors on the prep, press Enter to continue, and the compile should return "SUCCESS: Compile Return code is ZERO.".

If so, in Terminal, Run:

```bash
./TSQL0001A-run.sh
```

and the results will print on the screen.
