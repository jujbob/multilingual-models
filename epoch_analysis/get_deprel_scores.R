# This part generates the comparative table

source('conllu_functions.R')

result_kpv_data <- compare_result('kpv_mono/kpv-ud-test.conllu',
                                  'kpv_mono/dev_epoch_2.conllu') %>%
  add_count(deprel) %>%
  rename(occurrences_kpv = n)


result_kpv <- result_kpv_data %>% 
  freq_table(deprel, deprel_r) %>% 
  filter(deprel_r == TRUE) %>% 
  group_by(deprel) %>%
  select(-deprel_r, -n) %>% 
  mutate(freq = percent(freq)) %>% 
  arrange(desc(freq)) %>% rename(correctly_recognized_kpv = freq)

result_mixed_data <- compare_result('kpv_mixed/kpv-ud-test-mixed.conllu',
                                     'kpv_mixed/dev_epoch_2.conllu') %>%
  add_count(deprel) %>%
  rename(occurrences_mixed = n)

result_mixed <- result_mixed_data %>%
  freq_table(deprel, deprel_r) %>% 
  filter(deprel_r == TRUE) %>% 
  group_by(deprel) %>% 
  select(-deprel_r, -n) %>% 
  mutate(freq = percent(freq)) %>% 
  arrange(desc(freq)) %>% rename(correctly_recognized_mixed = freq)


# result_spoken <- compare_result('kpv_spoken/kpv-ud-ikdp.conllu',
#                                   'kpv_spoken/dev_epoch_4.conllu') %>%
#   freq_table(deprel, deprel_r) %>% 
#   filter(deprel_r == TRUE) %>% 
#   group_by(deprel) %>%
#   mutate(occurrences_spoken = sum(n)) %>%
#   select(-deprel_r, -n) %>% 
#   mutate(freq = percent(freq)) %>% 
#   arrange(desc(freq)) %>% rename(freq_spoken = freq)

# count(result_kpv_data, deprel) %>% View

full_join(result_kpv %>% ungroup() %>% full_join(count(result_kpv_data, deprel) %>% rename(occurrences_kpv = n)), 
          result_mixed %>% ungroup() %>% full_join(count(result_mixed_data, deprel) %>% rename(occurrences_mixed = n))) %>%
  select(deprel, occurrences_kpv, correctly_recognized_kpv, occurrences_mixed, correctly_recognized_mixed) %>%
  #left_join(result_spoken %>% ungroup()) %>% 
  mutate(correctly_recognized_kpv = if_else(is.na(correctly_recognized_kpv), "0%", correctly_recognized_kpv)) %>%
  mutate(correctly_recognized_mixed = if_else(is.na(correctly_recognized_mixed), "0%", correctly_recognized_mixed)) %>% View
  knitr::kable(format = 'latex') %>% 
    write_lines("relation_scores.tex")
