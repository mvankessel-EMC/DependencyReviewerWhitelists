raw <- utils::packageDescription("tidyverse")$Imports

imports <- strsplit(raw, ",")[[1]]

parsed <- gsub("^\\s+|\\s+$", "", imports)

df <- dplyr::bind_rows(lapply(stringr::str_split(string = parsed, pattern = "\\s"), function(x) {
  pkg_data <-
    stringr::str_remove_all(string = x[c(1, 3)], pattern = "\\)")
  data.frame(package = pkg_data[1],
                   version = pkg_data[2])
}))

write.csv(df, "TidyverseDependencies.csv")
