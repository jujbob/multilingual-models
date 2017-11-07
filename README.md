## Multilingual models

This repository contains the additional resources used in the paper "Multilingual Dependency Parsing for Low-Resource Languages: Case Studies of North Saami and Komi-Zyrian", written by KyungTae Lim, Niko Partanen and Thierry Poibeau in [LATTICE laboratory](http://www.lattice.cnrs.fr/), Paris. The additional materials include:

- Bilingual dictionaries extracted from Giellatekno infrastructure
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

Komi-Zyrian UD-style training and test corpora are hosted in [](https://github.com/langdoc/UD_Komi-Zyrian) Git-repository, in order to keep that distinct from individual papers. In this study we have used the [version 0.1](https://github.com/langdoc/UD_Komi-Zyrian/releases/tag/v0.1). We are fully aware that this version contains some errors and inconsistencies, as there were several open questions in applying UD annotation model to a new language.
