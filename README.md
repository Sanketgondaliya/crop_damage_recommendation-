# crop_damage_recommendation-Using PostgreML

# Problem statement:-Farmers face significant challenges in accurately identifying and responding to crop pest damage. Traditional methods of pest detection can be time-consuming, subjective, and prone to human error. This often leads to delayed interventions, allowing pest populations to grow and inflict substantial yield losses. 

This project aims to address this challenge by developing a machine learning model for crop pest damage recommendation. This model will be built using PostgresML, enabling its deployment directly within a PostgreSQL database environment. The project will also utilize Streamlit to create a user-friendly web application for real-time pest damage prediction based on user input.

# Detailed Problem
To analyze the outcomes of the harvest season based on the given data, we can utilize a decision-making framework. Let's break down the process into steps:

1. Assessment of Pesticide Usage:
  Evaluate the amount and frequency of pesticides used by each farmer.
  Identify whether the pesticide usage falls within optimal levels or exceeds them.

2.Identification of Crop Condition:
  Determine the health status of the crop for each farmer.
  Classify the condition into three categories: healthy (alive), damaged by pesticides, or damaged by other reasons.

3.Analysis of Factors Contributing to Crop Health:
  Examine factors such as water availability, soil fertility, and pest control measures apart from pesticides.
  Determine if any other reasons, like environmental factors or diseases, have affected the crop health.
  
4.Decision Making:
  Based on the assessment, make decisions regarding the outcome of the harvest season for each farmer.
  Consider whether the crop is suitable for consumption or if it needs to be discarded due to pesticide damage or other 
  reasons.
  
5.Recommendations:
  Provide recommendations to farmers on optimizing pesticide usage to avoid crop damage.
  Suggest measures to improve overall crop health and harvest outcomes, including alternative pest control methods or soil 
  management practices.
  
By following this structured approach, we can effectively analyze the data and determine the outcome of the harvest season for each farmer, ensuring optimal crop health and productivity while minimizing pesticide-related damage.

# Algorithm used:- 
 -->Decision Tree Algorithm based on XGBoost(Extreme Gradient Boosting) framework which is used for ranking, 
    classification and other machine learning tasks.

# Data Description:-

COLUMN VAR | DETAILS
------------ | -------------
ID | UniqueID
Estimated_Insects_Count | Estimated insects count per square meter
Crop_Type | Category of Crop(0,1)
Soil_Type | Category of Soil (0,1)
Pesticide_Use_Category | Type of pesticides uses (0- Insecticides, 1-Herbicides, 2-Bactericides)
Number_Doses_Week | Number of doses per week
Number_Weeks_Used | Number of weeks used
Number_Weeks_Quit | Number of weeks quit
Season | Season Category (1,2,3)
Crop_Damage | Crop Damage Category (0=Minimal Damage, 1=Partial Damage, 2=Significant Damage)
