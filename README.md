# Food Preference Clustering
This repository contains a Shiny application that visualizes clustering patterns in food liking ratings from study participants. 

The app is accessible here: https://bewe.shinyapps.io/Clustering_map/

The app allows users to interactively explore clusters derived from food liking ratings and visualize how food items group together in preference space.

The 3D plot can be rotated and zoomed.

## Methods

Food preference data were analyzed using a two-step unsupervised learning pipeline:

**UMAP (Uniform Manifold Approximation and Projection)**

Used for dimensionality reduction to project high-dimensional food preference data into a low-dimensional representation.

**HDBSCAN (Hierarchical Density-Based Spatial Clustering of Applications with Noise)**

Applied to the UMAP embedding to detect clusters of similar food preference profiles without requiring a predefined number of clusters.


## Identified Food Preference Profiles

The clustering analysis revealed six preference profiles:

### Salty cravers: 
- Burger & Fries Lovers: High liking for classic fast food items such as burgers and fries.
- Pizza Lovers: Strong preference for pizza-based foods.
- Pasta Lovers: High liking for pasta dishes.

### Snackers:
- Serial Snackers: Preference for snack-type foods such as chips and soda.

 ### Sweet tooth cravers
- Light Sweet Tooth: Preference for moderately sweet foods such as bread and chocolate.
- Heavy Sweet Tooth: Strong preference for highly palatable desserts rich in sugar and fat.
