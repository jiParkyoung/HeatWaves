
# ������ �ҷ�����
ro_data_mice4 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\mice_df_robust4.csv")
str(ro_data_mice4)
ro_data_mice4$date <- as.Date(ro_data_mice4$date)



min(ro_data_mice4[-1])
ro_data_mice4[-1] <- log(ro_data_mice4[-1]+6)

str(ro_data_mice4)
#----PCA------
# ������ �� ������
round(cor(ro_data_mice4[,-c(1,28)]),3)

pca_cov <- prcomp(ro_data_mice4[,-c(1,28)])#���л� ��� �̿�

options(max.print=30000)
print(pca_cov)

plot(pca_cov, type = "l")
# plot������ ���Ⱑ �ϸ��ϰ� ���ϴ� �Ȳ�ġ �κ��� ��Ȯ�ϰ� ���ϱ� ���� �ʴ�.
# ��6 ~ ��10 �ּ����� ���Ⱑ ����� ���δ�.

summary(pca_cov$sdev)#��հ����� 0.074871

summary(pca_cov)
# �� �ּ����� �߿䵵(Proportion of Variance) �������� Cumulative Proportion�� ����
# ��1�� �ּ��к��� ��6�� �ּ������� ��ü �������� 91.28 %�� ������ �� �ִ�.
# �׷��Ƿ� 6���� �ּ��и� �����Ѵ�.


pca <- prcomp(ro_data_mice4[,-c(1,28)], scale = T) #������ ��� �̿�
plot(pca, type = "l")
# plot���� ��5 �ּ��к��� ���Ⱑ �ϸ��ϰ� ���ϰ� �� ���ķδ� ���� �ǹ̰� ���� ������
# ��5 �ּ��б��� 5���� �ּ����� �����Ѵ�.
# ���л� ����� �̿��� ������ �� �������� ����

summary(pca)
print(pca_cov)

head(ro_data_mice4[,-c(1,28)])
#���� ����
# ��������ó�� ���� scale ����ȭ�� �� ��쿡�� ���л���� ����ص� ������
# �������� scale�� ���� �ٸ� ��� Ư�� ������ ��ü���� ������ �¿��ϱ� ������ 
# ������ ����� ����Ͽ� �м��ϴ� ���� ����.

# �ּ��� ������ ����
# (1) �ּ����� ���� �߿䵵(Cumulative Proportion)�� 70 ~ 90 % ���̿��� ����.
# (2) ��� ���������� ���� �������� ���� �ּ����� ����.
#     ������ ��� �̿�� ��� �л�(ǥ������) = 1 �̹Ƿ� Standard deviation�� 1 �Ǵ� 0.7 ���� ���� ���� ����.
# (3) Scree diagram���� ���Ⱑ �ϸ������� ����, �� �Ȳ�ġ�� �����ϴ� �������� ����.

ro_data_mice4 <- ro_data_mice4[,c('date','to_tempHigh4','tempHigh','LocalAPAvg','tempAvg','tempLow','VPAvg',
                                  'seaAPAvg','grassTempMin','temp5Avg','windMax','windAvg','airDXSum',
                                  'windMaxDir','RHAvg','RHMin','windMaxInstantDir','sunlightTimeSum','temp30Avg',
                                  'temp10Avg','temp20Avg')]

#������ ������
train4 <- subset(ro_data_mice4, format(date,'%Y') < 2017)
test4 <- subset(ro_data_mice4, format(date,'%Y') >= 2017)
str(test4)

train4 <- train4[-1]
test4 <- test4[-1]

#min(rlogtrain)
#min(rlogtest)
str(train4)
str(test4)





#tempAvg+tempLow+windMaxInstantDir+windMax+windAvg+RHMin+sunlightTimeSum+temp5Avg
robustLog_model4 <- lm(to_tempHigh4~., train4)
summary(robustLog_model4)




#����
model_fwd_d4 <- step(lm(to_tempHigh4 ~1, train4),
                     trace = 0, direction = "forward",
                     scope = list(lower=to_tempHigh4 ~ 1,upper = formula(robustLog_model4)))
summary(model_fwd_d4)

#airDXSum + RHMin+ grassTempMin+ tempAvg + 
model_fwd2_d4 <- lm(to_tempHigh4 ~temp5Avg + sunlightTimeSum + 
                      VPAvg + tempHigh + tempLow + windMaxInstantDir + 
                      windMaxDir + RHAvg + seaAPAvg + LocalAPAvg + temp10Avg + 
                      temp30Avg + windMax + windAvg  , data = train4)
summary(model_fwd2_d4)

#���߰�����
library("car")
vif(model_fwd2_d4)

#temp10Avg + temp30Avg (���ǹ�)+ windMax(���ǹ�) + tempLow 
model_fwd3_d4 <- lm(to_tempHigh4 ~ temp5Avg + sunlightTimeSum + VPAvg + 
                      tempHigh  + windMaxInstantDir + windMaxDir + RHAvg + 
                      seaAPAvg + LocalAPAvg+ 
                      windAvg, data = train4)
summary(model_fwd3_d4)
vif(model_fwd3_d4)



train4 <- train4[,c('to_tempHigh4','tempHigh' , 'sunlightTimeSum','temp5Avg','windMaxInstantDir' ,'VPAvg' , 
                    'RHAvg' ,'seaAPAvg', 'windMaxDir', 'windAvg', 'LocalAPAvg')]

test4 <- test4[,c('to_tempHigh4','tempHigh' , 'sunlightTimeSum','temp5Avg','windMaxInstantDir' ,'VPAvg' , 
                  'RHAvg' ,'seaAPAvg', 'windMaxDir', 'windAvg', 'LocalAPAvg')]



#���� �׽�Ʈ
predtemphigh <- predict(model_fwd3_d4,test4[-1])
plot(test4[2:32,2], type = 'o', col = 'red')#���� �ְ����
lines(predtemphigh[2:32], type = 'o', col = 'blue')#������ �ְ����



#�����м�
par(mfrow=c(2,2))
plot(model_fwd3_d4)

shapiro.test(model_fwd3_d4$residuals[1:4999])#���Լ� ����??������ ������ �����°� �ƴϳ�??
car::durbinWatsonTest(model_fwd3_d4)#������ ����
car::ncvTest(model_fwd3_d4)#��л꼺 ���� ??�̰͵� �����ΰ� ������??

install.packages('gvlma')
library(gvlma)
summary(gvlma::gvlma(model_fwd3_d4))


#����� �м�
cor(rlogtrain)
#install.packages("corrplot")
#install.packages("magrittr")
library(corrplot) # correlation test and visualization
library(magrittr)
# mtcars �������� ��� ������ ������ ���� ���� ��, p.value �� ����
dat%>%cor.mtest(method='pearson')->p.value

#p.value ����, ���� Ȯ���ϱ� 
str(p.value)
dev.new() # chart �׸��� device �غ�
dat %>% na.omit%>%cor %>% corrplot.mixed(p.mat=p.value[[1]], sig.level=.05, lower = 'number', upper='pie', tl.cex=.6, tl.col='black', order='hclust')

library(PerformanceAnalytics)
all_date4 <- rbind(train4, test4)
chart.Correlation(all_date4, histogram=TRUE, col="grey10", pch=1)#MEAN

install.packages("GGally")
library(GGally)
ggcorr(rlogtrain, name="corr", label=T)





