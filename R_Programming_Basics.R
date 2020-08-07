#Section 46
#Logical Operator
#& #And
#| #OR
#! #NOT
  
x <- 10
x <20 & x > 5
x > 5 & x < 20
#All need to be True to return True for &
(x < 20) & (x > 5) & (x == 10)
#As long as one returns True, it will return True
(x==10) | (x==100)
(10 == 1)
!(10 == 1)
!!(10 == 1)

subset(mtcars, mpg > 20)
mtcars[(mtcars$mpg >20) & (mtcars$hp > 100),]
mtcars[(mtcars$mpg >20) | (mtcars$hp > 100),]


#Section 47 if else, else if
x <- 13
if (x==10) {
  print('x is equal to 10!')
}else if(x == 12){
  print('x equal to 12')
}else{
  print('x was not equal to 10 or 12')
}

hot <- FALSE
temp <-100

if(temp > 80){
  print('Tmep is greater than 80!')
}


if(temp > 80){
  hot <- TRUE
}

print(hot)
#while loop
var <- 25
cat('My number is:',var)
print(paste0("Variable is: ", var))

#for loop
li <- list(1,2,3,4,5)
for (temp_var in li){
  print(temp_var)
}

for (i in 1:length(li)){
  print(li[[i]]) # Remember to use double brackets!
}

li[[5]]

#fUNCTION

helloyou <- function(name){
  print(paste('hello',name))
}
helloyou('Sammy')


#Exercise 1

prod<- function(a,b){
  product = a*b
  return(product) 
}

prod(3,4)

#Exercise 2


num_check <- function(num,vector){
  if (num %in% vector){
    return (TRUE)
  }
  else {
    return (FALSE)
  }
}
num_check(2, c(1,2,3))
num_check(2, c(1,4,5))

#Exercise 3

num_count <- function(num, vector){
  count = 0
  for (i in vector){
    if (i == num){
    count=count+1 
    }
  }
  return(count)
}
num_count(2,c(1,1,2,2,3,3))
num_count(1,c(1,1,2,2,3,1,4,5,5,2,2,1,3))

#Exercise 4
bar_count <- function(num){
  a = round(num/5)
  b = num %% 5
  return(a+b)
}
bar_count(6)

bar_count(17)

#Exercise 5
summer <- function(a,b,c){
  x = 0
  for (i in c(a,b,c)){
    if (i %% 3 == 0){
      i = 0
    }
    x = x + i
  
  }
  return(x)
}
summer(7,2,3)
summer(3,6,9)
summer(9,11,12)

#method 2
summer <- function(a, b, c){
  out <- c(0)
  if (a %% 3 != 0){
    out <- append(a,out)
  }
  if (b %% 3 != 0){
    out <- append(b,out)
  }
  if (c %% 3 != 0){
    out <- append(c,out)
  }
  return(sum(out))       
}

#Exercise 6
#'%/%' is the floor divison

prime_check <- function(pn){
  
  if(sum(pn/1:pn==pn%/%1:pn)==2)
    print("prime")
  
}

sum(2/(1:2) == 2%/%(1:2)) ==2

2/1:2 
2%/%1:2

6/1:6
6%/%1:6

5%/%1:5
5/1:5
prime_check(2)
prime_check(5)
prime_check(4)
prime_check(237)
prime_check(131)

6/1:6
6%%1:6
(2/1:2 == 2%%1:2)


