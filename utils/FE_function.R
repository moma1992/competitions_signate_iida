# inport library ------------------------------------------------
library(tidyverse)
library(catboost)
library(magrittr)

#階数・プランを加工する関数 (引数：データフレーム)
convert_levelplan <- function(data_typ) {　　
  data_typ %<>%
    dplyr::mutate(
      #建物の階数
      level = case_when(                     
        grepl("1F", levelplan) ~ 1,
        grepl("2F", levelplan) ~ 2,
        grepl("3F", levelplan) ~ 3,
        grepl("土地売り", levelplan) ~ 0
      ),
      #部屋の数
      room_cnt = case_when(　　　　　　　　　
        grepl("/2", levelplan) ~ 2,
        grepl("/3", levelplan) ~ 3,
        grepl("/4", levelplan) ~ 4,
        grepl("/5", levelplan) ~ 5,
        grepl("/土地売り", levelplan) ~ 0
      ),
      #サービスルームの数
      service_room_cnt = case_when(　　　　　
        grepl("S", levelplan) ~ 1,
        grepl("2S", levelplan) ~ 2,
        TRUE ~ 0)
    )
}
