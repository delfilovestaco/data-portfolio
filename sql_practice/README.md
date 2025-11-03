## Day 1 - SQL Basics

**📅 Date:** 03/11/2025
**🎯 Focus:** Basic SQL commands (SELECT, WHERE, ORDER BY, DISTINCT)

---

### 🧠 What I Learned

- How to retrieve specific columns using `SELECT`
- How to filter data using `WHERE`
- How to sort results using `ORDER BY`
- How to remove duplicates using `DISTINCT`
- How logical operators `AND` / `OR` affect conditions
- Practiced pattern matching with `LIKE`

---

### 🧩 Example Queries

```sql
SELECT CustomerName, City, Country
FROM Customers
WHERE Country = 'Spain' AND City = 'Barcelona' OR City = 'Sevilla';

SELECT COUNT(*) FROM Customers;
SELECT DISTINCT City FROM Customers;
```
