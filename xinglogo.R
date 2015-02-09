# Autor: Jens Bruno Wittek

# produziert eine Wordcloud mit Inhalten des Studiengangs "Statistische Wissenschaften"
# Bild wird als Logo der XING-Gruppe genutzt

setwd("M://R")
library(wordcloud)

png("xinglogo.png",width=600,height=600,units="px",bg="#E73E0C")
woerter=data.frame(
   lemma=c(
      "Statistische\nWissenschaften","Statistik","Universität Bielefeld","Wirtschaftswissenschaften","Mathematik",
      "Soziologie","Psychologie","Data Science","Ökonometrie","Regression",
      "R","Stata","Matlab","Python","SPSS",
      "SAS","Data Mining","Quantitative Methoden","Simulation","Bootstrapping",
	  "Splines","GLM","LMM","GAM","Marktforschung",
	  "Consulting","Stochastik","Dimensionsreduktion","Clustering","Klassifikation",
	  "Prognose","Maschinelles Lernen","Evaluation","Modellierung","Zeitreihenanalyse"),
   anzahl=c( # virtuelle Häufigkeit des jeweiligen Lemmas für Größe in der Wordcloud
      90,80,100,60,50,
      40,40,60,40,30,
      70,40,40,10,20,
      20,30,30,20,10,
      10,10,10,10,20,
	  30,30,20,20,20,
	  20,20,20,20,20)
)
farbskala=c("black","darkblue","dodgerblue","cyan","green","darkgreen")
wordcloud(words=woerter$lemma,freq=woerter$anzahl,scale=c(4,1.5),rot.per=0,colors=colorRampPalette(rev(farbskala))(nrow(woerter)))
dev.off()


