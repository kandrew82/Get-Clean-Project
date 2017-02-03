This codebook describes the steps performed by the script run_analysis.R

## Getting Data

The dataset contains the following text file:
- Training set (7.352 observations)
- Test set (2.947 observations)
- List of 561 features 
- Activity list
- Subjects of each observation

## Cleaning Data

Training set and test set are merged into a single data frame (10.299 observations), then the subject and activity information are added. to which are subsequently added.
The feature set is reduced through an appropriate subsetting and variable names are cleaned to make them more readable.
Finally, through the package *dplyr* the means of the feature selected are summarized and grouped by subject and activity.

## Output

The resulted dataframe will be written inside the working directory in the file *final.txt*
