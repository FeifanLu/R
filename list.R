#list allows you mix different types of elements
v <- c(1,2,3)
m <- matrix(1:10, nrow=2)
df <- mtcars
# dataframe [] returns dataframe, $give you the vector
class(df$mpg)
class(df['mpg'])
class(v)
class(m)
class(df)
class(m[1])
my.list <- list(v,m,df)
my.list
#name the elements in list
my.name.list <- list(sample_vec = v, my.matrix =m, sample.df =df)
my.name.list
#for list [] always return you a list, $ return the original type of the elements
my.name.list['sample.df']
class(my.name.list['sample.df'])
class(my.name.list$sample.df)
class(my.name.list$my.matrix)
#return the content of elements with the original type of the elements, similar with $
my.list[[1+2]]
class(my.list[[3]])
#return the first elements
my.list[1]
class(my.list)

#combine list

double.list <- c(my.name.list, my.list)
double.list
str(double.list)
