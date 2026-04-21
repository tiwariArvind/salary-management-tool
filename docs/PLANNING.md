# Planning Notes

## Goal
Build an Employee Management system with:
- CRUD APIs
- Salary insights
- Frontend UI (React)
- Basic test coverage

## Approach
- Backend: Ruby on Rails API
- Frontend: React (Vite)
- DB: PostgreSQL (or SQLite for dev)

## Key Features
- Employee CRUD
- Salary insights by country and job title
- Pagination and filtering
- Form validation on frontend

## Data Flow
Frontend (React) → API (Rails) → DB

## Trade-offs
- Used simple REST APIs instead of GraphQL (faster to implement)
- Used insert_all for seed (performance)
- Basic validation on frontend + backend

## Future Improvements
- Authentication
- Caching salary insights
- Better UI/UX