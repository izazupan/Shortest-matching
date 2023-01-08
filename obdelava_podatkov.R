# UVOZ
library(readr)

uvoz <- function(podatki){
  tabela <- read_csv(podatki, col_names = FALSE)
    return(tabela)
}

# n = 1,2,...,40
n_od_1_do_40_vsota <- uvoz("podatki/n_od_1_do_40_vsota.csv")
n_od_1_do_40_vsota_dvodelni_graf <- uvoz("podatki/n_od_1_do_40_vsota_dvodelni_graf.csv")

n_od_1_do_40_cas <- uvoz("podatki/n_od_1_do_40_cas.csv")
n_od_1_do_40_cas_dvodelni_graf <- uvoz("podatki/n_od_1_do_40_cas_dvodelni_graf.csv")

# n = 3,4,5
n_od_3_do_5_vsota <- uvoz("faks/3. letnik/FP/Shortest-matching/podatki/n_od_3_do_5_vsota.csv")

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

# ANALIZA PODATKOV
# primerjava pričakovane vrednosti za različne n
pric_vred <- rowMeans(n_od_1_do_40_vsota)
pricakovana <- data.frame(n = 1:40,
                          pricakovana_vred = pric_vred)

plot(pricakovana$n, pricakovana$pricakovana_vred,
     xlab="n", ylab="",
     main="Pričakovana vrednost najcenejšega prirejanja")
abline(lm(pricakovana_vred~n,data=pricakovana),col='red')

# pričakovana vrednost najcenejšega prirejanja, 500 ponovitev
n3 <- as.numeric(as.vector(n_od_3_do_5_vsota[1,]))
n4 <- as.numeric(as.vector(n_od_3_do_5_vsota[2,]))
n5 <- as.numeric(as.vector(n_od_3_do_5_vsota[3,]))

hist(n3, main="Histogram vrednosti najcenejšega prirejanja, \nn=3, 500 ponovitev",
     xlab="Skupna cena povezav v najcenejšem prirejanju", ylab="Pogostost")
abline(v = mean(n3), col = "red", lwd = 3)
text(x = 1.25, y = 140,
     paste("Pričakovana vrednost = \n=", mean(n3)), col = "red", cex = 0.6)

hist(n4, main="Histogram vrednosti najcenejšega prirejanja, \nn=4, 500 ponovitev",
     xlab="Skupna cena povezav v najcenejšem prirejanju", ylab="Pogostost")
abline(v = mean(n4), col = "blue", lwd = 3)
text(x = 1.4, y = 65,
     paste("Pričakovana vrednost = \n=", mean(n4)), col = "blue", cex = 0.6)

hist(n5, main="Histogram vrednosti najcenejšega prirejanja, \nn=5, 500 ponovitev",
     xlab="Skupna cena povezav v najcenejšem prirejanju", ylab="Pogostost")
abline(v = mean(n5), col = "darkgreen", lwd = 3)
text(x = 0.25, y = 110,
     paste("Pričakovana vrednost = \n=", mean(n5)), col = "darkgreen", cex = 0.6)

# primerjava za različne n, dvodelni graf
pric_vred2 <- rowMeans(n_od_1_do_40_vsota_dvodelni_graf)
pricakovana2 <- data.frame(n = 1:40,
                          pricakovana_vred = pric_vred2)

plot(pricakovana2$n, pricakovana2$pricakovana_vred,
     xlab="n", ylab="",
     main="Pričakovana vrednost najcenejšega prirejanja \nv dvodelnem grafu")
abline(lm(pricakovana_vred~n,data=pricakovana2),col='blue')

### pričakovana vrednost najcenejšega prirejanja se povečuje z n

# primerjava med polnim in dvodelnim grafom
plot(pricakovana$n, pricakovana$pricakovana_vred,
     xlab="n", ylab="", main="Primerjava cene najcenejšega prirejanja \nv polnem in v dvodelnem grafu",
     ylim=c(0.4,3.4), pch=1)
points(pricakovana2$n, pricakovana2$pricakovana_vred, pch=18)
legend("topleft", legend=c("poln graf", "dvodelni graf"),
       pch=c(1, 18), cex=0.8)

### pričakovana vrednost najcenejšega prirejanja je večja v dvodelnem grafu

# časovna odvisnost
cas <- rowMeans(n_od_1_do_40_cas)
cas_odv <- data.frame(n = 1:40,
                      casovna_odv = cas)
x <- cas_odv$n
y <- cas_odv$casovna_odv
plot(x, y, xlab="n", ylab="t",
     main="Časovna odvisnost najcenejšega prirejanja")

# fit <- lm(y ~ x + I(x^2) + I(x^3)) # polinomska regresija
# pred <- predict(fit)
# ix <- sort(x, index.return=T)$ix
# lines(x[ix], pred[ix], col='darkgreen', lwd=2)

fit2 <- lm(log(y) ~ x) # eksponentna regresija
a <- as.numeric(coef(fit2)[1])
b <- as.numeric(coef(fit2)[2])
c <- exp(a+b*x)
lines(x, c, col='darkred', lwd=2)

# primerjava časovne odvisnosti med polnim in dvodelnim grafom
cas2 <- rowMeans(n_od_1_do_40_cas_dvodelni_graf)
cas_odv2 <- data.frame(n = 1:40,
                      casovna_odv = cas2)

plot(cas_odv$n, cas_odv$casovna_odv,
     xlab="n", ylab="t", main="Primerjava časovne odvisnosti",
     ylim=c(0,3.2), pch=1)
points(cas_odv2$n, cas_odv2$casovna_odv, pch=18)
legend("topleft", legend=c("poln graf", "dvodelni graf"),
       pch=c(1, 18), cex=0.8)

# primerjava po območjih izbire točk
kvadrat <- rowMeans(n_od_1_do_10_primerjava_liki_kvadrat)
kvadrat_tabela <- data.frame(n=1:10,
                             pricak_vred = kvadrat)

krog <- rowMeans(n_od_1_do_10_primerjava_liki_krog)
krog_tabela <- data.frame(n=1:10,
                          pricak_vred = krog)

trikot <- rowMeans(n_od_1_do_10_primerjava_liki_enakostranicni_trikotnik)
trikot_tabela <- data.frame(n=1:10,
                            pricak_vred = trikot)

plot(kvadrat_tabela$n, kvadrat_tabela$pricak_vred,
     xlab="n", ylab="", main="Pričakovana vrednost najcenejšega prirejanja \nglede na izbiro točk v polnem grafu",
     ylim=c(0,2), pch=22)
points(krog_tabela$n, krog_tabela$pricak_vred, pch=21)
points(trikot_tabela$n, trikot_tabela$pricak_vred, pch=24)
legend("bottomright", legend=c("enotski kvadrat", "enotski krog", "enakostranični trikotnik"),
       pch=c(22, 21, 24), cex=0.5)

# primerjava po območjih za dvodelni graf
kvadrat2 <- rowMeans(n_od_1_do_10_primerjava_liki_dvodelni_graf_kvadrat)
kvadrat_tabela2 <- data.frame(n=1:10,
                             pricak_vred = kvadrat2)

krog2 <- rowMeans(n_od_1_do_10_primerjava_liki_dvodelni_graf_krog)
krog_tabela2 <- data.frame(n=1:10,
                          pricak_vred = krog2)

trikot2 <- rowMeans(n_od_1_do_10_primerjava_liki_dvodelni_graf_enakostranicni_trikotnik)
trikot_tabela2 <- data.frame(n=1:10,
                            pricak_vred = trikot2)

plot(kvadrat_tabela2$n, kvadrat_tabela2$pricak_vred,
     xlab="n", ylab="", main="Pričakovana vrednost najcenejšega prirejanja \nglede na izbiro točk v dvodelnem grafu",
     ylim=c(0,3), pch=22)
points(krog_tabela2$n, krog_tabela2$pricak_vred, pch=21)
points(trikot_tabela2$n, trikot_tabela2$pricak_vred, pch=24)
legend("bottomright", legend=c("enotski kvadrat", "enotski krog", "enakostranični trikotnik"),
       pch=c(22, 21, 24), cex=0.5)

### prirejanje bo imelo najmanjšo vrednost, ko točke izberemo enakomerno v enakostraničnem trikotniku,
### največjo pa, ko jih izberemo v enotskem krogu
### enako za polni in dvodelni graf

# primerjava glede na izbiro norme, za n=1,...,10, izbira točk v enotskem kvadratu
norma1 <- rowMeans(n_od_1_do_10_primerjava_norme_1)
norma1_tabela <- data.frame(n=1:10,
                            pricak_vred = norma1)

norma2 <- rowMeans(n_od_1_do_10_primerjava_norme_2)
norma2_tabela <- data.frame(n=1:10,
                            pricak_vred = norma2)

normaInf <- rowMeans(n_od_1_do_10_primerjava_norme_Inf)
normaInf_tabela <- data.frame(n=1:10,
                            pricak_vred = normaInf)

plot(norma1_tabela$n, norma1_tabela$pricak_vred,
     xlab="n", ylab="", main="Pričakovana vrednost najcenejšega prirejanja \nglede na izbiro norme",
     ylim=c(0,1.6), pch=4)
points(norma2_tabela$n, norma2_tabela$pricak_vred, pch=5)
points(normaInf_tabela$n, normaInf_tabela$pricak_vred, pch=6)
legend("bottomright", legend=c("1-norma", "2-norma", "neskončna norma"),
       pch=c(4,5,6), cex=0.6)

 ### vrednost najcenejšega prirejanja bo najnižja, ko uporabimo neskončno normo      