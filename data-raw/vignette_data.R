library(dplyr)
library(lubridate)
library(devtools)
library(tidyr)
library(sf)


# EU Referendum data ----
EURef <- read.csv('data-raw/EURef.csv')

EURef <- EURef %>%
  filter(Region == 'London') %>%
  select(Area_Code, Area, Leave, Remain) %>%
  mutate(PropLeave = (Leave / (Leave  + Remain)) * 100)
EURef['CatLeave'] = ''
for (i in seq(20,70, by = 10)) {
  j = i + 10
  EURef[EURef$PropLeave >= i & EURef$PropLeave < j,'CatLeave'] = 
    paste(i,'% - ',j,'%',sep = '')
}
EURef$CatLeave = factor(EURef$CatLeave, 
                     levels = c("20% - 30%", "30% - 40%", "40% - 50%",
                               "50% - 60%", "60% - 70%", "70% - 80%"),
                     ordered = TRUE)

Bor_data_loc <- 'https://data.london.gov.uk/download/
statistical-gis-boundary-files-london/9ba8c833-6370-4b11-abdc-314aa020d5e0/
statistical-gis-boundaries-london.zip'


temp <- tempfile()
download.file(Bor_data_loc, temp)
contents <- unzip(temp, list = TRUE)
shp_files <- grep('ESRI/London_Borough_Excluding_MHW.', contents$Name, 
                  value = TRUE)
Boroughs <- st_read(unzip(temp, shp_files))
unlink(temp)
unlink('statistical-gis-boundaries-london', recursive = TRUE)


Boroughs <- Boroughs %>%
  select(GSS_CODE, geometry)
EURef <- EURef %>%
  base::merge(Boroughs, by.x = 'Area_Code', by.y = 'GSS_CODE')

devtools::use_data(EURef,overwrite = TRUE)

# Gender pay gap data ----

LDNUK <- read.csv('data-raw/data-knZEv.csv')
# Make data tidy
LDNUK$Year <- as.character(LDNUK$Year) %>%
  paste(.,'01','01',sep = '-') %>%
  ymd()
LDNUK <- LDNUK %>%
  gather(location, GPG, London,UK) %>%
  select(-(Notes))

LDNUK$location <- LDNUK$location %>%
  factor(., levels = c('London', 'UK'), ordered = is.ordered(c('London','UK')))

devtools::use_data(LDNUK, overwrite = TRUE)

# Early years data ----

EYFSP <- read.csv('data-raw/data-iC8Ne.csv', as.is = TRUE)
EYFSP <- EYFSP %>%
  select(-(Notes)) %>%
  gather(Region, eyfsp, London, England)
EYFSP$Ethnicity <- EYFSP$Ethnicity %>%
  factor(., levels = rev(c("White", "Mixed",  "Asian",  "Black",
                           "Chinese", "All pupils")))
EYFSP$Region <-  EYFSP$Region %>%
  factor(., levels = c("London","England"),
         ordered = is.ordered(c("London","England")))

devtools::use_data(EYFSP, overwrite = TRUE)

# Average attainment data ----

AvAtt <- read.csv('data-raw/data-iZeVe.csv')

AvAtt <- AvAtt %>%
  gather(key = 'Subject', value = 'Score', -(Region)) 
AvAtt$Subject <- AvAtt$Subject %>%
  gsub('\\.',' ',.) %>%
  factor(., levels = c("English" , "Mathematics", "English Baccalaureate",
                       "Open"))

devtools::use_data(AvAtt, overwrite = TRUE)

# Internet usage data ----

Internet <- read.csv('data-raw/InternetUsage.csv', skip = 3, header = TRUE, 
                     stringsAsFactors = FALSE)
Internet <- Internet %>%
  filter(X == 'London') %>%
  select(X,starts_with('X2018')) %>%
  mutate_at(vars(contains('2018')), funs(gsub(',','',.))) %>%
  mutate_at(vars(contains('2018')), funs(as.numeric))


colnames(Internet) <- c('locat','Used3m','NotUsed3m','NeverUsed')

Internet <- Internet %>%
  mutate(NotUsed3m = NotUsed3m + NeverUsed) %>%
  select(-(NeverUsed)) %>%
  gather(usage, numUsers, Used3m, NotUsed3m)

Internet$usage <- Internet$usage %>%
  gsub('Used3m', 'Used in last 3 months', .) %>%
  gsub('NotU', 'Not u', .) %>%
  factor(levels = c('Used in last 3 months', 'Not used in last 3 months'),
         ordered = TRUE)

devtools::use_data(Internet, overwrite = TRUE)
