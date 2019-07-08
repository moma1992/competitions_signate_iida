# inport library ------------------------------------------------
library(tidyverse)
library(magrittr)
library(catboost)

source('./utils/FE_function.R')

# join
remove_col <- c("id", "pj_no", "keiyaku_pr")

character_col <- c("jukyo",
                   "hokakisei1",
                   "hokakisei2",
                   "hokakisei3",
                   "hokakisei4",
                   "rosen_nm1",
                   "eki_nm1",
                   "bastei_nm1",
                   "rosen_nm2",
                   "eki_nm2",
                   "bastei_nm2")

# processing for train ------------------------------------------
train <- df_train_goto %>% 
  dplyr::left_join(df_train_genba, by = 'pj_no') 

# feature:levelplan
train %<>% convert_levelplan()

# feature:geo_data
train %<>% get_geo_data()

x_train <- train %>% 
  dplyr::select(-one_of(remove_col)) %>% 
  dplyr::mutate_if(is.character, as.factor)

y_train <- train %>%
  dplyr::select(keiyaku_pr) %>%
  as.matrix()

# processing for test ------------------------------------------
test <- df_test_goto %>% 
  dplyr::left_join(df_test_genba, by = 'pj_no') 

# feature:levelplan
test %<>% convert_levelplan()

# feature:geo_data
test %<>% get_geo_data()

x_test <- test %>% 
  dplyr::select(-one_of(remove_col)) %>% 
  dplyr::mutate_if(is.character, as.factor)