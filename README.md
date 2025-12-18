# Gender and Income Effects on Secondary Education Enrollment (1999–2005)

## Glit Hanpanitkitkan

## 🚀 Live App & How to Run

**Live Shiny App:**  

👉 https://glithan.shinyapps.io/ShinyWebapp/

**Run Locally:**

1. Clone the repository:
   ```bash
   git clone https://github.com/glithan/STAT_451_Final_Project.git
   
2. Install required packages (if not already installed):
```
    install.packages(c(
    "shiny", "dplyr", "ggplot2", "plotly", "tidyr", "readr",
    "countrycode", "DT", "viridis", "RCurl", "tidyverse", "fastmap", "htmltools",
     "scales"
    ))
```

3. Run the app:
    Open app.R and click "Run App" in RStudio.


## 📊 Project Overview:

**Research Question:** How does a country’s income (GDP per capita in USD) affect male and female secondary-school enrollment, and how do these patterns differ across world regions from 1999 to 2005?

**Motivation:**\
Educational gender inequality remains a global issue, especially in lower-income regions. By integrating data on income, gender, and education, this project examines how economic development influences access to secondary education.

## 🧠 Data Sources

| Dataset                          | Source                                                                                                                 | Key Features                                                |
|----------------------|--------------------|-------------------------------|
| GDP per Capita                   | [World Bank](https://data.worldbank.org/indicator/NY.GDP.PCAP.CD)                                                      | Annual GDP per capita (USD) by country                      |
| Secondary Enrollment (by Gender) | [UN Data GenderStats](https://data.un.org/Data.aspx?d=GenderStat&f=inID%3a64)                                          | Enrollment counts for males and females by year and country |
| Population Data                  | [U.S. Census International Database](https://www.census.gov/data-tools/demo/idb/#/table)                               | Population and sex ratio by country and year                |
| Country Mapping                  | [Kaggle: Country Mapping Dataset](https://www.kaggle.com/datasets/andradaolteanu/country-mapping-iso-continent-region) | ISO codes, regions, and continents                          |

All datasets were filtered to **1999–2005** and merged by country to align GDP, enrollment, and demographic data.

## 📈 Visualizations

### 1) Average GDP per Capita by Region

A line chart illustrating GDP trends across regions.
- **North America** leads in GDP per capita.
- All regions show consistent economic growth between 1999–2005.

### 2) Growth in Secondary Enrollment by Region

Line chart showing percentage growth in enrollment.
- **Sub-Saharan Africa** exhibits the highest growth (\~50%) despite the lowest GDP.
- **Europe & Central Asia** shows slight decline; **North America** remains steady.

### 3) Enrollment by Income Level and Gender

Bar + line chart comparing gender and income categories.
- Males generally have higher enrollment than females.
- After 2003, **low-income males surpass high-income males**, while **high-income females maintain higher rates** than low-income females.

## 💡 Key Insights
- Higher GDP correlates with higher enrollment, but **not uniformly across genders**.  
- Economic growth alone doesn’t ensure **educational gender parity**.  
- Some low-income regions show **faster progress in enrollment growth**, narrowing the gap.

## 🧰 Tools & Techniques
- **Languages:** R (Dplyr, ggplot2, plotly, tidyr, shiny)  
- **Techniques:** Data cleaning, merging multi-source datasets, time-series visualization, and regional aggregation  

