# inport library ------------------------------------------------
library(tidyverse)
library(magrittr)
library(RPostgreSQL)
library(DBI)

# conect DB ----------------------------------------------------
con <- dbConnect(
  PostgreSQL(),
  host = "xxxxxxxxxxxx",
  port = xxxxxxxxxxxx,
  dbname = "xxxxxxxxxxxx",
  user = "xxxxxxxxxxxx",
  password = "xxxxxxxxxxxx"
)

# insert data into DB ------------------------------------------
# testとtrain を結合する
df_test_goto %<>%
  dplyr::mutate(keiyaku_pr = '99999999999') # trainと結合するために予測値にダミーを入れる

raw_genba <- rbind(df_test_genba, df_train_genba)
raw_goto <- rbind(df_test_goto, df_train_goto)

# testとtrain を書き込む
DBI::dbWriteTable(con, 'raw_genba', raw_genba)
DBI::dbWriteTable(con, 'raw_goto', raw_goto)