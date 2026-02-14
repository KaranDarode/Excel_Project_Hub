# 📊 City-Wise Sales Executive Analysis — Excel Analytics Project  

## 📌 Executive Summary  

The **City-Wise Sales Executive Analysis** is a business-focused Excel dashboard developed to transform raw employee-level sales data into meaningful performance insights.

This dashboard provides a **city-wise and sales executive-level performance overview**, enabling management to evaluate daily productivity (Day 1 to Day 5), total sales performance, and target achievement through an interactive, slicer-enabled reporting interface.

By leveraging **Pivot Tables, Pivot Charts, and Slicers**, the solution enables dynamic filtering, structured comparison, and performance-driven analysis aligned with Data Analyst and Business Intelligence standards.

---

## 🖼️ Dashboard Preview  

<img src="Sales_Performance_Dashboard.png" alt="City-Wise Sales Executive Analysis Dashboard" width="100%"/>

---

## 🎯 Business Objectives  

- Monitor **city-wise sales performance**
- Track **sales executive performance (Day 1 to Day 5)**
- Identify **Top 5 and Bottom 5 performing executives**
- Analyze **Target Hit % and Away From Target %**
- Enable **dynamic city-level filtering using slicers**

---

## 📊 Pivot Table Data Overview  

<img src="Pivot_Table_Data.png" alt="City-Wise Sales Executive Pivot Data" width="100%"/>

The Pivot Table structure summarizes:

- City-wise Total Sales  
- Executive-wise performance  
- Target allocation  
- Target Hit Percentage  
- Away From Target Percentage  

It aggregates Day 1 to Day 5 sales data into a structured analytical model for dynamic reporting and comparison.

---

## 🖥️ Dashboard Insights  

The interactive dashboard visualizes:
<details><strong>
  <img src="Pivot_Table_Data.png" alt="City-Wise Sales Executive Pivot Data" width="100%"/>
</strong></details>


- City-wise sales comparison  
- Executive-level daily sales tracking  
- Top 5 Sales Executives  
- Bottom 5 Sales Executives  
- Target achievement percentage  
- Remaining target gap percentage  

Slicers allow dynamic filtering by city, enabling focused and comparative performance evaluation.

---
## 🖥️ VBR Micro

VBA scripts are used in this project to automate calculations and formatting across Dashboard Tables 1, 2, 3, and 4, enabling faster performance tracking and highlighting key metrics.

```vba
Sub SlicerConnector()
'
' SlicerConnector Macro
'

 If Sheet1.Range("A3").Value = True Then
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.AddPivotTable ( _
        ActiveSheet.PivotTables("PivotTable1"))
 Else
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.RemovePivotTable ( _
        ActiveSheet.PivotTables("PivotTable1"))
 End If
 If Sheet1.Range("D3").Value = True Then
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.AddPivotTable ( _
        ActiveSheet.PivotTables("PivotTable2"))
 Else
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.RemovePivotTable ( _
        ActiveSheet.PivotTables("PivotTable2"))
 End If
 If Sheet1.Range("H3").Value = True Then
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.AddPivotTable ( _
        ActiveSheet.PivotTables("PivotTable3"))
 Else
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.RemovePivotTable ( _
        ActiveSheet.PivotTables("PivotTable3"))
 End If
 If Sheet1.Range("J3").Value = True Then
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.AddPivotTable ( _
        ActiveSheet.PivotTables("PivotTable4"))
 Else
    ActiveWorkbook.SlicerCaches("Slicer_Region").PivotTables.RemovePivotTable ( _
        ActiveSheet.PivotTables("PivotTable4"))
 End If
    
End Sub

```
## 🛠 Tools & Techniques  

- Microsoft Excel  
- Pivot Tables  
- Pivot Charts  
- Slicers  
- Conditional Formatting  
- Data Cleaning & Structuring  
- Performance Reporting  
---
## 🚀 Conclusion  

The **City-Wise Sales Executive Analysis** dashboard delivers a structured and interactive reporting solution for evaluating city-level and executive-level sales performance.

This project demonstrates strong Excel dashboarding skills, analytical thinking, and business-oriented reporting capabilities suitable for Data Analyst, MIS Executive, and Business Intelligence roles.




