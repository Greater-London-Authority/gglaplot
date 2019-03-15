#' @title AvAtt
#' @description Average Attainment 8 Scores - 2016/17. Average score per pupil in each element
#' @format A data frame with 8 rows and 3 variables:
#' \describe{
#'   \item{\code{Region}}{integer factor column, London or England}
#'   \item{\code{Subject}}{integer factor column of subject element}
#'   \item{\code{Score}}{double Attainment 8 Score} 
#'}
#' @source \url{https://data.london.gov.uk/economic-fairness/equal-opportunities/ks4-achievement/}
"AvAtt"


#' @title EU Referendum Results
#' @description Results from the 23rd June 2016 referendum on membership of the 
#' European Union for each local authority in London
#' @format A data frame with 33 rows and 7 variables:
#' \describe{
#'   \item{\code{Area_Code}}{integer GSS borough code}
#'   \item{\code{Area}}{integer Borugh name}
#'   \item{\code{Leave}}{integer Leave vote}
#'   \item{\code{Remain}}{integer Remain vote}
#'   \item{\code{PropLeave}}{double Leave vote as a proportion}
#'   \item{\code{CatLeave}}{integer Leave vote proportion split into categories}
#'   \item{\code{geometry}}{list geometry of Borough}  
#'}
#' @source \url{https://data.london.gov.uk/dataset/eu-referendum-results}
#' @source \url{https://data.london.gov.uk/dataset/statistical-gis-boundary-files-london}
#' @details Contains Ordnance Survey data © Crown copyright and database right [2015]
"EURef"

#' @title Achievement in EYFSP by Ethnicity
#' @description Percentage achieving at least the expected standard in Equal Opportunities
#' School Readiness Early Years Foundation Stage tests in all ELGs (2017)
#' @format A data frame with 12 rows and 3 variables:
#' \describe{
#'   \item{\code{Ethnicity}}{integer ethinicity of pupils}
#'   \item{\code{Region}}{integer London or England}
#'   \item{\code{eyfsp}}{integer percentage achieving the expected standard} 
#'}
#' @source \url{https://data.london.gov.uk/economic-fairness/equal-opportunities/school-readiness/}
"EYFSP"

#' @title Gender Pay Gap
#' @description Gender Pay Gap - Total (Median) - London VS UK
#' @format A data frame with 42 rows and 3 variables:
#' \describe{
#'   \item{\code{Year}}{double year of data}
#'   \item{\code{location}}{integer London vs UK}
#'   \item{\code{GPG}}{double Gender pay gap (percentage)} 
#'}
#' @source \url{https://data.london.gov.uk/economic-fairness/labour-market/gender-pay-gap/}
"LDNUK"

#' @title Internet users in London
#' @description Survery of internet use in the last 3 months
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{\code{locat}}{character London}
#'   \item{\code{usage}}{integer usage level, used/not used in the last 3 months}
#'   \item{\code{numUsers}}{double number of users} 
#'}
#' @source \url{https://www.ons.gov.uk/businessindustryandtrade/itandinternetindustry/datasets/internetusers}
"Internet"

#' @title mm_to_pt
#' @description Factor converting mm to pt
#' @format double
#' @details Various ggplot sizes are set using mms, this factor will adjust this to use pts instead.
"mm_to_pt"

#' @title gla_light
#' @description list of colours used in the gla_light theme
#' @format named list
#' @details list of hex codes of colours used for data and non-data elements of the gla_light theme
"gla_light"

#' @title gla_dark
#' @description list of colours used in the gla_dark theme
#' @format named list
#' @details list of hex codes of colours used for data and non-data elements of the gla_dark theme
"gla_dark"