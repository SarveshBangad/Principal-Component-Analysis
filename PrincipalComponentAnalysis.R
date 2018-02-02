#Principal Component Analysis

#----1. Using prcomp() from stats package------
#iris dataset: 
#four continuous variables which corresponds to physical measures of flowers and a categorical variable describing the flowers' species.
data(iris)
head(iris)

#Applying Log Transformations to 4 continuous variables to remove skewness effect on Principal Components
log.ir = log(iris[,1:4])
ir.species = iris[,5]

#Apply PCA:
#set center and scale. equal to TRUE in the call to prcomp to standardize the variables prior to the application of PCA
ir.pca = prcomp(log.ir, center = TRUE, scale. = TRUE)

#Since skewness and the magnitude of the variables influence the resulting PCs, it is good practice to apply skewness transformation, center and scale the variables prior to the application of PCA.


#Analyzing Result:
class(ir.pca) #prcomp object

#print() returns the standard deviation of each of the four PCs, and their rotation (or loadings), which are the coefficients of the linear combinations of the continuous variables.
#The loadings (or correlations) allow you to get a sense of the relationships between variables, as well as their associations with the extracted PCs.

print(ir.pca)

#plot() method:
#plot method returns a plot of the variances (y-axis) associated with the PCs (x-axis).
plot(ir.pca, type = "l")

#plot() useful to decide how many PCs to retain for further analysis. In this simple case with only 4 PCs this is not a hard task and we can see that the first two PCs explain most of the variability in the data

#summary():
summary(ir.pca)

#The summary method describe the importance of the PCs. The first row describe again the standard deviation associated with each PC. The second row shows the proportion of the variance in the data explained by each component while the third row describe the cumulative proportion of explained variance. We can see there that the first two PCs accounts for more than {95\%} of the variance of the data.

# sqrt of eigenvalues:
ir.pca$sdev

#We can use the predict function if we observe new data and want to predict their PCs values. Just for illustration pretend the last two rows of the iris data has just arrived and we want to see what is their PCs values:
# Predict PCs
predict(ir.pca,newdata=tail(log.ir, 2))

#-------2. PCA using caret Package--------------------
require(caret)
install.packages("e1071")
#it is possible to first apply a Box-Cox transformation to correct for skewness, center and scale each variable and then apply PCA in one call to the preProcess function of the caret package.
trans = preProcess(iris[,1:4], method=c("BoxCox", "center", "scale", "pca"))
PC = predict(trans, iris[,1:4])

#Retained PCs:
#By default, the function keeps only the PCs that are necessary to explain at least 95% of the variability in the data, but this can be changed through the argument thresh.
head(PC) #Two PC1 and PC2

#Loadings or COefficients:
trans$rotation


#---------3. 