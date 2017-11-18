source('conllu_functions.R')

## This gives information about how the sentences were evaluated
## Higher the percentages better the recognition rate across epochs

evaluate_sentences_per_epoch <- function(gold_conllu, test_folder){
map2(.x = gold_conllu, 
     .y = 1:10, 
     .f = ~ evaluate_sentences(gold_conllu = .x, compared_conllu = glue::glue('{test_folder}/dev_epoch_{.y}.conllu'))) %>% 
  bind_rows() %>% arrange(id) %>% group_by(id) %>%
  summarise(mean = mean(freq),
            min = min(freq),
            max = max(freq)) %>% arrange(desc(mean))
}

evaluate_sentences_per_epoch('kpv_mono/kpv-ud-test.conllu', 'kpv_mono/')
evaluate_sentences_per_epoch('kpv_mixed/kpv-ud-test-mixed.conllu', 'kpv_mixed/')
evaluate_sentences_per_epoch('kpv_spoken/kpv-ud-ikdp.conllu', 'kpv_spoken/')
