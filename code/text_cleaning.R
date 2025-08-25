install.packages("quanteda")
install.packages("readtext")
install.packages("spacyr")
install.packages("jsonlite")


library(tidyverse)
library(quanteda)
library(jsonlite)
library(readtext)

#データ読み込み
lines <- readLines("data/data/speeches/Congress/imm_segments_with_tone_and_metadata.jsonlist")
data_list <- lapply(lines, fromJSON)
#df <- do.call(rbind, lapply(data_list, as.data.frame))

df <- do.call(rbind, data_list) |>
  as.data.frame()

###国名・国籍・地域リスト作成
countries <- list('Ireland'= ('Ireland'),
  'Germany'= ('Germany'),
  'Mexico'= ('Mexico'),
  'Italy'= ('Italy'),
  'England'= ('England'),
  'Canada'= ('Canada'),
  'Russia'= c('Russia', 'USSR'),
  'Poland'= ('Poland'),
  'China'= ('China'),
  'India'= ('India'),
  'Sweden'= ('Sweden'),
  'Austria'= ('Austria'),
  'Philippines'= c('Philippines', 'Philippine'),
  'Cuba'= ('Cuba'),
  'Hungary'= ('Hungary'),
  'Norway'= ('Norway'),
  'Czechoslovakia'= c('Czechoslovakia', 'Czech', 'Slovakia', 'Slovak'),
  'Vietnam'= ('Vietnam'),
  'Scotland'= ('Scotland'),
  'El Salvador'= ('El Salvador'),
  'Korea'= ('Korea'),
  'France'= ('France'),
  'Dominican Republic'= ('Dominican'),
  'Guatemala'= ('Guatemala'),
  'Greece'= ('Greece'),
  'Colombia'= ('Colombia'),
  'Jamaica'= ('Jamaica'),
  'Yugoslavia'= c('Yugoslavia', 'Serbia', 'Croatia', 'Macedonia', 'Bosnia', 'Herzegovina', 'Montenegro'),
  'Honduras'= ('Honduras'),
  'Japan'= ('Japan'),
  'Haiti'= ('Haiti'),
  'Portugal'= ('Portugal'),
  'Denmark'= ('Denmark'),
  'Lithuania'= ('Lithuania'),
  'Switzerland'= ('Switzerland'),
  'Wales'= ('Wales'),
  'Taiwan'= ('Taiwan'),
  'Netherlands'= c('Netherlands', 'Holland'),
  'Brazil'= ('Brazil'),
  'Finland'= ('Finland'),
  'Iran'= ('Iran'),
  'Ecuador'= ('Ecuador'),
  'Venezuela'= ('Venezuela'),
  'Romania'= c('Romania', 'Rumania', 'Roumania'),
  'Peru'= ('Peru')
)

regions <- list('Latin America'= c('Mexico', 'Cuba', 'El Salvador', 'Guatemala', 'Colombia', 'Honduras', 'Ecuador', 'Venezuela', 'Peru'),
  'Europe'= c('Ireland', 'Germany', 'Italy', 'Russia', 'USSR', 'Poland', 'Sweden', 'Austria', 'Hungary', 'Norway', 'Czechoslovakia', 'Czech', 'Slovakia', 'Slovak', 'Greece', 'Yugoslavia', 'Serbia', 'Croatia', 'Macedonia', 'Bosnia', 'Herzegovina', 'Montenegro', 'Portugal', 'Denmark', 'Lithuania', 'Switzerland', 'Netherlands', 'Holland', 'Finland', 'Romania', 'Rumania', 'Roumania'),
  'Asia'= c('China', 'Philippines', 'Philippine', 'Vietnam', 'Korea', 'Japan', 'Taiwan')
)

#def get_countries():
  #return countries


nationalities <- list('Ireland'= c('Irish', 'Irishman', 'Irishmen'),
  'Germany'= c('German', 'Germans'),
  'Mexico'= c('Mexican', 'Mexicans'),
  'Italy'= c('Italian', 'Italians'),
  'England'= c('Englishman', 'Englishmen'),
  'Canada'= c('Canadian', 'Canadians'),
  'Russia'= c('Russian', 'Russians'),
  'Poland'= c('Polish', 'Poles'),
  'China'= c('Chinese', 'Chinaman', 'Chinamen'),
  'India'= c('Indian', 'Indians'),
  'Sweden'= c('Swedish', 'Swedes'),
  'Austria'= c('Austrian', 'Austrians'),
  'Philippines'= c('Filipino', 'Filipinos', 'Filipina', 'Filipinas'),
  'Cuba'= c('Cuban', 'Cubans'),
  'Hungary'= c('Hungarian', 'Hungarians'),
  'Norway'= c('Norwegian', 'Norwegians'),
  'Czechoslovakia'= c('Czech', 'Czechs', 'Slovak', 'Slovaks', 'Slovakian', 'Slovakians', 'Czechoslovakian', 'Czechoslovakians'),
  'Vietnam'= c('Vietnamese'),
  'Scotland'= c('Scottish', 'Scots', 'Scotsman', 'Scotsmen'),
  'El Salvador'= c('Salvadoran', 'Salvadorans', 'Salvadorian', 'Salvadorians'),
  'Korea'= c('Korean', 'Koreans'),
  'France'= c('Frenchman', 'Frenchmen'),
  'Dominican Republic'= c('Dominican', 'Dominicans'),
  'Guatemala'= c('Guatemalan', 'Guatemalans'),
  'Greece'= c('Greek', 'Greeks'),
  'Colombia'= c('Colombian', 'Colombians'),
  'Jamaica'= c('Jamaican', 'Jamaicans'),
  'Yugoslavia'= c('Yugoslavian', 'Yugoslavians', 'Serbian', 'Serbians', 'Serb', 'Serbs', 'Croatian', 'Croatians', 'Croat', 'Croats', 'Macedonian', 'Macedonians', 'Bosnian', 'Bosnians'),
  'Honduras'= c('Honduran', 'Hondurans'),
  'Japan'= c('Japanese', 'Jap', 'Japs'),
  'Haiti'= c('Haitian', 'Haitians'),
  'Portugal'= c('Portuguese'),
  'Denmark'= c('Danish', 'Danes'),
  'Lithuania'= c('Lithuanian', 'Lithuanians'),
  'Switzerland'= c('Swiss'),
  'Wales'= c('Welsh', 'Welshman', 'Welshmen'),
  'Taiwan'= ('Taiwanese'),
  'Netherlands'= ('Dutch'),
  'Brazil'= c('Brazilian', 'Brazilians'),
  'Finland'= c('Finnish', 'Finn', 'Finns'),
  #元のデータはミスってました
  'Iran'= c('Iranian', 'Iranians'),
  'Ecuador'= c('Ecuadorian', 'Ecuadorians'),
  'Venezuela'= c('Venezuelan', 'Venezuelans'),
  'Romania'= c('Romanian', 'Romanians', 'Rumanian', 'Rumanians', 'Roumania', 'Roumanian', 'Roumanians'),
  'Peru'= c('Peruvian', 'Peruvians')
)

regionalities <- list('Latin America'= c('Mexican', 'Mexicans', 'Cuban', 'Cubans', 'Salvadoran', 'Salvadorans', 'Salvadorian', 'Salvadorians', 'Guatemalan', 'Guatemalans', 'Colombian', 'Colombians', 'Honduran', 'Hondurans', 'Ecuadorian', 'Ecuadorians', 'Venezuelan', 'Venezuelans', 'Peruvian', 'Peruvians', 'Hispanic', 'Hispanics', 'Latino', 'Latinos', 'Latina', 'Latinas'),
  'Europe'= c('Irish', 'Irishman', 'Irishmen', 'German', 'Germans', 'Italian', 'Italians', 'Russian', 'Russians', 'Polish', 'Poles', 'Swedish', 'Swedes', 'Austrian', 'Austrians', 'Hungarian', 'Hungarians', 'Norwegian', 'Norwegians', 'Czech', 'Czechs', 'Slovak', 'Slovaks', 'Slovakian', 'Slovakians', 'Czechoslovakian', 'Czechoslovakians', 'Greek', 'Greeks', 'Yugoslavian', 'Yugoslavians', 'Serbian', 'Serbians', 'Serb', 'Serbs', 'Croatian', 'Croatians', 'Croat', 'Croats', 'Macedonian', 'Macedonians', 'Bosnian', 'Bosnians', 'Portuguese', 'Danish', 'Danes', 'Lithuanian', 'Lithuanians', 'Swiss', 'Dutch', 'Finnish', 'Finn', 'Finns', 'Romanian', 'Romanians', 'Rumanian', 'Rumanians', 'Roumania', 'Roumanian', 'Roumanians'),
  'Asia'= c('Chinese', 'Chinaman', 'Chinamen', 'Filipino', 'Filipinos', 'Filipina', 'Filipinas', 'Vietnamese', 'Korean', 'Koreans', 'Japanese', 'Jap', 'Japs', 'Taiwanese')
)


### ○○系アメリカ人への変更
american_terms <- map(nationalities,
                      function(terms){c(paste0(terms,"American"),
                                        paste0(terms,"Americans"))})

substitutions <- map(nationalities,
                     function(terms){c(paste0(terms," American"),
                                       paste0(terms," Americans"),
                                       paste0(terms, "-Americans"),
                                       paste0(terms, "-American"))})

### その他リスト作成
early_chinese_terms <- list(c('china', 'chinese', 'chinamen', 'chinaman', 'indochina', 'indochinese',
  'asia', 'asian', 'asians', 'asiatic', 'asiatics',
  'orient', 'oriental', 'orientals', 'celestial', 'celestials',
  'cooly', 'coolie', 'coolys', 'coolies',
  'mongolian', 'mongolians', 'mongol', 'mongols'))

european_countries <- list(c('Ireland',
  'Germany',
  'Italy',
  'England',
  'Poland',
  'Sweden',
  'Austria',
  'Hungary',
  'Norway',
  'Czechoslovakia',
  'Scotland',
  'France',
  'Greece',
  'Yugoslavia',
  'Portugal',
  'Denmark',
  'Lithuania',
  'Switzerland',
  'Wales',
  'Netherlands',
  'Finland',
  'Romania'))

modern_mexican_terms <- list(c('mexico',
  'mexican',
  'mexicans',
  'wetback',
  'wetbacks',
  'bracero',
  'braceros',
  'mexicanamerican',
  'mexicanamericans'))


modern_hispanic_terms <- list(c('mexico',
  'mexican',
  'mexicans',
  'wetback',
  'wetbacks',
  'bracero',
  'braceros',
  'mexicanamerican',
  'mexicanamericans',
  'hispanic',
  'hispanics',
  'latino',
  'latinos',
  'latina',
  'latinas',
  'hispanicamerican',
  'hispanicamericans',
  'cuba',
  'cuban',
  'cubanamerican',
  'cubanamericans',
  'cubans',
  'salvador',
  'salvadorans',
  'salvadorian',
  'salvadorians',
  'guatemala',
  'guatemalan',
  'guatemalans',
  'colombia',
  'colombian',
  'colombians',
  'honduras',
  'honduran',
  'hondurans',
  'ecuador',
  'ecuadorian',
  'ecuadorians',
  'venezuela',
  'venezuelan',
  'venezuelans',
  'peru',
  'peruvian',
  'peruvians'))

###小文字化
american_terms <- 
  map(american_terms,tolower)
countries <-
  map(countries, tolower)
nationalities <-
  map(nationalities, tolower)
regions <-
  map(regions, tolower)
regionalities <- 
  map(regionalities, tolower)

###辞書
american_terms_dic <- dictionary(american_terms)
countries_dic <- dictionary(countries)
nationalities_dic <- dictionary(nationalities)
regions_dic <- dictionary(regions)

df$doc_id <- 1:nrow(df)

corpus_obj<- corpus(as.character(df$text)) 

head(corpus_obj)

table(df$congress)

# データのインポート
speeches_df <- stream_in(file("data/data/speeches/Congress/imm_segments_with_tone_and_metadata.jsonlist"), 
                         verbose = FALSE)%>%
  mutate(doc_id = paste0("doc_", row_number()))

str(speeches_df)

# コーパス化
corpus_sample <- corpus(speeches_df)

# トークン化
tokens_sample <- tokens(corpus_sample)

# トークン化したデータと国名辞書のマッチング
lookup_sample <- tokens_lookup(tokens_sample, countries_dic)

# DFM化
mention_dfm <- dfm(lookup_sample)

#合計集計
result_sample <- colSums(mention_dfm)
result_sample_df <- as.data.frame(result_sample)
result_sample_df_2 <- attributes(result_sample_df)
result_sample_df <- result_sample_df %>%
  mutate(country = result_sample_df_2$row.names)
#write_json(result_sample, "data/output/result_sample.jsonlist")
write_csv(result_sample_df, "data/output/result_sample.csv")


