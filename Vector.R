
#17. Vector Basics

temps <- c(72,71,68,73,69,75,76)
temps
days <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')
names(temps) <- days
temps
is.vector(temps)
temps[1]
temps['Mon']

#18. Vector Operation

v1 <- c(1,2,3)
v2 <- c(5,6,7)
v1 + v2
v2-v1
v1 * v2
v1/v2

sum.of.vec <- sum(v1)
sum.of.vec
mean(v1)
sd(v1)
max(v1)
min(v1)
prod(v1)
prod(v2)


#19.Comparison Operators

5 > 6
5 < 6
5 <= 5
5 >= 5
2 == 3
2 != 3

v <- 1
v < -1
my.var <- 2
my.var < -10
# When you compare a vector including several elements with a number
# it will do elements by elements comparison
v <- c(1,2,3,4,5)
v < 2
v == 3
v2 <- c(10,20,30,40,50)
v < v2

#20. Vector Indexing and Slicing
v1 <- c(100,200,300)
v2 <- c('a', 'b', 'c')
v1[2]
v2[3]
v1
v2
#slice by indices
v1[2:3]
#slice by vector
v1[c(1,2)]
#naming a vector
v <- c(1,2,3,4)
names(v) <- c('a', 'b', 'c', 'd')
v['b']
v[c('c', 'd')]
v[v>2]
v>2
# use the comaprasion outcome as an index
my.filter <- v>2
my.filter
v[my.filter]
#Getting help with R
help('vector')
?vector
??numeric



