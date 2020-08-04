#Section 8

#25 Creating a Matrix(two dimensional data structure consisting of the same data type)

1:10
v <- 1:10
matrix(v, nrow=2)
matrix(1:12, byrow = FALSE, nrow=4)
matrix(1:12, byrow = T, nrow=4)
goog <- c(450, 451,452,445,468)
msft <- c(230,231,232,233,220)
stocks <- c(goog, msft)
stocks
stock.matrix <- matrix(stocks, byrow=T, nrow=2)
stock.matrix

days <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri')
st.names <- c('GOOG', 'MSFT')
colnames(stock.matrix) <- days
rownames(stock.matrix) <- st.names
# matrix is different at subsetting compared with dataframes
# matrix only returns elements but dataframes return the column in default
stock.matrix[1]
names(stock.matrix)
colnames(stock.matrix)
#names work for vectors and dataframe, colnames work for matrices and dataframes
#names and colnames are same with dataframes


#Section 26 Matrix Arithmetic

mat <- matrix(1:25, byrow=T, nrow=5)
mat * 2
mat / 2
1 / mat
mat > 15
mat[mat > 15]
mat + mat
# matrix calculation
mat %*% mat


#Section 27 Matrix Operation
stock.matrix
colSums(stock.matrix)
rowSums(stock.matrix)
rowMeans(stock.matrix)
#Adding a new row to the dataframe
FB <- c(111,112,113,120,145)
tech.stocks <- rbind(stock.matrix, FB)

#Adding a new column
avg <- rowMeans(tech.stocks)
avg
tech.stocks <- cbind(tech.stocks, avg)






#Section 28 Matrix Selection and Indexing
mat <- matrix(1:50, byrow=T, nrow=5)
mat[1,]
mat[,1]
mat[1:2, 1:3]
mat[2:3,5:6]



#Section 29 Factor and Categorical Matrices

animal <- c('d', 'c','d','c','c')
id <- c(1,2,3,4,5)
factor(animal)
# nominal no order
fact.ani <- factor(animal)
fact.ani

#ordinal order
temp <- c('cold', 'med', 'hot', 'hot', 'hot', 'cold', 'med')
fact.temp <- factor(temp, ordered = T, levels = c('cold','med','hot'))
fact.temp
# it will change the summary return value. it will return the counting of each level
summary(fact.temp)
#in only return the summary information 
summary(temp)


#Section 30 Matrix Exercises

#1.
A <- c(1,2,3)
B <- c(4,5,6)
mat.A.B <- rbind(A,B)
mat.A.B
#2.
mat.1.9 <- matrix(1:9,byrow=T,nrow=3)
mat.1.9
#3.
is.matrix(mat.1.9)
#array, two or more dimensions 
is.array(mat)
is.data.frame(mat)
#4.
mat2 <- matrix(1:25, byrow=T, nrow=5)
#5.
mat2[2:3,2:3]
#6.
mat2[4:5,4:5]
#7.
sum(mat2)
#8.
?runif()
v <- runif(20,0,100)
random <- matrix(v,byrow=T,4)
random


