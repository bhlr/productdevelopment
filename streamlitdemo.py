# -*- coding: utf-8 -*-
"""streamlitdemo.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1nWb_nvUcIAe-Itthvx9iSyOEb0OJqWIe
"""
import streamlit as st
import numpy as np
import pandas as pd

st.title("this is my first app from")
x = 4
st.write(x,'square is',x**x)

st.write(pd.DataFrame({
    'column A' : ['A','B','C','D','E'],
    'Column B' : [1,2,3,4,5]
}))


"""
# Title : This is a Title tag
This is other example for dataframe
"""

df = pd.DataFrame({
    'column A' : ['A','B','C','D','E'],
    'Column B' : [1,2,3,4,5]
})

df

df_to_plot = pd.DataFrame(
    np.random.randn(20,3),columns=['Column A', 'Column B', 'Cokumn C']
)

st.line_chart(df_to_plot)


"""
## let's plot a map!
"""

df_lat_lon = pd.DataFrame(
    np.random.randn(1000, 2) / [50, 50] + [37.76, -122.4],
    columns=['lat', 'lon']
)

st.map(df_lat_lon)


if st.checkbox('show dataframe'):
  df_lat_lon

"""

##  Let's try some widgets

"""

