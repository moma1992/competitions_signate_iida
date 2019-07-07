# inport library ------------------------------------------------
library(tidyverse)
library(catboost)

# set pool ------------------------------------------------------
train_pool <- catboost.load_pool(data = x_train, label = y_train)
test_pool <- catboost.load_pool(data = x_test)

# set model params ---------------------------------------------
params <- list(
  iterations = 500,
  learning_rate = 0.01,
  depth = 8,
  loss_function = 'RMSE',
  eval_metric = 'MAPE',
  random_seed = 55,
  od_type = 'Iter',
  #metric_period = 50,
  od_wait = 20,
  use_best_model = TRUE,
  thread_count = 2
)

# make model ---------------------------------------------------
model <- catboost.train(learn_pool = train_pool, params = params)

# predict ------------------------------------------------------
y_pred = catboost.predict(model, test_pool)

# write feature importance --------------------------------------
feat_imp <-
  as_data_frame(catboost.get_feature_importance(model)) %>%
  mutate(Feature = rownames(model$feature_importances)) %>%
  select(Feature = Feature, Importance = V1) %>%
  arrange(desc(Importance))

ggplot(feat_imp, aes(x = Feature, y = Importance)) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 45)) +
  scale_x_discrete(limits = feat_imp$Feature)

write_tsv(feat_imp, './result/feat_imp.csv', col_names = TRUE)

# submit data ---------------------------------------------------
submit <- cbind(test$id, y_pred) %>% as.data.frame()
write_tsv(submit, './submit/submit_02.tsv', col_names = FALSE)