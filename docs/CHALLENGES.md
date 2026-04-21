# Challenges Faced

## 1. Frontend-Backend mismatch
- Missing fields like email, currency
- Fixed via migration + frontend update

## 2. Vite + JSX errors
- .js vs .jsx issue
- Fixed by renaming files

## 3. Testing setup issues
- Vitest not configured initially
- Fixed by adding vite.config.js

## 4. Import/export errors
- Missing exports in utils file
- Fixed using ES module syntax

## Learnings
- Importance of consistent file structure
- Proper separation of concerns
- Debugging build tools (Vite, ESLint)