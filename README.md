## Multilingual models

This repository contains the additional resources used in the paper [Multilingual Dependency Parsing for Low-Resource Languages: Case Studies of North Saami and Komi-Zyrian](https://hal.archives-ouvertes.fr/hal-01856178/document), written by KyungTae Lim, Niko Partanen and Thierry Poibeau in [LATTICE laboratory](http://www.lattice.cnrs.fr/), Paris. 

Also, we participated in the CoNLL 2018 shared task with those multilingual embeddings and ELMO embeddings trained by ourselves. We placed 2st in UAS and 4th LAS out of 27 teams, and shown the best performing tagger and parser for Saami with the multilingual models (see the paper [SEx BiST: A Multi-Source Trainable Parser with Deep Contextualized Lexical Representations](http://universaldependencies.org/conll18/proceedings/pdf/K18-2011.pdf)).


The additional materials include:

- Bilingual dictionaries extracted from Giellatekno infrastructure's [SVN repository](https://gtsvn.uit.no/langtech/trunk/words/dicts/):
    - [Finnish–Komi](https://github.com/jujbob/multilingual-models/blob/master/dictionaries/fin_kpv.tsv)
    - [Russian–Komi](https://github.com/jujbob/multilingual-models/blob/master/dictionaries/rus_kpv.tsv)
    - [Komi–English](https://github.com/jujbob/multilingual-models/blob/master/dictionaries/kpv_eng.tsv)
    - [Finnish–Northern Saami](https://github.com/jujbob/multilingual-models/blob/master/dictionaries/fin_sme.tsv)
    - [Northern Saami–Finnish](https://github.com/jujbob/multilingual-models/blob/master/dictionaries/sme_fin.tsv)
- Pretrained monolingual and multilingual word embeddings, latter aligned with [VecMap](https://github.com/artetxem/vecmap)
    - [Northern Saami–English](https://mycore.core-cloud.net/index.php/s/Yca4nj8e9xXWddW/download)
    - [Northern Saami–Finnish](https://mycore.core-cloud.net/index.php/s/gbHTEsIllrbQVKy/download)
    - [Komi-Zyrian–English](https://mycore.core-cloud.net/index.php/s/T6FnPPigIvkJOrw/download)
    - [Komi-Zyrian–Russian](https://mycore.core-cloud.net/index.php/s/aH6PFv4KohH7emV/download)
    - [Komi-Zyrian–Finnish](https://mycore.core-cloud.net/index.php/s/X6NWfynpC8UcrO2/download)
    - [Komi-Zyrian–Russian–Finnish](https://mycore.core-cloud.net/index.php/s/oC5kdDrRMGR3UxZ/download)

Komi-Zyrian UD-corpora have been later split into two sections, one for written and another for spoken languages, and they can be found in [Lattice](https://github.com/UniversalDependencies/UD_Komi_Zyrian-Lattice) and [IKDP](https://github.com/UniversalDependencies/UD_Komi_Zyrian-IKDP) repositories within UD infrastructure. In this study we have used the [version 0.1](https://github.com/langdoc/UD_Komi-Zyrian/releases/tag/v0.1), which is located in earlier repository which were not yet ready to be integrated into UD. We are fully aware that this version contains errors and inconsistencies, as there were in that point several open questions in applying UD annotation model to a new language.

Users interested about Komi treebanks are strongly encouraged to look into dev-branches of these treebanks, since they reflect the state that will be included in next UD release 2.3.

## ELMO models (Applied in the CoNLL 2018 shared task)

During the CoNLL 2018 shared task, we trained ELMO embeddings using the data set provided by the shared task organizers.
- English, French, Japanese, Chinese and Korean [download 1.7G](https://mycore.core-cloud.net/index.php/s/OKCV5HDllwdAAi6/download):

## Papers

```
@inproceedings{lim:hal-01856178,
  TITLE = {{Multilingual Dependency Parsing for Low-Resource Languages: Case Studies on North Saami and Komi-Zyrian}},
  AUTHOR = {Lim, KyungTae and Partanen, Niko and Poibeau, Thierry},
  URL = {https://hal.archives-ouvertes.fr/hal-01856178},
  BOOKTITLE = {{Language Resource and Evaluation Conference}},
  ADDRESS = {Miyazaki, Japan},
  ORGANIZATION = {{ELRA}},
  YEAR = {2018},
  MONTH = May,
  KEYWORDS = {dependency parsing ; word embeddings ; Uralic languages},
  PDF = {https://hal.archives-ouvertes.fr/hal-01856178/file/600.pdf},
  HAL_ID = {hal-01856178},
  HAL_VERSION = {v1},
}


@InProceedings{lim-EtAl:2018:K18-2,
  author    = {Lim, KyungTae  and  Park, Cheoneum  and  Lee, Changki  and  Poibeau, Thierry},
  title     = {{SEx} {BiST}: A Multi-Source Trainable Parser with Deep Contextualized Lexical Representations},
  booktitle = {Proceedings of the {CoNLL} 2018 Shared Task: Multilingual Parsing from Raw Text to Universal Dependencies},
  month     = {October},
  year      = {2018},
  address   = {Brussels, Belgium},
  publisher = {Association for Computational Linguistics},
  pages     = {143--152},
  abstract  = {We describe the SEx BiST parser (Semantically EXtended Bi-LSTM parser) developed at Lattice for the CoNLL 2018 Shared Task (Multilingual Parsing from Raw Text to Universal Dependencies). The main characteristic of our work is the encoding of three different modes of contextual information for parsing: (i) Treebank feature representations, (ii) Multilingual word representations, (iii) ELMo representations obtained via unsupervised learning from external resources. Our parser performed well in the official end-to-end evaluation (73.02 LAS -- 4th/26 teams, and 78.72 UAS -- 2nd/26); remarkably, we achieved the best UAS scores on all the English corpora by applying the three suggested feature representations. Finally, we were also ranked 1st at the optional event extraction task, part of the 2018 Extrinsic Parser Evaluation campaign.},
  url       = {http://www.aclweb.org/anthology/K18-2014}
}
```

**TODO:** Add list of papers and posters with links
