import streamlit as st
import pandas as pd
import numpy as np

"""
# Uber pickups Exercise
"""

DATA_URL = 'https://s3-us-west-2.amazonaws.com/streamlit-demo-data/uber-raw-data-sep14.csv.gz'

@st.cache(allow_output_mutation=True)
def dowloand_data():
  return pd.read_csv(DATA_URL)

nrow = st.sidebar.slider('No. rows to display',0, 100000, value=1000)
hour_range = st.sidebar.slider('select the hour',0,24,(8,17))
data = (dowloand_data()
        .rename(columns={'Date/Time':'date_time', 'Lat':'lat','Lon':'lon','Base':'base'})
        .assign(date_time = lambda df : pd.to_datetime(df.date_time))
        .loc[(lambda df: df.date_time.dt.hour >= hour_range[0]) & (df.date_time.dt.hour < hour_range[1])]
        .loc[1:nrow]
       )

data

st.map(data)

## todo ordenar por fecha
## agregar histograma por hora



