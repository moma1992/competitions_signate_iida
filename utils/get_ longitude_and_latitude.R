# inport library ------------------------------------------------
library(tidyverse)
library(magrittr)
library(glue)
library(ggmap)
library(geosphere)

# chose data type -----------------------------------------------
data <- test

# calc from city geecode ----------------------------------------
target_city <- c("東京駅")

# google map から地形情報取得
tmp_geo_data <- ggmap::geocode(target_city,
                               output = "all",
                               nameType = "long")

lng <- tmp_geo_data$results[[1]]$geometry$viewport$northeast$lng %>%
  as.numeric()

# 緯度
lat <- tmp_geo_data$results[[1]]$geometry$viewport$northeast$lat %>%
  as.numeric()

# 地形データを格納
to_position <- cbind(lng, lat)

# calc to city geecode ------------------------------------------

# resut init
result_geo <- data_frame()

for (i in 1:nrow(data)) {
  city_name <- data$jukyo[i]
  cat(glue('{i}:{city_name}'))
  # google map から地形情報取得
  tmp_geo_data <- ggmap::geocode(data$jukyo[i],
                                 output = "all",
                                 nameType = "long")
  
  # 経度
  lng <-
    tmp_geo_data$results[[1]]$geometry$viewport$northeast$lng %>%
    as.numeric()
  
  # 緯度
  lat <-
    tmp_geo_data$results[[1]]$geometry$viewport$northeast$lat %>%
    as.numeric()
  
  # 地形データを格納
  from_position <- cbind(lng, lat)
  
  # 東京駅までの距離を想定
  distance <- distGeo(from_position, to_position)
  
  result_geo_tmp <- data_frame(city_name,
                               target_city,
                               lng,
                               lat,
                               distance)
  
  result_geo %<>%
    rbind(result_geo_tmp)
}

result_geo

# save data -----------------------------------------------------
write.csv(result_geo, './result_geo_test.csv')