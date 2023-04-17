# DOS Interview Case Study

[https://github.com/Fikeem/software-engineer](https://github.com/Fikeem/software-engineer)

**ControlM**

- View jobs
- Associated properties (host/server, filename/script, file-path, job status)

**Jobs**

- Small rectangles grouped under "parent folder".
- **Grey (not executed), Yellow (executing), Green (completed), Red (fail)**
- Can be stopped/re-run as needed for bug fixing.

**Predecessors/Successors**

- Successor job must complete successfully (return 0) for predecessor job to execute.

---

### Exercise 1:

> Document [CONTROLM.md](http://controlm.md/) -> job status? -> output log? (\testdb01\log) -> ID/Document any issues/suggestions and explain resolution.
> 

The image suggests:

1. ***DB_QUERY_{1,2,4}*** run simultaneously.
2. ***DB_QUERY_{1,2}*** **(SUCCEED)** produce output ****that ***Script_3*** **(FAIL)** relies on.
3. ***DB_QUERY_4* (EXECUTES)** but does not complete, ~~relies on ***Script_3* (SUCCEED)**~~. 
4. ***ANALYSIS_COMPLETE*** is **(NOT EXECUTED)** due to ***DB_QUERY_4*** **(EXECUTE)** status & ***Script_3*** **(FAIL)** status. 

<aside>
💡 QUERY_3 is not assigned as a job?

</aside>

![200856215-404d664f-8dc0-49c1-9ae3-3c27261f7543.png](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200856215-404d664f-8dc0-49c1-9ae3-3c27261f7543.png)

![**SUCCEED**](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200856431-f1b23ab1-8ba6-4d1c-bf6f-9bc652f46555.png)

**SUCCEED**

<aside>
💡 ERROR:
ORA-01017: invalid username/password; logon denied

*SP2-0751: Unable to connect to Oracle.  Exiting SQL*Plus
The system cannot find the file specified.*

</aside>

- incorrect uname/pword in db_login.cmd

![**SUCCEED**](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200856496-80528e82-cc30-4440-ac60-a3446c4d7752.png)

**SUCCEED**

<aside>
💡 ERROR:
ORA-28000: The account is locked.

*SP2-0751: Unable to connect to Oracle.  Exiting SQL*Plus
The system cannot find the file specified.*

</aside>

- account locked in db_login.cmd

<aside>
💡 Both Query 1 and 2 provide a “openffs” argument instead of “opstest”. In a real use case, this would seem to fail. However, the logs indicate success?

Correcting this would not fix the misattribution of the error though, *db_login.cmd* should but updated to check for both 01017 and 28000 errors (incorrect/locked account)

</aside>

<aside>
💡 db_login.cmd should be updated catch account error exceptions and produce `myError=1` ; therefore, failing Q1 or Q2 after return.

</aside>

![**FAIL**](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200856599-f1a6c38e-82a0-49a3-a05e-76e6c3a3378f.png)

**FAIL**

![**EXECUTING…**](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200856678-a9acb46f-362c-4cb6-9604-e23c11de16d3.png)

**EXECUTING…**

Possibilities:

1. ~~Permissions~~
2. ***Incorrect File-pathing***
3. ~~Syntax Error~~
4. ~~Incorrect Env Variables~~

<aside>
💡 Unable to find the input files: (**`sql1.txt`**and **`sql2.txt`**) in the **`\testapp01\input`** **directory.

</aside>

<aside>
💡 With the updated logic, script_3 will terminate if either input file is not located, alternatively it can be adapted so that it will return success if at least one file is found by adjusting the analysis.csv conditional and removing the input conditionals:

</aside>

Possibilities:

1. ~~Permissions~~
2. ~~Connection Issue~~
3. ~~Syntax Error~~
4. ***Error in `sql` command***

<aside>
💡 Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.15.0.0.0

*SP2-0310: unable to open file "testdb01\sql**l**\query4.sql*

</aside>

- Unable to open the SQL file specified by: **`sqlplus`** command.
    
    Path-file String Error: `**\…\sqll\query4.sql**` → \…**`\sql\query4.sql`**
    

---

### Exercise 2:

> ControlM: Rick (DC) -> Morty (CHS) -> Morty runs (Copy_to_share.md) -> Why did it fail?
> 
> 
> **verified: location && permissions.**
> 

![200859504-3be09194-d48a-42cb-9687-7ecbc80dbc62.png](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200859504-3be09194-d48a-42cb-9687-7ecbc80dbc62.png)

![200859625-62691dde-222f-42c3-8e58-0a212bd62123.png](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200859625-62691dde-222f-42c3-8e58-0a212bd62123.png)

![200859659-f6d8267e-3ccf-4adc-bc9a-a6f0f4dcdb32.png](DOS%20Interview%20Case%20Study%202a7583bc0488409eb443e48499d4daf4/200859659-f6d8267e-3ccf-4adc-bc9a-a6f0f4dcdb32.png)

<aside>
💡 ERROR: The network path was not found.
0 file(s) copied.

</aside>

- The domain for the remote share is not specified, it is instead looking to the local network for a server/host named “*rm15fs01*”; Assuming “*rm15fs01*” is indeed a server on the `washdc.test.lab` domain, and all firewall and permission settings allow it, the location should instead be “`\\washdc.test.lab\rm15fs01\crms\`” and the local file’s location specified with the full path and drive letter. This also assumes the directory “*crms*” is the preferred directory, and not a subdirectory within.

```powershell
REM Local Server
copy \\localserver\path_to_directory\testapp01\output\test.txt \\washdc.test.lab\rm15fs01\crms\
REM Local System
copy C:\path_to_directory\testapp01\output\test.txt \\washdc.test.lab\rm15fs01\crms\
```