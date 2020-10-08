#### Analyzing loadsol running data###
rm(list=ls())
library(ggplot2)
library(tidyverse)

dat <- read.csv('C:/Users/Daniel.Feeney/Dropbox (Boa)/SensoriaFolder/ReliabilityTesting/trial.csv')
dat <- as_tibble(dat)
head(dat)

ggplot(data = dat, mapping = aes(x = as.factor(PrePost), y = PkHeel, fill = TrialNo)) +
  geom_boxplot() + ylab('Peak Heel Pressure') + xlab('Trial No')

ggplot(data = dat, mapping = aes(x = as.factor(PrePost), y = varHeel, fill = TrialNo)) +
  geom_boxplot() + ylab('Standard deviation of Heel Pressure') + xlab('Trial No')

dat %>%
  group_by(TrialNo, PrePost) %>%
  summarize(
    avgPHeel = mean(PkHeel),
    avgVarH = mean(varHeel),
    avgPkNav = mean(PkNav),
    avgVarNav = mean(VarNav),
    avgPkToe = mean(PkToe),
    avgVarToe = mean(VarToe),
    avgPkL5R = mean(PkL5R),
    avgVarL5R = mean(VarL5R)
  )


# bland-altman plots
firstDat <- dat %>%
  filter(PrePost == 1)
firstDat <- firstDat[1:13,]
secondDat <- dat %>%
  filter(PrePost == 2)

diffHeel <- secondDat$PkHeel - firstDat$PkHeel
diffP <- secondDat$PkHeel - firstDat$PkHeel/firstDat$PkHeel*100
sd.diff <- sd(diffHeel)
sd.diffp <- sd(diffP)
plotDat <- data.frame(firstDat$PkHeel, secondDat$PkHeel, diffHeel, diffP)

ggplot(data = plotDat, aes(firstDat.PkHeel, diffHeel)) + 
  geom_point(size=2, colour = rgb(0,0,0, alpha = 0.5)) + 
  theme_bw() + 
  #when the +/- 2SD lines will fall outside the default plot limits 
  ylim(mean(plotDat$diffHeel) - 3*sd.diff, mean(plotDat$diffHeel) + 3*sd.diff) +
  ylim(mean(plotDat$diffHeel) - 3*sd.diff, mean(plotDat$diffHeel) + 3*sd.diff) +
    geom_hline(yintercept = 0, linetype = 3) +
    geom_hline(yintercept = mean(plotDat$diffHeel)) +
    geom_hline(yintercept = mean(plotDat$diffHeel) + 2*sd.diff, linetype = 2) +
    geom_hline(yintercept = mean(plotDat$diffHeel) - 2*sd.diff, linetype = 2) +
    ylab("Difference pre and post shoe change") +
    xlab("Baseline Peak Heel")
#navicular
diffNav <- secondDat$PkNav - firstDat$PkNav
sd.diffNav <- sd(diffNav)
plotNav <- data.frame(firstDat$PkNav, secondDat$PkNav, diffNav, diffNav)

ggplot(data = plotNav, aes(firstDat.PkNav, diffNav)) + 
  geom_point(size=2, colour = rgb(0,0,0, alpha = 0.5)) + 
  theme_bw() + 
  geom_hline(yintercept = 0, linetype = 3) +
  geom_hline(yintercept = mean(plotNav$diffNav)) +
  geom_hline(yintercept = mean(plotNav$diffNav) + 2*sd.diffNav, linetype = 2) +
  geom_hline(yintercept = mean(plotNav$diffNav) - 2*sd.diffNav, linetype = 2) +
  ylab("Difference pre and post shoe change") +
  xlab("Baseline Peak Navicular")

#1st
diffToe <- secondDat$PkToe - firstDat$PkToe
sd.diffToe <- sd(diffToe)
plotToe <- data.frame(firstDat$PkToe, secondDat$PkToe, diffToe)

ggplot(data = plotToe, aes(firstDat.PkToe, diffToe)) + 
  geom_point(size=2, colour = rgb(0,0,0, alpha = 0.5)) + 
  theme_bw() + 
  geom_hline(yintercept = 0, linetype = 3) +
  geom_hline(yintercept = mean(plotToe$diffToe)) +
  geom_hline(yintercept = mean(plotToe$diffToe) + 2*sd.diffToe, linetype = 2) +
  geom_hline(yintercept = mean(plotToe$diffToe) - 2*sd.diffToe, linetype = 2) +
  ylab("Difference pre and post shoe change") +
  xlab("Baseline Peak 1st Phalanx")

#L5R
diffl5r <- secondDat$PkL5R - firstDat$PkL5R
sd.diffl5r <- sd(diffl5r)
plotl5r <- data.frame(firstDat$PkL5R, secondDat$PkL5R, diffl5r)

ggplot(data = plotl5r, aes(firstDat.PkL5R, diffl5r)) + 
  geom_point(size=2, colour = rgb(0,0,0, alpha = 0.5)) + 
  theme_bw() + 
  geom_hline(yintercept = 0, linetype = 3) +
  geom_hline(yintercept = mean(plotl5r$diffl5r)) +
  geom_hline(yintercept = mean(plotl5r$diffl5r) + 2*sd.diffl5r, linetype = 2) +
  geom_hline(yintercept = mean(plotl5r$diffl5r) - 2*sd.diffl5r, linetype = 2) +
  ylab("Difference pre and post shoe change") +
  xlab("Baseline Peak Lat 5th rayPhalanx")

exp_dat <- read.csv('C:/Users/Daniel.Feeney/Dropbox (Boa)/SensoriaFolder/ReliabilityTesting/trial3.csv')
exp_dat %>%
  group_by(TrialNo) %>%
  summarize(
    avgPHeel = mean(PkHeel),
    avgVarH = mean(varHeel),
    avgPkNav = mean(PkNav),
    avgVarNav = mean(VarNav),
    avgPkToe = mean(PkToe),
    avgVarToe = mean(VarToe),
    avgPkL5R = mean(PkL5R),
    avgVarL5R = mean(VarL5R)
  )
