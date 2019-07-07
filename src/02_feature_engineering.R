# inport library ------------------------------------------------
library(tidyverse)
library(catboost)

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

train <- df_train_goto %>% 
  dplyr::left_join(df_train_genba, by = 'pj_no') 

test <- df_test_goto %>% 
  dplyr::left_join(df_test_genba, by = 'pj_no') 

x_train <- train %>% 
  dplyr::select(-one_of(remove_col)) %>% 
  dplyr::mutate_if(is.character, as.factor)

y_train <- train %>%
  dplyr::select(keiyaku_pr) %>%
  as.matrix()

x_test <- test %>% 
  dplyr::select(-one_of(remove_col)) %>% 
  dplyr::mutate_if(is.character, as.factor)