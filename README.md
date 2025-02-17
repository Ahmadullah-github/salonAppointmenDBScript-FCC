# Salon Appointment Scheduler

This project is a Bash script-based Salon Appointment Scheduler built as part of freeCodeCamp's Relational Database Certification. The script interacts with a PostgreSQL database to manage salon services, customers, and appointments.

---

## Features

- Display a list of available salon services.
- Manage customer records, ensuring unique phone numbers.
- Schedule appointments with specified services and times.
- Store and retrieve data using PostgreSQL.
- Implement foreign key relationships between customers, services, and appointments.

---

## Technologies Used

- Bash Scripting
- PostgreSQL
- Git & GitHub

---

## Files

- `salon.sh`: Main Bash script for the Salon Appointment Scheduler.
- `salon.sql`: PostgreSQL database dump to recreate the database structure and data.

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/salon-appointment-scheduler.git
   cd salon-appointment-scheduler
   ```
2. Rebuild the database:
   ```bash
   psql -U postgres < salon.sql
   ```
3. Make the script executable:
   ```bash
   chmod +x salon.sh
   ```
4. Run the script:
   ```bash
   ./salon.sh
   ```

---

## Acknowledgments

This project was completed as part of freeCodeCamp's Relational Database Certification, meeting all user stories and passing all tests successfully.

---

## Author

Ahmadullah Ahmadi

