# Architecture Decisions

## Backend
- Rails API-only app
- Service layer: SalaryInsightsService
- Controllers handle HTTP, services handle logic

## Why Service Object?
- Keeps controllers thin
- Reusable business logic
- Easier to test

## Database
- Indexed country & job_title for faster queries
- Used aggregate queries (MIN, MAX, AVG)

## Frontend
- React functional components
- Hooks for state management

## Separation of Concerns
- UI → components
- Logic → utils (validateForm, formToPayload)

## Testing Strategy
- Backend: RSpec (services + requests)
- Frontend: Vitest (utils + basic UI)