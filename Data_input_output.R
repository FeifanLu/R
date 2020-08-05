#41 CSV
write.csv(mtcars, file = 'my_examp.csv')
read.csv(file.choose)

#42. Excel
#load many sheets at one time
library(readxl)
df <- read_excel('MMA_860_2021S_Exam_Data_A.xlsx', sheet = 1)

entire.workbook <- lapply(excel_sheets('MMA_860_2021S_Exam_Data_A.xlsx'),read_excel, path = 'MMA_860_2021S_Exam_Data_A.xlsx')

entire.workbook
# write data into excel
install.packages('xlsx')
mtcars
library(xlsx)
write.xlsx(mtcars, "output_example.xlsx")

#43.sql with R
install.packages("RODBC")
library(RODBC)
#Connect the database
myconn <- odbcConnect("Database_Name", uid="Use_ID", pwd = 'password')
#Connect the Table
dat <- sqlFetch(mydconn, "Table_Name")
#Run query
querydat <- sqlQuery(myconn, "SELECT*FROM table")
#close connection
close(myconn)


#44 web scraping with R

