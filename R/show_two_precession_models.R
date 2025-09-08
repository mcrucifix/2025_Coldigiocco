# we first download data from the two models

Present <- read.table("La93_Present_Precession.dat", col.names=c("t","Psi","esinw","ecosw","varpi","obl"))
Devon   <- read.table("La93_Devon_Precession.dat", col.names=c("t","Psi","esinw","ecosw","varpi","obl"))

EPresent <- with(Present, sqrt(esinw^2 + ecosw^2))
EDevon <- with(Devon, sqrt(esinw^2 + ecosw^2))


EEPresent <- with(Present, ts(esinw + 1i * ecosw, deltat = t[2] - t[1]))
EEDevon <- with(Devon, ts(esinw + 1i * ecosw, deltat = t[2] - t[1]))

require(gtseries)

mfft(EEPresent)
mfft(EEDevon)

pdf("precession_models.pdf", width=11, height=5)
par(mfrow=c(2,1))
par(mar=c(3,2,1,1))
s <- seq(100, 1200)
with(Present, plot(t[s],esinw[s], type="l", main="Present"))
lines(Present$t[s], EPresent[s], col='red', lwd=2)

with(Devon, plot(t[s],esinw[s], type="l", main="Devon"))
lines(Devon$t[s], EDevon[s], col='red', lwd=2)


dev.off()


