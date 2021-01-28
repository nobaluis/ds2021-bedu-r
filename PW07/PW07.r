library(mongolite)

# connection to local mongodb
m <- mongo(
  collection = 'match',
  db = 'match_games',
  url = 'mongodb://localhost',
  verbose = TRUE,
  options = ssl_options()
)

# read local dataset
match <- read.csv('../datasets/data_ps07.csv')

# insert into mongodb
m$insert(match)

# check records
m$count()

# game math of Real Madrid on 2015-12-20
res <- m$find(
  '{
    "$and": [
      {"$or": [{"HomeTeam": "Real Madrid"}, {"AwayTeam": "Real Madrid"}]},
      {"Date": "2015-12-20"}
    ]
  }'
)

# close dataset
rm(m)
gc()
