This program uses the Hexbin package to bin spatial data into hexgons.  
These hexagons are plotted.  And then the plot is sent to a pdf file.
The setwd() is hard coded. This will need to be changed to the user's 
relevant location.

Hexbin's default behaviour is to just use the X and Y coordinate and 
then count the number of observations that fall in the relevant hexagons.

This program uses the hexTapply function to determine the average of the Z
values that are contained in each hexagon.

Also, the default behaviour for the plotting function grid.hexagons() is to
scale the value to be plotted between 0 to 1.  This occurs within the function.

Therefore, to calculate colour break values, this scaling is replicated outside
the function.

Finally, the program was created using RStudio (MacOS) and there is line to canel
any existing plot.  This is hard coded for RStudio and will need to be modified for 
other platforms.
