# Contributing to E-Commerce SQL Analysis

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

---

## 📋 Table of Contents
- [Ways to Contribute](#ways-to-contribute)
- [Getting Started](#getting-started)
- [Submission Guidelines](#submission-guidelines)
- [SQL Query Standards](#sql-query-standards)
- [Review Process](#review-process)

---

## 🎯 Ways to Contribute

### 1. Report Bugs 🐛
- Check existing issues first
- Provide clear description
- Include steps to reproduce
- Specify MySQL version

### 2. Suggest Improvements 💡
- Ideas for new queries
- Documentation enhancements
- Code optimization

### 3. Add New Queries 📝
- Additional analytical queries
- Different use cases
- Advanced SQL techniques

### 4. Improve Documentation 📚
- Fix typos and clarity
- Add examples
- Translate content

---

## 🚀 Getting Started

### Step 1: Fork Repository
```bash
git clone https://github.com/YOUR_USERNAME/ECommerce-SQL-Analysis.git
cd ECommerce-SQL-Analysis
```

### Step 2: Create Feature Branch
```bash
git checkout -b feature/your-feature-name
```

### Step 3: Make Changes
```bash
git add .
git commit -m "feat: Add your descriptive message"
```

### Step 4: Push & Create PR
```bash
git push origin feature/your-feature-name
```

---

## 📝 SQL Query Standards

### Formatting
```sql
-- ✓ Good: Clear and readable
SELECT c.customer_name,
       c.city,
       SUM(o.total_amount) as total_spent
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC;
```

### Comments
```sql
# Q21 Query Title
# Purpose: What this query does
# Concepts: Main SQL concepts used
# Difficulty: Advanced
```

### Naming Conventions
- Use snake_case for aliases
- Use UPPERCASE for SQL keywords
- Use meaningful column aliases
- Prefix tables with abbreviations

---

## ✅ Query Contribution Checklist

- [ ] Query solves a real business problem
- [ ] SQL is syntactically correct and tested
- [ ] Clear comments explain the query
- [ ] Documentation added to QUERY_GUIDE.md
- [ ] Example output provided
- [ ] Follows SQL standards
- [ ] No breaking changes

---

## 📮 Pull Request Guidelines

**Title Format:**
```
feature: Add customer churn query
fix: Correct JOIN syntax
docs: Improve README
```

**Description Template:**
```markdown
## Description
Brief explanation of changes

## Related Issue
Closes #123

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation

## Testing Done
Describe testing process

## Checklist
- [ ] Code follows standards
- [ ] Comments added
- [ ] Documentation updated
- [ ] No breaking changes
```

---

## 🙏 Thank You!

Your contributions help everyone learn SQL better. We appreciate:
- ⭐ Starring the repository
- 💬 Feedback and suggestions
- 🤝 Code contributions
- 📝 Documentation improvements

---

**Happy Contributing! 🚀**

*Last Updated: 2026-05-25*
