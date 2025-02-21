# Design Document: Karriba

## Summary

This document outlines the design specifications for Karriba, a software system that enables drone pesticide operators to efficiently record and manage pesticide applications and flight records. 

The solution consists of a Flutter-based mobile frontend for Android tablets and a Python-based backend for data processing and PDF generation.

The system will
- Streamline the process of gathering regulatory data points
- Generate standardized PDF reports
- Operate with minimal internet connectivity in accordance with local-first principles

## User Personas

### Primary User: Drone Pesticide Operator
- Professional who applies pesticides using drone technology
- Requires accurate record-keeping for regulatory compliance
- Often works in remote locations with limited connectivity
- Needs to generate standardized documentation for clients and regulatory bodies

### Secondary User: Farm Owner/Advisor
- Requires documentation of pesticide applications
- Reviews and retains pesticide application records
- Needs to share records with regulatory agencies

## Functional Requirements

### Data Collection Interface

The application must collect the following data points as identified in the Pesticide Record Form:

- Applicator information
   - Name
   - License number
- Owner/Advisor information
   - Name
   - Address
   - Were they informed of REI requirements? (yes/no)
- Treatment details
   - Crop treated
   - Field name and coordinates (GPS)
   - Application rate
   - Total treated area
   - GPA (Gallons Per Acre)
- Pesticide details (up to 10 entrys)
   - Name
   - Registration number
- Environmental conditions
   - Wind velocity/direction before application
   - Wind velocity/direction after application
   - Temperature during application
- Notes

### Report Generation

The application must:
- Generate standardized PDF reports

In the future, the application may:
- Support batch export of multiple reports
- Allow customization of report headers/footers
- Include timestamp and electronic signature capabilities

### Data Management

The application must provide in Phase 1:
- Local storage of all application records using SQLite
- SQLite database import and export functionality
- Data export in multiple formats (PDF, CSV)

## Technical Architecture

### Technology Stack

The application will utilize a hybrid architecture:

1. **Mobile Frontend (Flutter)**
2. **Backend (Python)**
   - FastAPI for RESTful API endpoints
   - PyPDF for PDF generation and manipulation
3. **Database**
   - SQLite for local storage on mobile devices
   - PostgreSQL for cloud service backend (future phases)

### Component Interactions

#### Local-Only Mode
1. Flutter application collects and validates user input
2. Data stored directly in local SQLite database
3. For PDF generation, data is sent to Python backend when online, or processed locally when offline

#### Cloud-Synchronized Mode (Future Phases)
1. Flutter application synchronizes local SQLite data with cloud backend
2. Python backend processes data and generates PDFs using PyPDF
3. Reports and data accessible across multiple devices

### SQLite Management (Phase 1 Priority)

1. **SQLite Export**
   - Complete database export to .db file

2. **SQLite Import**
   - Validation of imported database schemas
   - Transaction-based import to prevent partial imports

## Data Synchronization and Management

### SQLite as Primary Data Store

- All records stored in SQLite database on device
- Full database schema to support all required fields
- Indexed fields for efficient searching and filtering
- Versioned schema to support future updates

### SQLite Import/Export Features (Phase 1)

- Complete database export with optional encryption
- Selective record export functionality
- Import validation and conflict resolution
- Backup scheduling capabilities

### Future Synchronization Architecture

- Bidirectional sync between local SQLite and cloud database
- Conflict resolution with version vectors
- Encrypted data transfer using industry-standard protocols
- Bandwidth-efficient delta synchronization

## Implementation Phases

### Phase 1: Core Functionality (MVP)
- Flutter application with basic UI components
- Local SQLite implementation with import/export capabilities
- Basic Python backend for PDF generation using PyPDF
- GitHub releases of APK

### Phase 2: Enhanced Features
- Improved UI/UX with refined workflows
- Advanced PDF customization via PyPDF
- Offline-first optimizations
- Initial cloud synchronization capabilities

### Phase 3: Premium Service
- Cloud hosting option with subscription model
- Enhanced synchronization features
- Priority support channels
- Integration with other farm management systems

## Security Considerations

- Local encryption of sensitive data
- Secure SQLite database operations
- End-to-end encryption for all synchronized data

