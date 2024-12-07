library(tidyverse)

# 導入資料
new_taipei_population <- read_csv("data/新北市各區人數統計表.csv")

# 查看資料結構
glimpse(new_taipei_population)

# 確認 village 欄位的唯一值
unique(new_taipei_population$village)

# 將 village 欄位轉換為有序因子
new_taipei_population <- new_taipei_population %>%
  mutate(village = factor(village, levels = sort(unique(village)), ordered = TRUE))

# 將需要的欄位轉換為數值型
new_taipei_population <- new_taipei_population %>%
  mutate(
    village = as.numeric(village),
    neighborhood = as.numeric(neighborhood),
    home = as.numeric(home),
    male = as.numeric(male),
    female = as.numeric(female),
    total = as.numeric(total)
  ) %>%
  # 根據數值欄位由小至大排序
  arrange(village, neighborhood, home, male, female, total)

# 查看排序後的資料結構
glimpse(new_taipei_population)

# 繪製條形圖
ggplot(new_taipei_population, aes(x = reorder(village, total), y = total)) +
  geom_bar(stat = "identity", fill = "skyblue") +  # 使用條形圖
  coord_flip() +  # 使條形圖水平顯示
  labs(
    title = "新北市各區總人數統計",
    x = "村區",
    y = "總人數"
  ) +
  theme_minimal()  # 使用簡潔的主題

# 計算 female 和 male 欄位的平均數
average_values <- new_taipei_population %>%
  summarise(
    avg_female = mean(female, na.rm = TRUE),  # 計算女性平均數，忽略缺失值
    avg_male = mean(male, na.rm = TRUE)       # 計算男性平均數，忽略缺失值
  )

# 查看結果
average_values

