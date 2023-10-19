library(plotly)
library(rmarkdown)
library(dplyr)

# ������ �ð�ȭ�� ���� ���� �߰� - ���� ������
df_for_graph <- read.csv("C:\\Users\\jessy\\Desktop\\����\\LaVue\\dat_mice.csv")
df_for_graph$date <- as.Date(df_for_graph$date)
test_for_graph <- subset(df_for_graph, format(date,'%Y') >= 2017)
test['date'] <- test_for_graph[2]
test['tempHighReal'] <- test_for_graph[5]

# ������ �ð�ȭ�� ���� ���� �߰� - ���� ������
date <- test_for_graph[2]
predtemphigh1 <- predict(model_fwd3,test[-1])
predtemphigh2 <- predict(model_fwd3_d2,test2[-1])
predtemphigh3 <- predict(model_fwd3_d3,test3[-1])
predtemphigh4 <- predict(model_fwd3_d4,test3[-1])
predtemphigh5 <- predict(model_fwd3_d5,test3[-1])
predtemphigh6 <- predict(model_fwd3_d6,test6[-1])
predtemphigh7 <- predict(model_fwd3_d7,test7[-1])
df_pred <- data.frame(date, predtemphigh1, predtemphigh2, predtemphigh3, predtemphigh4, predtemphigh5, predtemphigh6, predtemphigh7)

df_pred[-1] <- exp(df_pred[-1])-6
df_pred[-1] <- (df_pred[-1] * (quantile(test$tempHighReal, 0.75) - quantile(test$tempHighReal, 0.25))) + median(test$tempHighReal)

# 2017�� 1��~6�� + 7��
fig_y <- as.list(df_pred[0:182,2])
fig_y <- append(fig_y, df_pred[183,3]); fig_y <- append(fig_y, df_pred[184,4]); fig_y <- append(fig_y, df_pred[185,5]); fig_y <- append(fig_y, df_pred[186,6]); fig_y <- append(fig_y, df_pred[187,7]); fig_y <- append(fig_y, df_pred[188,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2017�� 1��~6�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[0:188,'date'], y=test[0:188,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[0:188,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[0:188,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[182,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2017��7��1��")
fig

# 2017�� 6��~12�� + 7��
fig_y <- as.list(df_pred[182:366,2])
fig_y <- append(fig_y, df_pred[367,3]); fig_y <- append(fig_y, df_pred[368,4]); fig_y <- append(fig_y, df_pred[369,5]); fig_y <- append(fig_y, df_pred[370,6]); fig_y <- append(fig_y, df_pred[371,7]); fig_y <- append(fig_y, df_pred[372,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2017�� 6��~12�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[182:372,'date'], y=test[182:372,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[182:372,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[182:372,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[366,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2018��1��1��")
fig

# 2018�� 1��~6�� + 7��
fig_y <- as.list(df_pred[366:547,2])
fig_y <- append(fig_y, df_pred[548,3]); fig_y <- append(fig_y, df_pred[549,4]); fig_y <- append(fig_y, df_pred[550,5]); fig_y <- append(fig_y, df_pred[551,6]); fig_y <- append(fig_y, df_pred[552,7]); fig_y <- append(fig_y, df_pred[553,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2018�� 1��~6�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[366:553,'date'], y=test[366:553,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[366:553,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[366:553,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[547,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2018��7��1��")
fig

# 2018�� 6��~12�� + 7��
fig_y <- as.list(df_pred[547:731,2])
fig_y <- append(fig_y, df_pred[732,3]); fig_y <- append(fig_y, df_pred[733,4]); fig_y <- append(fig_y, df_pred[734,5]); fig_y <- append(fig_y, df_pred[735,6]); fig_y <- append(fig_y, df_pred[736,7]); fig_y <- append(fig_y, df_pred[737,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2018�� 6��~12�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[547:737,'date'], y=test[547:737,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[547:737,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[547:737,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[731,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2019��1��1��")
fig

# 2019�� 1��~6�� + 7��
fig_y <- as.list(df_pred[731:912,2])
fig_y <- append(fig_y, df_pred[913,3]); fig_y <- append(fig_y, df_pred[914,4]); fig_y <- append(fig_y, df_pred[915,5]); fig_y <- append(fig_y, df_pred[916,6]); fig_y <- append(fig_y, df_pred[917,7]); fig_y <- append(fig_y, df_pred[918,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2019�� 1��~6�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[731:918,'date'], y=test[731:918,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[731:918,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[731:918,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[912,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2019��7��1��")
fig

# 2019�� 6��~12�� + 7��
fig_y <- as.list(df_pred[912:1096,2])
fig_y <- append(fig_y, df_pred[1097,3]); fig_y <- append(fig_y, df_pred[1098,4]); fig_y <- append(fig_y, df_pred[1099,5]); fig_y <- append(fig_y, df_pred[1100,6]); fig_y <- append(fig_y, df_pred[1101,7]); fig_y <- append(fig_y, df_pred[1102,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2019�� 6��~12�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[912:1102,'date'], y=test[912:1102,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[912:1102,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[912:1102,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[1096,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2020��1��1��")
fig

# 2020�� 1��~6�� + 7��
fig_y <- as.list(df_pred[1096:1278,2])
fig_y <- append(fig_y, df_pred[1279,3]); fig_y <- append(fig_y, df_pred[1280,4]); fig_y <- append(fig_y, df_pred[1281,5]); fig_y <- append(fig_y, df_pred[1282,6]); fig_y <- append(fig_y, df_pred[1283,7]); fig_y <- append(fig_y, df_pred[1284,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2020�� 1��~6�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[1096:1284,'date'], y=test[1096:1284,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[1096:1284,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[1096:1284,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[1278,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2020��7��1��")
fig

# 2020�� 6��~12�� + 7��
fig_y <- as.list(df_pred[1278:1462,2])
fig_y <- append(fig_y, df_pred[1463,3]); fig_y <- append(fig_y, df_pred[1464,4]); fig_y <- append(fig_y, df_pred[1465,5]); fig_y <- append(fig_y, df_pred[1466,6]); fig_y <- append(fig_y, df_pred[1467,7]); fig_y <- append(fig_y, df_pred[1468,8])
fig <- plot_ly() 
fig <- fig %>% layout(title='2020�� 6��~12�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_trace(x=test[1278:1468,'date'], y=test[1278:1468,'tempHighReal'], color='������', mode = "lines") 
fig <- fig %>% add_trace(x=df_pred[1278:1468,'date'], y=fig_y, color='������', mode = "lines")
fig <- fig %>% add_lines(x=test[1278:1468,'date'], y=33, color="��������")
fig <- fig %>% add_lines(x=test[1462,'date'], y=c(min(unlist(fig_y)),max(unlist(fig_y))), color="2021��1��1��")
fig

# 2021�� 1��~6�� + 7��
fig_y1 <- as.list(test[1462:1612,'tempHighReal'])
fig_y2 <- as.list(df_pred[1462:1612,2])
fig_y2 <- append(fig_y2, df_pred[1612,3]); fig_y2 <- append(fig_y2, df_pred[1612,4]); fig_y2 <- append(fig_y2, df_pred[1612,5]); fig_y2 <- append(fig_y2, df_pred[1612,6]); fig_y2 <- append(fig_y2, df_pred[1612,7]); fig_y2 <- append(fig_y2, df_pred[1612,8])

# fig_x <-  as.list(test[1462:1581,'date'])
# date1 <- test[1581,'date']+1; date2 <- test[1581,'date']+2; date3 <- test[1581,'date']+3; date4 <- test[1581,'date']+4; date5 <- test[1581,'date']+5; date6 <- test[1581,'date']+6;
# date1 <- as.Date(date1); date2 <- as.Date(date2); date3 <- as.Date(date3); date4 <- as.Date(date4); date5 <- as.Date(date5); date6 <- as.Date(date6)
# fig_x <- append(fig_x, date1); fig_x <- append(fig_x, date2); fig_x <- append(fig_x, date3); fig_x <- append(fig_x, date4); fig_x <- append(fig_x, date5); fig_x <- append(fig_x, date6);

fig_x1 <- format(seq(as.Date("2021-01-01"), as.Date("2021-06-07"), by="days"), format="%m-%d-%Y")
fig_x2 <- format(seq(as.Date("2021-01-01"), as.Date("2021-05-31"), by="days"), format="%m-%d-%Y")

fig_x1[152]
fig <- plot_ly() 
fig <- fig %>% layout(title='2021�� 1��~6�� ����ȸ�͸�', yaxis=list(title='�ְ����'), sizes=c(380,150))
fig <- fig %>% add_lines(x=fig_x2, y=fig_y1, color='������', mode = "lines")
fig <- fig %>% add_lines(x=fig_x1, y=fig_y2, color='������', mode = "lines")
fig <- fig %>% add_lines(x=fig_x1, y=33, color="��������")
fig <- fig %>% add_lines(x=fig_x1[152], y=c(min(unlist(fig_y2)),max(unlist(fig_y2))), color="2021��6��1��")
fig