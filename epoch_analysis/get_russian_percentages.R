source('conllu_functions.R')

c('kpv_spoken//kpv-ud-ikdp.conllu',
  'kpv_mono/kpv-ud-test.conllu',
  'kpv_mixed/kpv-ud-test-mixed.conllu') %>%
  map(get_percentages) %>%
  bind_rows() %>%
  select(file, kpv, mixed, rus) %>%
  arrange(desc(kpv)) %>%
  knitr::kable(format = 'latex') %>%
  write_lines('russian_percentages.tex')

