# EDA -----------------------------------------------------------
# rosenka_hb histgram
g <- train %>%
  dplyr::filter(rosenka_hb != 0) %>%
  dplyr::select(rosenka_hb) %>%
  ggplot(., aes(x = rosenka_hb)) +
  geom_histogram()

plot(g)

# log(rosenka_hb) histgram
g <- train %>%
  dplyr::filter(rosenka_hb != 0) %>%
  dplyr::mutate(log_rosenka_hb = log(rosenka_hb)) %>% # 路線価を対数変換
  dplyr::select(rosenka_hb, log_rosenka_hb) %>%
  ggplot(., aes(x = log_rosenka_hb)) +
  geom_histogram()

plot(g)

# log(rosenka_hb) vs keiyaku_pr
g <- train_rosenka <- train %>% select(rosenka_hb, keiyaku_pr) %>%
  dplyr::filter(rosenka_hb != 0) %>%  #路線価の欠損値を覗く
  dplyr::mutate(log_rosenka_hb = log(rosenka_hb)) %>%　# 路線価を対数変換
  ggplot(., aes(x = log_rosenka_hb, y = keiyaku_pr)) +
  geom_point()

plot(g)