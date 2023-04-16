# software-engineer
A short case study to evaluate analytical skills

Background:
In Production Operations we use an Enterprise Scheduling Application called Control-M to perform automated tasks, run batch jobs and execute commands on servers. In the Control-M GUI you can view jobs and their associated properties such as the Host (or server) the job runs on, File Name (or command/script to run), the File Path, along with the job status. Jobs are represented by small rectangles and can be grouped under a “Parent Folder”. If a job is colored Grey it has not executed. If a job is colored Yellow it is currently executing. If a job is colored Green it has completed. If a job is colored Red it has failed. Jobs can also have predecessors and successors. In order for a successor to run, its predecessor must have completed successfully (bearing in mind that the “success” of a job is determined by the underlying script’s logic). Jobs’ underlying scripts can be updated to fix bugs and jobs may also be stopped or rerun as needed if issues arise.

Note: This is meant to reflect a “real world” scenario but has been simplified for case study purposes. Accounts and passwords are not real, and scripts and logs have been adapted for this purpose. Timestamps may not match a real job runtime and should not affect analysis.

Exercise 1:
Open the document titled CONTROLM.md and analyze each jobs status. Files associated with each job can be found in the folders. For instance, you can view the output logs of some jobs in the folder \testdb01\log. 
Identify and document any issues you find in your analysis and explain how you would resolve the issues to allow the job stream to complete successfully. 
Document any suggestions you have for improving the jobs and scripts. 

Exercise 2:
Scenario: Rick works out of Washington, DC and is on the washdc.test.lab domain. Morty works out of Charleston, SC and is on the chs.test.lab domain. Rick needs an important file copied from a Charleston server to his shared folder after hours, so Morty uses a control-m job to schedule the copy. The share location has been verified to exist via a screenshot taken by Rick, and the account used to access the location was verified by security personnel to have the correct permissions.
Open the document titled Copy_to_share.md and analyze the failed job. What might the issue be?
