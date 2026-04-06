# -Dorm-Maintenance-Request-and-Tracking-System
                                                Project Description

This project is a dorm maintenance management system that allows users to report maintenance issues and track their status. The system includes authentication, role-based authorization, and two main business features: maintenance requests and assignment management. It follows a layered architecture and uses a REST API for communication between frontend and backend.

                   Team Members
           Full Name 	        ID
    •    Fenet Mengistu     UGR/7035/16
    •    Firdaus Kedir	    UGR/7473/16
    •    Hawi Jarso	        UGR/4431/16
    •    Lidiya Girma	 UGR/4475/16
    •    Melat  Lemma       UGR/2585/15

   Features  

 Authentication
- User signup
- User login
- User logout
- Delete account

Authorization
- Role-based access control (User / Admin)
- Restrict access to admin-only screens
- Users can manage only their own requests
- Admin can manage all requests

 Maintenance Requests (Business Feature 1)
- Create maintenance request
- View maintenance requests
- Update maintenance request
- Delete maintenance request
- Add request details (title, description, location, date)
- Track request status (Pending, In Progress, Completed)

Assignment & Task Management (Business Feature 2)
- Assign staff to maintenance requests
- View assigned tasks
- Update request status
- Manage staff assignments

Backend (REST API)

- Authentication endpoints
- Maintenance request endpoints (CRUD)
- Assignment and status endpoints

Data Management

- Store user data
- Store maintenance requests
- Store assignment records
- Local database usage

User Interface

- Login and signup screens
- User dashboard
- Maintenance request form
- Request list screen
- Admin dashboard
- Assignment management screen

Maintenance Feedback & Rating

- Users can submit feedback on completed maintenance requests
- Users can rate the maintenance service (e.g., 1 to 5 stars)
- Users can edit or update their feedback if needed
- Users can view feedback history for their previous requests
- Users can see average ratings for each maintenance request or service
- Admins can review all feedback and ratings
- Admins can respond to user feedback
