# DiD Italy as treatment group and UK and Germany as control groups, with fixed effect of day
library(rio)
library(plm)
library(texreg)

# DiD estimation
data<-import("d2020_ItalyGermanyUK_0322.xlsx")
data$Country<-factor(data$Country,levels = c("UK","Germany","Italy"))
data$Giorno<-as.Date(data$Giorno)

Noia<- plm(Noia~Dst+Country+new_death_per_million_lagged,
                model = "within", index = c("Giorno"),data=data)
summary(Noia)
fixef(Noia)

Soddisfazione<- plm(Soddisfazione~Dst+Country+new_death_per_million_lagged,
           model = "within", index = c("Giorno"),data=data)
summary(Soddisfazione)

Divorzio<- plm(Divorzio~Dst+Country+new_death_per_million_lagged,
                    model = "within", index = c("Giorno"),data=data)
summary(Divorzio)

Impairment<- plm(Impairment~Dst+Country+new_death_per_million_lagged,
               model = "within", index = c("Giorno"),data=data)

Irritabilita<- plm(Irritabilita~Dst+Country+new_death_per_million_lagged,
                 model = "within", index = c("Giorno"),data=data)
summary(Irritabilita)

Solitudine<- plm(Solitudine~Dst+Country+new_death_per_million_lagged,
                   model = "within", index = c("Giorno"),data=data)
summary(Solitudine)

Panico<- plm(Panico~Dst+Country+new_death_per_million_lagged,
                  model = "within", index = c("Giorno"),data=data)
summary(Panico)

Tristezza<- plm(Tristezza~Dst+Country+new_death_per_million_lagged,
                     model = "within", index = c("Giorno"),data=data)
summary(Tristezza)

Sonno<- plm(Sonno~Dst+Country+new_death_per_million_lagged,
                model = "within", index = c("Giorno"),data=data)
summary(Sonno)

Stress<- plm(Stress~Dst+Country+new_death_per_million_lagged,
            model = "within", index = c("Giorno"),data=data)

Suicidio<- plm(Suicidio~Dst+Country+new_death_per_million_lagged,
             model = "within", index = c("Giorno"),data=data)

Benessere<- plm(Benessere~Dst+Country+new_death_per_million_lagged,
               model = "within", index = c("Giorno"),data=data)

Preoccupazione<- plm(Preoccupazione~Dst+Country+new_death_per_million_lagged,
                model = "within", index = c("Giorno"),data=data)

topic<-c("Noia","Soddisfazione","Divorzio","Impairment",
         "Irritabilita","Solitudine","Panico","Tristezza","Sonno",
         "Stress","Suicidio","Benessere","Preoccupazione")

htmlreg(list(Noia,Soddisfazione,Divorzio,
             Impairment,Irritabilita,Solitudine,Panico,
             Tristezza,Sonno,Stress,Suicidio,Benessere,Preoccupazione),
        custom.model.names=topic, file="model output.doc")


###############################
# parallel trend checks
library(fastDummies)
dummy<-dummy_cols(data,select_columns = "Week")

dummy$Dsweek1<-dummy$Treatment*dummy$Week_1
dummy$Dsweek2<-dummy$Treatment*dummy$Week_2
dummy$Dsweek3<-dummy$Treatment*dummy$Week_3
dummy$Dsweek4<-dummy$Treatment*dummy$Week_4
dummy$Dsweek5<-dummy$Treatment*dummy$Week_5
dummy$Dsweek6<-dummy$Treatment*dummy$Week_6
dummy$Dsweek7<-dummy$Treatment*dummy$Week_7
dummy$Dsweek8<-dummy$Treatment*dummy$Week_8
dummy$Dsweek9<-dummy$Treatment*dummy$Week_9
dummy$Dsweek10<-dummy$Treatment*dummy$Week_10
dummy$Dsweek11<-dummy$Treatment*dummy$Week_11
dummy$Dsweek12<-dummy$Treatment*dummy$Week_12


Noia<- plm(Noia~Country+new_death_per_million_lagged+
             Dsweek1+Dsweek2+Dsweek3+Dsweek4+Dsweek5+Dsweek6+Dsweek7+Dsweek8+Dsweek9+Dsweek10+Dsweek11+Dsweek12,
           model = "within", index = c("Week"),data=dummy)
summary(Noia)

Panico<- plm(Panico~Country+new_death_per_million_lagged+
             Dsweek1+Dsweek2+Dsweek3+Dsweek4+Dsweek5+Dsweek6+Dsweek7+Dsweek8+Dsweek9+Dsweek10+Dsweek11+Dsweek12,
            model = "within", index = c("Week"),data=dummy)
summary(Panico)

Sonno<- plm(Sonno~Country+new_death_per_million_lagged+
              Dsweek1+Dsweek2+Dsweek3+Dsweek4+Dsweek5+Dsweek6+Dsweek7+Dsweek8+Dsweek9+Dsweek10+Dsweek11+Dsweek12,
             model = "within", index = c("Week"),data=dummy)
summary(Sonno)

Suicidio<-plm(Suicidio~Country+new_death_per_million_lagged+
                Dsweek1+Dsweek2+Dsweek3+Dsweek4+Dsweek5+Dsweek6+Dsweek7+Dsweek8+Dsweek9+Dsweek10+Dsweek11+Dsweek12,
              model = "within", index = c("Week"),data=dummy)
summary(Suicidio)

Benessere<-plm(Benessere~Country+new_death_per_million_lagged+
                 Dsweek1+Dsweek2+Dsweek3+Dsweek4+Dsweek5+Dsweek6+Dsweek7+Dsweek8+Dsweek9+Dsweek10+Dsweek11+Dsweek12,
              model = "within", index = c("Week"),data=dummy)
summary(Benessere)

topic<-c("Noia","Panico","Sonno","Suicidio","Benessere")

htmlreg(list(Noia,Panico,Sonno,Suicidio,Benessere),
        custom.model.names=topic, file="checks.doc")



###################
# Plots of parallel trends

library(tidyverse)

label<-paste("week",1:13,sep="")
scale<-as.vector(as.matrix(data[1:82,] %>% filter(Weekday=="Sunday") %>% select(Giorno)))
scales<-c("2020-01-01",scale)


ggplot(data,aes(x=Giorno,y=Noia,group=Country,col=Country))+
  geom_line()+scale_color_manual(values=c("#999999", "#E69F00", "red"))+
  scale_x_date(breaks = as.Date(scales),date_labels = label)+
  geom_vline(xintercept =as.Date(scale),linetype="dashed",col="grey")+
  geom_vline(xintercept =as.Date("2020-03-08"),linetype="dashed",col="red")+xlab("week")
                 
ggplot(data,aes(x=Giorno,y=Panico,group=Country,col=Country))+
  geom_line()+scale_color_manual(values=c("#999999", "#E69F00", "red"))+
  scale_x_date(breaks = as.Date(scales),date_labels = label)+
  geom_vline(xintercept =as.Date(scale),linetype="dashed",col="grey")+
  geom_vline(xintercept =as.Date("2020-03-08"),linetype="dashed",col="red")+xlab("week")


ggplot(data,aes(x=Giorno,y=Sonno,group=Country,col=Country))+
  geom_line()+scale_color_manual(values=c("#999999", "#E69F00", "red"))+
  scale_x_date(breaks = as.Date(scales),date_labels = label)+
  geom_vline(xintercept =as.Date(scale),linetype="dashed",col="grey")+
  geom_vline(xintercept =as.Date("2020-03-08"),linetype="dashed",col="red")+xlab("week")

ggplot(data,aes(x=Giorno,y=Suicidio,group=Country,col=Country))+
  geom_line()+scale_color_manual(values=c("#999999", "#E69F00", "red"))+
  scale_x_date(breaks = as.Date(scales),date_labels = label)+
  geom_vline(xintercept =as.Date(scale),linetype="dashed",col="grey")+
  geom_vline(xintercept =as.Date("2020-03-08"),linetype="dashed",col="red")+xlab("week")

ggplot(data,aes(x=Giorno,y=Benessere,group=Country,col=Country))+
  geom_line()+scale_color_manual(values=c("#999999", "#E69F00", "red"))+
  scale_x_date(breaks = as.Date(scales),date_labels = label)+
  geom_vline(xintercept =as.Date(scale),linetype="dashed",col="grey")+
  geom_vline(xintercept =as.Date("2020-03-08"),linetype="dashed",col="red")+xlab("week")











