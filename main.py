import streamlit as st
import psycopg2

# Replace these values with your actual database credentials
host = '02f7e6f1-1adb-4347-835a-02c74fcccb0e.db.cloud.postgresml.org'
port = '6432'
database =  'pgml_dwerbshrfzjc0ep'
user = 'u_jqmf1nl2wtfaa6k'
password = 'bhb1nt3iyoebjpa'


# Establish a connection
conn = psycopg2.connect(
    host=host,
    port=port,
    database=database,
    user=user,
    password=password
)

# Create a cursor
cursor = conn.cursor()
# Streamlit app
st.title("Pest Prediction App")

# Input fields for user interaction
crop_type = st.selectbox("Crop Type", ["Select","Kharif", "Rabi"])
if crop_type == "Kharif":
    crop_type = float(0)
elif crop_type == "Rabi":
    crop_type = float(1)

soil_type = st.selectbox("Soil Type", ["Select","Alluvial","Black-Cotton"])
if soil_type == "Alluvial":
    soil_type = float(0)
elif soil_type == "Black-Cotton":
    soil_type = float(1)

pesticide_use_category = st.selectbox("Pesticide Use Category", ["Select","Insecticides","Herbicides","Bactericides",])
if pesticide_use_category == "Insecticides":
    pesticide_use_category = float(0)
elif pesticide_use_category == "Herbicides":
    pesticide_use_category = float(0.5)
elif pesticide_use_category == "Bactericides":
    pesticide_use_category = float(1)

season = st.selectbox("Season",["Select","Summer","Monsoon","Winter"])
if season == "Summer":
    season = float(0)
elif season == "Monsoon":
    season = float(0.5)
elif season == "Winter":
    season = float(1)

estimated_insects_count = st.number_input("Estimated Insects Count",step=1)
estimated_insects_count = (estimated_insects_count - 150)/(3947)
number_doses_week = st.number_input("Number Doses Week",step=1)
number_doses_week = (number_doses_week)/95
number_weeks_used = st.number_input("Number Weeks Used",step=1)
number_weeks_used = (number_weeks_used)/67
number_weeks_quit = st.number_input("Number Weeks Quit",step=1)
number_weeks_quit = (number_weeks_quit)/50

# Button to trigger prediction
if st.button("Predict"):
    # Make prediction using the loaded model
    # Example: Execute a query
    cursor.execute(
        f"SELECT pgml.predict('crop damage recommendations'::text,ARRAY[{estimated_insects_count}, {number_doses_week}, {number_weeks_quit}, {number_weeks_used}, {crop_type}, {soil_type}, {season}, {pesticide_use_category}]::FLOAT[])")
    rows = cursor.fetchall()
    ans = rows
    print(ans)
    for row in ans:
        for i in row:
            i = int(i)
            if i == 0:
                st.write("Predicted Pest Level:", "Minimal Damage")
            elif i == 1:
                st.write("Predicted Pest Level:", "Partial Damage")
            elif i == 2:
                st.write("Predicted Pest Level:", "Significant Damage")

if st.button("Quit",):
    st.markdown(""" <meta http-equiv="refresh" content="0; url='http://192.168.1.4:8501'" /> """, unsafe_allow_html=True)
