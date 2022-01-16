# Psychological-impact-of-lockdown
## Introduction
This project partially replicated the study of Brodeur et al. (2020), who tested whether the introduction of partial or full lockdowns produced an increase in 13 well-being related Google topic searches that served as a proxy for people’s mental health status. 
We used data referring to Italy, Germany and the UK, over a time period that goes from January 1st 2020 to March 22nd, 2020. The time frame is chosen to span from the beginning of the year to the moment in which Germany and the UK, which are the control groups, introduced some form of lockdown due to the Covid Pandemic. Italy, which implemented a full lockdown on March 9th 2020, is the treatment group.

## Data
Google Trends
To gauge the psychological impact of lockdown measures on people living in Italy, we operationalized those psychological effects by using Google Trends searches of words related to mental health issues and struggles.
Google Trends was launched in 2006 as a tool to analyze the popularity of search queries on Google across different regions and languages. It allows users to visualize and download an unfiltered sample of Google searches in the form of .csv datasets.
Trends data is normalized to the time and location of a query in a two-step process. Firstly the daily searches are divided by the maximum number of daily searches over the selected time period and location. Secondly this ratio is scaled on a range from zero to 100 based on a topic’s proportion to all searches on all topics.
Two types of queries can be submitted: search-terms and topic queries. The former retrieve searches matching the search-term, while the latter also include other search-terms related to the query.
In this research we focused on the same set of 13 topic queries used by Brodeur et al.: Boredom​, ​Contentment​, ​Divorce​, ​Impairment​, ​Irritability​, ​Loneliness​, ​Panic​, ​Sadness​, ​Sleep​, Stress​, ​Suicide​, ​Well-being,​ and ​Worry.​ The topic queries were submitted in English as Trends automatically translates them in any language. As mentioned in the previous paragraph, all the searches in the dataset were submitted between January 1s​ t​ to March 22n​ d​ 2020.

## Sample selection
Brodeur et. al set out to assess the lockdown effects in countries that implemented either a partial or a full lockdown by April 10th 2020. They thus retrieved search data for ten countries: Austria, Belgium, France, Ireland, Italy, Luxembourg, Portugal, Spain, the United Kingdom, and the United States of America.
In this research instead we narrowed our focus to the lockdown effects produced in one country, i.e. Italy. Germany and the United Kingdom were chosen as control groups as they implemented a lockdown on March 23rd, while Italy did so on March 9th. Our sample thus only consisted of these three countries.
Five variables were added to the dataset: a Dst variable (which took a value of 1 for the treatment group during the treatment period and 0 for all other observations); a Week variable; a dummy that took a value 1 for observations after March 9th; a treatment variable (a dummy taking a value of 1 for Italy and 0 for Germany and UK); and finally, to control for the severity of the pandemic in the three countries, the lagged number of new deaths of COVID-19 per day per million of inhabitants was downloaded from the ​Our World in Data​ dataset.

## Methodology
### Difference-in-differences estimators of lockdown effects
We use a difference-in-differences method to estimate the lockdown effects on well-being related searches. ​The lockdown date in our analysis is the date when lockdown was announced in Italy, which is March 9t​h.​ Since our control groups began lockdown on March 23rd, the treatment period is from 2020-03-09 to 2020-03-22.
The difference-in-differences regression model for a topic W is:
Wi = τDst + αCountry + βlagged new deaths + μi
where τ captures the effect of lockdown on searches for topic Wi on day ​i​. Dst is a dummy, Dst=1 for searches in Italy from 2020-03-09 to 2020-03-22, Dst=0 for all other observations. Country is a categorical variable to indicate the countries. ​Lagged new deaths is a covariate. The day fixed effect is denoted by μi .

### Parallel trends checks
Difference-in-differences method assumes that in the absence of treatment, the treated group would have followed a similar trend as the untreated group. To check this parallel trends assumption, we grouped the data by 12 weeks and tested if there’s any leads and lags effect using the following equation:
W i = θCountry + δlagged new deaths + ∑ λweek iDweek i + γi
where Dweek i = 1 for week ​i ​in Italy, Dweek i = 0 ​for all the other observations. The week fixed
effect is denoted by γi .
The results show that for topic searches on which lockdown has statistically significant effect (namely ​boredom,​ ​panic​, ​sleep​, ​suicide​, ​wellbeing​), there is no lead effect ( see Table 1). The trends of the searches in 3 countries are visualized in Figure 1.1 to Figure 1.5.

![](/figures/figure1.1.png)








