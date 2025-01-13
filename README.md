<p align="center">
  <img src="https://raw.githubusercontent.com/owl-lilith/Employees-Scoring/refs/heads/main/score.png" alt="System Overview" width="350">
</p>

**Note**: for more detailed information and full system understanding check the [presentation](Presentation.zip)

---

# Employee Evaluation System for Clothing Stores 

## Overview 
End-to-end AI point-based system that incorporates multiple machine learning models and technologies such as real-time employee management, including person detection, predictive analytics, AI-based facial recognition to facilitate the supervision, tracking, and evaluation of employees in clothing stores. The system aims to enrich the supervisory experience.

<p align="center">
  <img src="application_visualization_output\application.png" alt="System Overview" width="490">
</p>

## Project Goals
- **Enhance Employee Management**: Provide an easy-to-navigate interface for managers and supervisors to track and evaluate employees efficiently.
- **Increase Evaluation Efficiency**: Enable fair comparison between employees based on performance and productivity.
- **Improve Supervision**: Reduce the time supervisors spend reviewing large amounts of surveillance footage.
  
## Features
1. **Graphical Reports and Accurate Data**: Supervisors receive detailed analysis and reports on employee performance.
2. **Automated Attendance and Absence Checking**: The system tracks employee presence automatically.
3. **Employee Information Gathering**: Can be a reliable resource for managers to review
4. **Analytical Employee Performance**: The system tracks and displays employee contributions over days, weeks, and months.
5. **Point Allocation System**: Assigns points to employees based on predefined criteria and priorities.
  
## Why Choosing This Project
The idea was to explore the integration of AI technologies in the retail environment:
- To collect data and analyze it for actionable insights.
- To improve the supervisory experience by utilizing AI models to enhance employee evaluation processes.
- To introduce a new vision for supervision through real-time interaction between AI and store policies.

## Project Screen

<!-- ![input](application_visualization_output\add_employee_screen.png)  -->
- **Mobile**:
<p align="center">
  <img src="application_visualization_output\add_employee_screen_mobile.png" alt="System Overview 3" width="150">
  <img src="application_visualization_output\edit_services_screen.png" alt="System Overview 3" width="150">
  <img src="application_visualization_output\employee_basic_information_mobile.png" alt="System Overview 2" width="150">
  <img src="application_visualization_output\employee_activity_progress_overview_mobile.png" alt="System Overview 3" width="150">
  <img src="application_visualization_output\employee_activity_progress_overview_mobile_2.png" alt="System Overview 3" width="150">
  <img src="application_visualization_output\leaderboard_screen_mobile.png" alt="System Overview 1" width="150">
</p>

- **Desktop**:

<p align="center">
  <img src="application_visualization_output\home_page_screen.png" alt="System Overview 1" width="300">
  <img src="application_visualization_output\employee_overview_screen.png" alt="System Overview 3" width="300">
  <img src="application_visualization_output\leaderboard_screen.png" alt="System Overview 3" width="300">
  <img src="application_visualization_output\application_intro_screen.png" alt="System Overview 1" width="300">
  <img src="application_visualization_output\log_in.png" alt="System Overview 3" width="300">
  <img src="application_visualization_output\add_employee_screen.png" alt="System Overview 3" width="300">
  <img src="application_visualization_output\edit_services_screen_2.png" alt="System Overview 1" width="300">
  <img src="application_visualization_output\employee_information_screen.png" alt="System Overview 3" width="300">
  <img src="application_visualization_output\employee_innformation_screen_light_theme.png" alt="System Overview 1" width="300">
</p>

 **Note**: check full demo for both [mobile](application_visualization_output/application_overview_mobile.zip) and [desktop](application_visualization_output/application_overview_desktop.zip), also the [presentation](Presentation.zip) for each screen usage and check [screen folder](application_visualization_output) to fully visualize all screen
## Technical Implementation
- **AI Models**: 
  - **Yolo-v3** (darknet53) for person detection.
  - **SimeseFaceNet** (Haar model) for facial recognition.
- **Software Stack**:
  - **Backend**: Laravel framework.
  - **Frontend**: Flutter framework for visualizations.
  artificial_Intelligent-side
## System Insights
1. **Employee Monitoring**: Track employee entry times, disputes between employees, and customer interaction records.
2. **Employee Contribution**: Displays statistical charts showing each employee's contribution throughout the day, week, or month.
3. **Facial Recognition**: The system uses AI to detect employees and customers, assigning a unique ID for each.
4. **Negligence Detection**: Monitors employees for neglect, such as ignoring a customer for an extended period.
  
## System Enhancements
- **Reward and Penalty Suggestions**: Propose rewards or penalties for employees based on their performance and point accumulation.
- **Improvement Plans**: Suggest future actions for improving employee performance based on system data.

## Functional Requirements
- **Automated Attendance Tracking**: Logs employee entry and exit times.
- **Payment Record Logging**: Tracks customer transactions and associates them with the responsible employee.
- **Dispute Recording**: Records instances of employee disputes over customers.
- **Neglect Detection**: Identifies when an employee fails to assist a customer within a reasonable timeframe.
  
## System Requirements
- **Languages**: Developed using multiple programming languages suitable for AI, backend, and frontend development.
- **Storage Efficiency**: Efficiently manages storage by tracking employee data only for the necessary time periods.

---

**Note**: This project utilizes AI models such as Yolo-v3 and Haar for facial recognition and detection. It integrates with surveillance systems to streamline employee management and provide valuable insights for store supervisors.

<p align="center">
  <img src="software-side\assets\images\landing_screen_middle_vector_2.png" alt="System Overview" width="400">
</p>
