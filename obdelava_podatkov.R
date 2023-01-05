# UVOZ
library(readr)

uvoz <- function(podatki){
  tabela <- t(read_csv(podatki, col_names = FALSE)) # transponiramo, tako da vsak stolpec predstavlja podatke za drug n
    return(tabela)
}

# n = 1,2,...,40
n_od_1_do_40_vsota <- uvoz("podatki/n_od_1_do_40_vsota.csv")
n_od_1_do_40_vsota_dvodelni_graf <- uvoz("podatki/n_od_1_do_40_vsota_dvodelni_graf.csv")

n_od_1_do_40_cas <- uvoz("podatki/n_od_1_do_40_cas.csv")
n_od_1_do_40_cas_dvodelni_graf <- uvoz("podatki/n_od_1_do_40_cas_dvodelni_graf.csv")

# primerjava po normah
# n = 1,2,...,10
n_od_1_do_10_primerjava_norme_1 <- uvoz("podatki/n_od_1_do_10_primerjava_norme_1.csv")
n_od_1_do_10_primerjava_norme_2 <- uvoz("podatki/n_od_1_do_10_primerjava_norme_2.csv")
n_od_1_do_10_primerjava_norme_Inf <- uvoz("podatki/n_od_1_do_10_primerjava_norme_Inf.csv")

# primerjava glede na območje generiranja točk
# n = 1,2,...,10
n_od_1_do_10_primerjava_liki_kvadrat <- uvoz("podatki/n_od_1_do_10_primerjava_liki_kvadrat.csv")
n_od_1_do_10_primerjava_liki_krog <- uvoz("podatki/n_od_1_do_10_primerjava_liki_krog.csv")
n_od_1_do_10_primerjava_liki_enakostranicni_trikotnik <- uvoz("podatki/n_od_1_do_10_primerjava_liki_enakostranicni_trikotnik.csv")

n_od_1_do_10_primerjava_liki_dvodelni_graf_kvadrat <- uvoz("podatki/n_od_1_do_10_primerjava_liki_dvodelni_graf_kvadrat.csv")
n_od_1_do_10_primerjava_liki_dvodelni_graf_krog <- uvoz("podatki/n_od_1_do_10_primerjava_liki_dvodelni_graf_krog.csv")
n_od_1_do_10_primerjava_liki_dvodelni_graf_enakostranicni_trikotnik <- uvoz("podatki/n_od_1_do_10_primerjava_liki_dvodelni_graf_enakostranicni_trikotnik.csv")
