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

#緯度経度情報をjoin
get_geo_data <- function(data_typ) {
  #経度緯度データを読み込み
  geo_train <- read_csv('./result/result_geo_train.csv')
  geo_test <- read_csv('./result/result_geo_test.csv')
  
  #test train データを結合
  mst_geo_data <- dplyr::union(geo_train, geo_test) %>%
    select(-X1)
  
  #test train データにgeoデータをjoin
  data_typ %<>%
    dplyr::left_join(mst_geo_data,
                     by = c("jukyo" = "city_name")) %>%
    dplyr::select(-target_city)
}
