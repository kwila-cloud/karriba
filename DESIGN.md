# Design Document: Karriba

## Summary

This document outlines the design specifications for Karriba, a software system that enables drone pesticide operators to efficiently record and manage pesticide applications and flight records. 

The system will
- Streamline the process of gathering regulatory data points
- Generate standardized PDF reports
- Operate with minimal internet connectivity in accordance with local-first principles

## General Technical Design Principals

- Use standard data formats and protocols as much as possible.
   - Only use custom formats and protocols where there is a very well-defined reason why we should.
- Avoid unnecessary dependencies.
   - Any dependencies we do rely on should be well-maintained and have minimal dependencies themselves.
- Prefer simplicity to configurability.
   - The more configuration options we have, the more combinations we will have to test and maintain. 

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
- Customer information
   - Name
   - Address
- Was the customer informed of Restricted-Entry Interval (REI) requirements? (yes/no)
   - This should be entered for each new Record, not just a one time thing for each Customer
- Treatment details
   - Crop treated
   - Field name
   - Field coordinates (GPS)
   - Total treated area (acres)
   - Price per Acre
   - Dilution applied (gallons)
      - The dilution is the water plus the pesticide 
- Pesticide details (multiple pesticides per record)
   - Name
   - EPA registration number
   - Amount applied (ounces)
      - Allow the user to input an amount per acre, but store the total
- Environmental conditions
   - Wind speed before application
   - Wind speed after application
   - Wind direction
   - Temperature
- Notes

The following information should be stored separately, so that it can be cross-referenced in the pesticide records without repeated manual input:
- Applicator information
- Customer information

In the future, the system may collect some of these details automatically, without requiring manual input from the user.

#### References
Here are some documents that cover the requirements for pesticide applicators:
- https://agri.idaho.gov/wp-content/uploads/ISDAGuidance/Pesticide-Recordkeeping.pdf

#### Examples

Here are a few examples of prototype data collection interfaces:
- https://www.jotform.com/app/250376626588166
- https://malachi.tadabase.io/Pesticide-Application-And-Job-Scheduling-Copy/pesticide-records

### Report Generation

The system must:
- Generate a PDF report for a Pesticide Record Form when requested by the user

In the future, the system may:
- Allow customization of report headers/footers
- Support batch export of multiple reports

### Data Management

The application must:
- Store all records locally using SQLite
- Include full data import and export functionality

In the future, the system may:
- Allow the user to sync records between different devices
- Allow the user to share records with other users through fine-grained access controls

## Technical Architecture

### Technology Stack


1. **Mobile Frontend**
   - Flutter for cross-platform support
2. **Database**
   - SQLite for local storage on mobile devices
3. **Sync Service**
   - Python
   - FastAPI for RESTful API endpoints
   - PyPDF for PDF generation and manipulation

## Implementation Phases

### Phase 1: Core Functionality (MVP)

This phase should be complete by April 1st, 2025. This allows us to put something basic on the market for the 2025 season.

The bare minimum requirements for the MVP are:

- Flutter application with basic UI components
- Local SQLite data storage with stable import/export capabilities
- Just-in-time PDF generation on the mobile device
- GitHub releases of APK

### Phase 2: Enhanced Features (1.0)

Once we get feedback from the initial MVP, we will iterate to improve the feature set.
This phase should be complete by April 1st, 2026. This should allow us to access a larger market for the 2026 season.

Our 1.0 release will include:

- Improved UI/UX with refined workflows
- Initial cloud synchronization capabilities
- Advanced PDF generation in the cloud via PyPDF
- Send PDFs by email through the cloud service
- App published to major app stores

### Future Ideas

- Integration with weather APIs for automatically pulling in weather data
- Access control - allow users to share read-only reports

