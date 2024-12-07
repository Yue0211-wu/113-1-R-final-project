library(tidyverse)

# 導入 CSV 檔案
taipei_agencies <- read_csv("data/台北市仲介公司資料.csv", locale = locale(encoding = "UTF-8"))

glimpse(taipei_agencies)

# 統計 "評鑑等級" 類別及數量
taipei_agencies |>
  dplyr::count(`評鑑等級`, name = "數量")

# 替換所有以 "１０６" 開頭的機構地址
taipei_agencies <- taipei_agencies |>
  dplyr::mutate(
    `機構地址` = stringr::str_replace_all(`機構地址`, "^１０６", "")
  )

# 查看所有唯一的 "機構地址"
unique(taipei_agencies$`機構地址`)

# 提取 "機構地址" 中的區名稱
taipei_agencies |>
  dplyr::mutate(
    區 = stringr::str_extract(`機構地址`, "([\\w]+區)")  # 假設區域名稱以"區"結尾
  ) |>
  dplyr::count(`區`, name = "數量") |>
  dplyr::arrange(desc(數量))

