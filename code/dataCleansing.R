# ���̺귯��
library(ggplot2)
library(dplyr)
library(mice)
library(DMwR)
library(randomForest)
library(missForest)

install.packages("ggplot2")
install.packages("dplyr")
install.packages("mice")
install.packages("DMwR")
install.packages("randomForest")
install.packages("missForest")

# ������ �ҷ�����
dat1 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1907_1909.csv")
dat2 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1910_1919.csv")
dat3 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1920_1929.csv")
dat4 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1930_1939.csv")
dat5 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1940_1949.csv")
dat6 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1950_1959.csv")
dat7 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1960_1969.csv")
dat8 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1970_1979.csv")
dat9 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1980_1984.csv")
dat10 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1985_1989.csv")
dat11 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1990_1994.csv")
dat12 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_1995_1999.csv")
dat13 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_2000_2004.csv")
dat14 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_2005_2009.csv")
dat15 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_2010_2014.csv")
dat16 <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\data\\OBS_ASOS_DD_2015_2021.csv")

# dat : 1907~2021�⵵�� ������� ���� ������
dat <- rbind(dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12, dat13, dat14, dat15, dat16)

# ������ ����
names(dat) <- c("point", "place", "date", "tempAvg", "tempLow", "tempLowTime",
                "tempHigh", "tempHighTime", "precipTime", "precipHighMin", "precipHighMinTime", "precipHighHour",
                "precipHighHourTime", "precipDate", "windMaxInstant", "windMaxInstantDir", "windMaxInstantTime", "windMax",
                "windMaxDir", "windMaxTime", "windAvg", "airDXSum", "windDir", "dewPointAvg",
                "RHMin", "RHMinTime", "RHAvg", "VPAvg", "LocalAPAvg", "seaAPMax", 
                "seaAPMaxTime", "seaAPMin", "seaAPMinTime", "seaAPAvg", "sunDuration", "sunlightTimeSum",
                "SRMaxHourTime", "SRMaxHour", "SRSum", "snowDepthDaily", "snowDepthDailyTime", "snowDepth",
                "snowDepthTime", "snowDepthThreeSum", "warCloudAvg", "cloudMidAvg", "groundTempAvg", "grassTempMin",
                "temp5Avg", "temp10Avg", "temp20Avg", "temp30Avg", "temp_5", "temp1",
                "temp1_5", "temp3", "temp5", "evapnLargeSum", "evapnSmallSum", "precip9_9", "article", "fogTime")

# chr ������ ���� date�� date�� �� ��ȯ
dat$date <- as.Date(dat$date)

# ����ġ Ȯ��
sapply(dat, function(x) sum(is.na(x)))
md.pattern(dat)

# ������ ����
save_dat_before_dataCleansing <- write.csv(dat, "C:\\Users\\jessy\\Desktop\\����\\LaVue\\dat_before_dataCleansing.csv")

#����ġ�� 10000�� �̻��� ������ chr������ ������ ������� ���� ����
dat <- dat[,-which(names(dat) %in% c("tempLowTime", "tempHighTime", "precipTime", "precipHighMin", "precipHighMinTime", "precipHighHour", "precipHighHourTime", "precipDate", "windMaxInstant", "windMaxInstantTime", "windMaxTime", "windDir", "dewPointAvg", "RHMinTime", "seaAPMax", "seaAPMaxTime", "seaAPMin", "seaAPMinTime", "sunDuration", "SRMaxHourTime", "SRMaxHour", "SRSum", "snowDepthDaily", "snowDepthDailyTime", "snowDepth", "snowDepthTime", "snowDepthThreeSum", "cloudMidAvg", "temp3", "temp5", "evapnLargeSum", "precip9_9", "article", "point", "place", "fogTime"))]

# ����ġ �����ϴ� �� ����
dat_for_imp <- na.omit(dat) # 43383 -> 30635

 cleaned <- missCompare::clean(dat_for_imp,
                        var_removal_threshold = 0.5,
                        ind_removal_threshold = 0.8,
                        missingness_coding = -9)
 
 metadata <- missCompare::get_data(cleaned,
                           matrixplot_sort = T,
                           plot_transform = T)
 
 missCompare::impute_simulated(rownum = metadata$Rows,
                        colnum = metadata$Columns,
                        cormat = metadata$Corr_matrix,
                        MD_pattern = metadata$MD_Pattern,
                        NA_fraction = metadata$Fraction_missingness,
                        min_PDM = 5,
                        n.iter = 1,
                        assumed_pattern = NA)

 
dat_for_imp <- dat_for_imp[,-which(names(dat_for_imp) %in% c("date"))]
dat_mice <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\dat_mice.csv")
dat_mice <- dat_mice[,-which(names(dat_mice) %in% c("X", "date"))]

col.names=colnames(dat_for_imp)
lapply(col.names,function(t,dat_for_imp,dat_mice){ks.test(dat_for_imp[,t],dat_mice[,t])}, dat_for_imp, dat_mice)

dk <- data.frame(var=character(25), D=numeric(25), p=numeric(25), stringsAsFactors=F)
for(j in 1:25){  
        k <- ks.test(dat_for_imp[,j],dat_mice[,j])
        dk$var[j] <- names(dat_for_imp)[j]
        dk$D[j]       <- k$statistic
        dk$p[j]       <- k$p.value
}
dk