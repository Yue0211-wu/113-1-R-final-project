library(tidyverse)

# 載入 CSV 檔案
file_path <- "data/健保特約醫事機構地區醫院.csv"

# 使用 read_csv 導入檔案
tidy_hospital_data <- read_csv(file_path)

# 查看資料結構
glimpse(tidy_hospital_data)

# 導入檔案（指定 Big5 編碼）
file_path <- "data/健保特約醫事機構地區醫院.csv"

tidy_hospital_data <- read_csv(
  file_path,
  locale = locale(encoding = "UTF-8")
)

# 分割地址並排序
tidy_hospital_data_sorted <- tidy_hospital_data |>
  mutate(
    市 = str_extract(地址, "^[^市]+市"),             # 提取 "市"
    區 = str_extract(地址, "[^市]+市([^區]+區)"),      # 提取 "區"
    鄉鎮 = str_extract(地址, "[^市]+市[^區]+區([^鄉鎮]+[鄉鎮])") # 提取 "鄉" 或 "鎮"
  ) |>
  arrange(市, 區, 鄉鎮) # 按市、區、鄉鎮排序

# 檢查結果
glimpse(tidy_hospital_data_sorted)

head(tidy_hospital_data)      # 檢視前幾筆資料
glimpse(tidy_hospital_data)   # 檢視資料結構

# 導入檔案（指定 Big5 編碼，根據檔案實際編碼調整）
file_path <- "data/健保特約醫事機構地區醫院.csv"
tidy_hospital_data <- read_csv(file_path, locale = locale(encoding = "UTF-8"))

# 整理醫事機構種類的類別與數量
institution_counts <- tidy_hospital_data |>
  count(`醫事機構種類`, name = "數量") |>
  arrange(desc(數量))

# 查看結果
institution_counts

# 導入檔案（假設 Big5 編碼，根據實際檔案編碼調整）
file_path <- "data/健保特約醫事機構地區醫院.csv"
tidy_hospital_data <- read_csv(file_path, locale = locale(encoding = "UTF-8"))

# 從地址提取市的名稱並統計數量
city_counts <- tidy_hospital_data |>
  mutate(市 = str_extract(地址, "^[^市]+市")) |>  # 提取市的名稱
  count(市, name = "數量") |>                   # 統計每個市的數量
  arrange(desc(數量))                          # 按數量排序

# 查看結果
city_counts

