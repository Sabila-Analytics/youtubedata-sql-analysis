**Overview**



* This project analyzes YouTube channel and video performance using MySQL.
* The goal is to clean a real-world, messy dataset and extract meaningful insights related to creator popularity, content performance across categories, and trends over time.
* The project focuses on data cleaning, data validation, and analytical querying using SQL window functions.



**Dataset**



**Data Source**: Public YouTube statistics dataset sourced from Kaggle.



The dataset contains YouTube statistics, including:

* Youtuber name
* Subscriber count
* Video views
* Video title
* Content category
* Country
* Upload year and month





The original dataset contains several data quality issues such as unreadable text characters and inconsistent values, which required cleaning before analysis.



**Data Cleaning \& Preparation**



**Text Cleaning**



Several text fields, particularly Youtuber names and video titles, contained corrupted or unreadable characters due to encoding issues. These issues could lead to incorrect grouping and inaccurate analysis.



To address this:

* Leading and trailing non-alphanumeric characters were removed.
* Text fields were standardized to improve readability and consistency



This step ensures creators and videos are correctly identified during analysis.



**Data Validation**



The dataset was also checked for invalid or inconsistent values.

For example:

* Subscriber growth fields containing non-numeric placeholders (such as 'nan') were identified

These checks help ensure that analytical results are based on valid and reliable data.



**Analysis \& Key Findings**



1\. Top 3 YouTubers in Each Country

To understand creator dominance across regions, YouTubers were ranked by subscriber count within each country.



Insight:

* Subscriber distribution is highly concentrated
* A small number of creators dominate each country’s YouTube landscape



2\. Most Watched Video in Each Category

The most viewed video within each content category was identified to evaluate category-level performance.



Insight:

* View potential varies significantly by category
* Certain content categories consistently attract higher audience engagement



3\. Most Watched Video Each Year

The most viewed video for each year was analyzed to observe trends over time.



Insight:

* Peak video views increase in more recent years
* This suggests growing platform reach and audience engagement over time



**Tools Used**



* MySQL
* MySQL Workbench



**Screenshots**

1.Before Cleaning

(screenshots/before\_cleaning.png)



2.After Cleaning

(screenshots/after\_cleaning.png)



3.Analysis Result 1

(screenshots/analysis\_result\_most\_watched.png)



2.Analysis Result 2

(screenshots/analysis\_result\_top3.png)



