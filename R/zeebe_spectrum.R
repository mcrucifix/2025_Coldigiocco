ZB20 <- read.table('ZB20a.dat', col.names=c('t','ecc','inc'), skip = 1 )

require(gtseries)
E <- ts(rev(ZB20$ecc), start = -300000, deltat=0.4)

M <- cwt_morlet(E)


png('ZB20_eccentricity.png', width=1300, height=900)
plot(M)
dev.off()
