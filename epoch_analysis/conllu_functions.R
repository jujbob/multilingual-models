setwd('~/multilingual-bist-parser/iwclul/')

# These tests are run in langdoc/UD_Komi-Zyrian iwclul branch
# hash b3d1c176d248acfffa24bf648551b0d84c6488a6
# kpv-ud-ikdp.conllu

library(tidyverse)
library(scales)
library(glue)

# This reads CONLL-U file nicely

read_conll <- function(conll_file){
  
  `%>%` <- dplyr::`%>%`
  
  conll_lines <- readr::read_lines(conll_file)
  
  dplyr::data_frame(string = conll_lines) %>%
    dplyr::mutate(sentence = cumsum(stringr::str_detect(string, '^$'))) %>%
    dplyr::filter(! string == '') %>%
    dplyr::group_by(sentence) %>%
    dplyr::mutate(id = stringr::str_extract(string, '(?<=# sent_id = )(.+)')) %>%
    dplyr::mutate(sentence_text = stringr::str_extract(string, '(?<=# text = )(.+)')) %>%
    tidyr::fill(id) %>%
    tidyr::fill(sentence_text) %>%
    dplyr::filter(! stringr::str_detect(string, '^#')) %>% # if there are more annotations above the sentence, those are now disgarded
    dplyr::ungroup() %>%
    tidyr::separate(col = string,
                    into = c('id_form', 'form', 'lemma', 'upostag', 'xpostag', 'feats', 'head', 'deprel', 'deps', 'misc'),
                    sep = '\t')
}

# This is used to count the frequency tables

freq_table <- function(x, 
                       group_var, 
                       prop_var) {
  group_var <- enquo(group_var)
  prop_var  <- enquo(prop_var)
  x %>% 
    group_by(!!group_var, !!prop_var) %>% 
    summarise(n = n()) %>% 
    mutate(freq = n /sum(n)) %>% 
    ungroup
}

# This compares the original and result

compare_result <- function(original, dev_epoch){
  orig <- read_conll(original)
  result <- read_conll(dev_epoch)
  
  test <- left_join(orig %>% mutate(uniq_id = 1:n()), 
                    result %>% mutate(uniq_id = 1:n()) %>% 
                      select(uniq_id, head, deprel) %>%
                      rename(head_p = head, deprel_p = deprel), by = 'uniq_id') %>%
    mutate(head_r = if_else(head == head_p, TRUE, FALSE)) %>%
    mutate(deprel_r = if_else(deprel == deprel_p, TRUE, FALSE)) %>%
    select(id_form, form, lemma, upostag, misc, starts_with('head'), starts_with('deprel'), everything()) %>%
    filter(! upostag == 'PUNCT') # %>% filter(! is.na(deprel_r))#  %>%
  #   filter(deprel_r == FALSE) %>% count(deprel, deprel_p, sort = TRUE)
  
  test <- test %>% mutate(misc = if_else(misc == '_', 'kpv', misc))
  
  filename = str_extract(dev_epoch, '(?<=/).+$')
  
  test
}

## This gets percentages of different languages

get_percentages <- function(conllu_file){
  read_conll(conllu_file) %>%
    filter(! upostag == 'punct') %>%
    mutate(misc = if_else(misc == '_', 'kpv', misc)) %>%
    freq_table(misc) %>%
    mutate(freq = scales::percent(freq)) %>%
    select(-n) %>%
    tidyr::spread(misc, freq) %>%
    mutate(file = basename(conllu_file))
}

# This function gets for LAS and UAS scores per epoch 

harvest_freq <- function(lang){
  
  1:10 %>% map(~ {
    compare_result('~/multilingual-bist-parser/corpus/ud-treebanks-v2.0/UD_Komi-Zyrian/kpv-ud-test-mixed.conllu', glue('/Users/niko/multilingual-bist-parser/results_kpv_mixed_7/dev_epoch_{.x}.conllu')) %>% 
      #filter(misc == 'rus') %>%
      #select(id, id_form, form, lemma, upostag, misc, head, head_p, head_r) %>%
      #    filter(! head == 0) %>%
      #  mutate(deprel_p = str_replace_all(deprel_p, ':.+', '')) %>%
      split(.$id) %>%
      map( ~ {
        left_join(.x, .x %>% select(id_form, misc) %>% rename(head = id_form, head_lang = misc), by = 'head')
      }) %>%
      bind_rows() %>%
      filter(head_lang == lang) %>%
      freq_table(head_r) %>%
      filter(! head_r == FALSE) %>%
      spread(head_r, freq) %>%
      select(-n) %>%
      rename(head = `TRUE`) %>%
      mutate(epoch = .x)
  }) %>% bind_rows()
}

read_las <- function(filename){
  read_delim(filename, 
             skip = 10, 
             delim = '|', 
             col_names = FALSE, col_types = 'ccccc') %>%
    select(X1, X2) %>%
    mutate(X1 = str_trim(X1),
           X2 = as.double(str_trim(X2))) %>%
    #spread(X1, X2) %>%
    rename(test = X1,
           score = X2) %>%
    mutate(epoch = as.numeric(str_extract(filename, '(?<=dev_epoch_)\\d+'))) %>%
    #select(epoch, LAS, UAS) %>%
    arrange(epoch)
}

# This plots LAS and UAS scores by epoch

plot_las <- function(test_mono_dir, test_mixed_dir, test_spoken_dir){
  mono <- dir(test_mono_dir, 'conllu.txt', full.names = TRUE) %>%
    map(read_las) %>% bind_rows() %>% mutate(type = 'monolingual')
  
  mixed <- dir(test_mixed_dir, 'conllu.txt', full.names = TRUE) %>%
    map(read_las) %>% bind_rows() %>% mutate(type = 'mixed')
  
  spoken <- dir(test_spoken_dir, 'conllu.txt', full.names = TRUE) %>%
    map(read_las) %>% bind_rows() %>% mutate(type = 'spoken')
  
  las_scores <- bind_rows(mono, mixed, spoken) %>% mutate(type = fct_inorder(type))
  
  ggplot(data = las_scores,
         aes(x = epoch, y = score, color = test)) +
    geom_line() +
    facet_grid(. ~ type) +
    ggtitle("LAS and UAS scores by epoch on different test corpora")
}

evaluate_sentences <- function(gold_conllu, compared_conllu){
  compare_result(gold_conllu, compared_conllu) %>%
    group_by(id, deprel_r) %>%
    summarise (n = n()) %>%
    mutate(freq = n / sum(n)) %>%
    filter(deprel_r == TRUE) %>% 
    arrange(desc(freq)) %>%
    ungroup() %>%
    mutate(epoch = str_extract(compared_conllu, '(?<=dev_epoch_)\\d+'))
}
