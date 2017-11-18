source('conllu_functions.R')

epoch_plot <- plot_las("kpv_mono", "kpv_mixed", "kpv_spoken")

ggsave(filename = "las_uas_epochs.png", plot = epoch_plot)

