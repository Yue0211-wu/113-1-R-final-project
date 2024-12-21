library(tidyverse)

# 導入 CSV 檔案
taipei_agency_data <- readr::read_csv("data/台北市仲介公司資料.csv")

# 查看資料的前幾列
taipei_agency_data |> head()

# 統計 "評鑑等級" 的類別及數量
taipei_agency_data |>
  dplyr::count(`評鑑等級`, name = "數量")

library(ggplot2)

# 統計 "評鑑等級" 的數量並繪製長條圖
taipei_agency_data |>
  dplyr::count(`評鑑等級`, name = "數量") |>
  ggplot(aes(x = `評鑑等級`, y = 數量, fill = `評鑑等級`)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(
    title = "台北市仲介公司評鑑等級分佈",
    x = "評鑑等級",
    y = "數量"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Noto Sans TC"),  # 設定中文字體，視系統支援情況調整
    axis.text.x = element_text(angle = 45, hjust = 1)  # 旋轉 x 軸標籤，避免重疊
  )

library(stringr)

# 替換 "機構地址" 中的 "106台北市大安區" 為 "台北市大安區"
taipei_agency_data <- taipei_agency_data |>
  dplyr::mutate(
    `機構地址` = str_replace(`機構地址`, "^１０６台北市大安區", "台北市大安區")
  )

# 查看修改後的資料
taipei_agency_data |> dplyr::filter(str_detect(`機構地址`, "台北市大安區")) |> head()

# 檢查 "機構地址" 是否包含 "106台北市大安區"（應該已替換）
taipei_agency_data |>
  dplyr::filter(str_detect(`機構地址`, "^106台北市大安區")) |>
  nrow()  # 確認剩餘數量，應為 0

# 檢查修改後是否正確替換為 "台北市大安區"
taipei_agency_data |>
  dplyr::filter(str_detect(`機構地址`, "^台北市大安區")) |>
  dplyr::select(`機構地址`) |>
  head()

# 統計 "機構名稱" 的類別數量
num_agency_types <- taipei_agency_data |>
  dplyr::summarise(機構名稱種類數 = dplyr::n_distinct(`機構名稱`))

# 查看結果
num_agency_types

# 新增 "機構分類" 欄位，根據機構名稱關鍵字分類
taipei_agency_data <- taipei_agency_data |>
  dplyr::mutate(
    `機構分類` = dplyr::case_when(
      str_detect(`機構名稱`, "仲介") ~ "仲介公司",
      str_detect(`機構名稱`, "有限公司") ~ "有限公司",
      TRUE ~ "其他"
    )
  )

# 統計各分類的數量
taipei_agency_data |>
  dplyr::count(`機構分類`, name = "數量")


# 計算 "專業人員人數" 的類別數和平均數
taipei_agency_data |>
  dplyr::summarise(
    專業人員_類別數 = dplyr::n_distinct(`專業人員人數`),
    專業人員_平均數 = mean(`專業人員人數`, na.rm = TRUE)
  )

# 計算 "聘僱許可雙語人員人數" 的類別數和平均數
taipei_agency_data |>
  dplyr::summarise(
    聘僱許可雙語人員人數_類別數 = dplyr::n_distinct(`聘僱許可雙語人員人數`),
    聘僱許可雙語人員人數_平均數 = mean(`聘僱許可雙語人員人數`, na.rm = TRUE)
  )

# 計算 "從業人員人數" 的類別數和平均數
taipei_agency_data |>
  dplyr::summarise(
    從業人員人數_類別數 = dplyr::n_distinct(`從業人員人數`),
    從業人員人數_平均數 = mean(`從業人員人數`, na.rm = TRUE)
  )

# 將 "負責人/經理人英文姓名" 依 A 到 Z 排列
taipei_agency_data_sorted <- taipei_agency_data |>
  dplyr::arrange(`負責人/經理人英文姓名`)

# 查看排序後的結果
head(taipei_agency_data_sorted)

