Postmortem: The Great 500 Error Catastrophe

Issue Summary

Duration: March 1, 2025, 14:00 UTC - March 1, 2025, 16:30 UTC (2 hours 30 minutes)
Impact:

90% of website users experienced HTTP 500 Internal Server Errors.

The main web application (a WordPress-powered blog) was completely inaccessible.

API requests for mobile apps failed, affecting ~30% of mobile users.
Root Cause:
A misconfigured Apache update removed a critical PHP module (libapache2-mod-php) required for WordPress to function.



---

Timeline

13:55 UTC - A routine Apache upgrade was initiated on production servers.

14:00 UTC - Monitoring alerts triggered: "High HTTP 500 errors detected."

14:05 UTC - DevOps engineer noticed increased customer complaints on Slack and Twitter.

14:10 UTC - Engineering team started investigating Apache logs (/var/log/apache2/error.log).

14:30 UTC - Initial assumption: A misconfigured .htaccess file was causing the issue (false lead).

14:45 UTC - Apache was restarted multiple times with no improvement.

15:00 UTC - The issue was escalated to the senior DevOps team.

15:15 UTC - Running strace on Apache revealed missing PHP dependencies.

15:30 UTC - Discovered that the Apache update removed libapache2-mod-php.

15:45 UTC - Reinstalled libapache2-mod-php and restarted Apache.

16:00 UTC - Services started recovering; API traffic returned to normal.

16:30 UTC - Full system recovery confirmed.



---

Root Cause and Resolution

Root Cause:
A routine system update removed libapache2-mod-php, a critical module required for Apache to process PHP files. Without this module, Apache couldn't execute WordPress PHP scripts, resulting in HTTP 500 errors across the site.

Resolution:

Reinstalled libapache2-mod-php using:

sudo apt-get install -y libapache2-mod-php

Restarted Apache:

sudo systemctl restart apache2

Verified the site was functioning correctly.



---

Corrective and Preventative Measures

What Can Be Improved?

Improve monitoring to detect missing critical packages.

Automate dependency validation after updates.

Prevent Apache from restarting if critical modules are missing.


To-Do List:

Patch Management: Ensure that package removals are logged and reviewed before applying updates.

Monitoring:

Add a Nagios check to monitor PHP module availability.

Configure a health check that verifies Apache-PHP connectivity.


Automation:

Implement a Puppet script to verify that libapache2-mod-php is installed after updates.

Add an automated rollback for failed updates.




---

Conclusion

While this incident caused major downtime, it reinforced the need for automated dependency checks and better monitoring. Moving forward, we will ensure that all updates undergo strict validation to prevent another catastrophe. Lessons learned—never blindly update Apache in production!

