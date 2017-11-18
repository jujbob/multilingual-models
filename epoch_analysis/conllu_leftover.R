# This prints table that has information about relations and labels whether they were analyzed correctly

compare_result(original = "~/multilingual-bist-parser/corpus/ud-treebanks-v2.0/UD_Komi-Zyrian/kpv-ud-train.conllu",
               "~/multilingual-bist-parser/results_kpv/dev_epoch_1.conllu") %>%
  freq_table(deprel, deprel_r) %>% 
  filter(deprel_r == TRUE) %>% 
  group_by(deprel) %>% 
  select(-deprel_r, -n) %>% 
  mutate(freq = percent(freq)) %>% 
  arrange(desc(freq)) %>% knitr::kable(format = 'latex')






## 


library(glue)

head_rates <- bind_rows(harvest_freq('kpv') %>% mutate(lang = 'kpv'),
                        harvest_freq('rus') %>% mutate(lang = 'rus'))

library(ggplot2)

ggplot(data = head_rates,
       aes(x = epoch, y = head, color = lang)) +
  geom_line()



##




find_nns <- evaluate_result('~/github/UD_Komi-Zyrian/kpv-ud-ikdp.conllu',
                            glue('/Users/niko/multilingual-bist-parser/results_kpv_rus/dev_epoch_1.conllu'))

find_nns %>%
  mutate(bigram = glue("{lag(form)} {form}")) %>%
  select(bigram, everything()) %>%
  filter(upostag == 'NOUN' & lag(upostag == 'NOUN')) %>%
  filter(misc == 'rus') %>%
  count(deprel_r)

find_nns <- evaluate_result('~/github/UD_Komi-Zyrian/kpv-ud-test-mixed.conllu',
                            glue('/Users/niko/multilingual-bist-parser/results_kpv_mixed_7/dev_epoch_6.conllu'))

find_nns %>%
  mutate(bigram = glue("{lag(form)} {form}")) %>%
  select(bigram, everything()) %>%
  filter(deprel_p == 'obl') %>%
  filter(deprel_r == 'FALSE') %>% 
  count(deprel_r)

# This functions attempts to compare individual sentences

find_nns_rus <- evaluate_result('~/multilingual-bist-parser/corpus/ud-treebanks-v2.0/UD_Russian/ru-ud-dev.conllu',
                                glue('/Users/niko/multilingual-bist-parser/results_rus/dev_epoch_8.conllu'))


find_nns_rus %>%
  mutate(bigram = glue("{lag(form)} {form}")) %>%
  select(bigram, everything()) %>%
  filter(upostag == 'NOUN' & lag(upostag == 'NOUN')) %>%
  #  filter(misc == 'kpv') %>%
  count(deprel_r)
