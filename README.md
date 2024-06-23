# Employee Absence Manager
Comprehensive tool made with ColdFusion for managing and tracking employee absences

- DB not included!
____________________
TODO List:

Features to Implement:
- File Download
- Implement file download functionality on the pedidos.cfm page.

User Management:
- Create a user management page with all functionalities described in the requirements.

Absence Policy Management:
- Create a management page for absence policies.
  
Balance Information:
- Display the number of available days an employee has.
- Show details when extracting absences for the year: how many days are deducted from the previous year, how many days have been accumulated, etc.
  
Bugs to Fix:
- Request Removal
- Modify logic to remove a request by setting its active attribute to false.
- Fix the logout button so it functions correctly and does not just redirect to index.cfm.
- Fix the calendar so that it marks the requests for the user with an active session.
- Fix the logic to display pending requests for the user on the agenda.cfm page.
- Fix the request (Agenda) to return to the main page after being processed.

Base:
- Implement a notification system for various actions and events.
- User Balance
- Implement a balance tracking on the agenda.cfm page if necessary.
