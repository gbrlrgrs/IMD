if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(here,
       tidyverse,
       magrittr,
       httr,
       data.table)

fnGetWebZip <- function(url, targFile) {
  print("Downloading...")
  zip <- tempfile()
  GET(url    = url,
      config = write_disk(zip),
      progress())
  print("Unzipping...")
  targFile <- unzip(zipfile   = zip,
                    files     = targFile,
                    exdir     = dirname(tempdir()),
                    junkpaths = T)
  unlink(zip)
  targFile
}

tblIMD <- fnGetWebZip(url = "https://www.arcgis.com/sharing/rest/content/items/6fb8941d58e54d949f521c92dfb92f2a/data",
                      targFile = "Data/ONSPD_FEB_2025_UK.csv") %>% 
  fread() %>% 
  as_tibble()

tblIMD %<>%
  mutate(cntry = str_sub(lsoa21, 1, 1),
         cntry = case_match(cntry,
                            "E" ~ "English",
                            "W" ~ "Welsh",
                            "S" ~ "Scottish",
                            "N" ~ "Northern Irish")) %>%
  group_by(cntry) %>% 
  mutate(mm = max(imd)) %>% 
  ungroup() %>% 
  mutate(dec = trunc((imd-1) / (mm / 10))+1) %>% 
  # drop_na(doterm) %>% 
  select(pcds, cntry, mm, imd, dec) %T>% 
  fwrite(here("IMD.csv"))

# checks ------------------------------------------------------------------
tblIMD %>%
  filter(str_detect(pcds, "SK4")) %>% view()

tblIMD %>% 
  filter(imd!=0) %>% 
  distinct(cntry, imd, dec) %>% 
  group_by(cntry, dec) %>% 
  count() %>% 
  print(n=99)