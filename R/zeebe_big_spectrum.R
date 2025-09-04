require(gtseries)
load('Z23_01.RData')
load('Z23_06.RData')
tstart <- Z23_01$time[1]
N <- length(Z23_01$time)
tend <- Z23_01$time[N]
deltat <- Z23_01$time[2]- Z23_01$time[1]

ecc1 <- ts(rev(Z23_01$ecc), start = tend, deltat = abs(deltat))
ecc2 <- ts(rev(ZB23_06$ecc), start = tend, deltat = abs(deltat))

M1 <- cwt_morlet(ecc1)
M2 <- cwt_morlet(ecc2)

png('ZB23_01_eccentricity.png', width=1300, height=900, pointsize=24)
par(mfrow=c(2,1))
plot(M1, main = "ZB23_01")
plot(M2, main = "ZB23_06")
dev.off()
