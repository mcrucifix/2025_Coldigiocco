require(palinsol)
require(gtseries)
develop(Bre73$epi, start = 50000e3, end =0, deltat=1e3)

La2010a <- read.table('La2010a_alkhqp3.dat', col.names=c('time','a','l','k','h','q','p'))

keep <- seq(10001)

kh <- ts(rev(La2010a$k[keep] + 1i * La2010a$h[keep]), start = -50000e3, end=0, deltat=5e3)

hann = sin(seq(0, length(kh)-1)*pi / length(kh))^2

Bre73ts <- develop(Bre73$epi, start = -50000e3, end =0, deltat=5e3, dfunction=cis) 

## Eccentricities
ELa10a <- Mod(kh)
EBre73ts <- Mod(Bre73ts)

## G-plots

Per_La10a <- periodogram(kh*hann)
Per_Bre73ts <- periodogram(Bre73ts*hann)

Per_ELa10a <- periodogram(ELa10a*hann)
Per_EBre73ts <- periodogram(EBre73ts*hann)

# correction because mistake in gtseries - to be fixed using 
# packageVersion("gtseries")
Per_La10a$Power <- Per_La10a$Power * length(kh) * length(kh)
Per_La10a$Freq <-  Per_La10a$Freq * 2*pi
Per_Bre73ts$Power <- Per_Bre73ts$Power * length(kh) * length(kh)
Per_Bre73ts$Freq <-  Per_Bre73ts$Freq * 2*pi

Per_ELa10a$Power <-   Per_ELa10a$Power * length(kh) * length(kh)
Per_ELa10a$Freq <-    Per_ELa10a$Freq * 2*pi
Per_EBre73ts$Power <- Per_EBre73ts$Power * length(kh) * length(kh)
Per_EBre73ts$Freq <-  Per_EBre73ts$Freq * 2*pi



Mfft_La10a <- mfft(kh, nfreq=80, correction=2)
Mfft_Bre73ts <- mfft(Bre73ts, nfreq=30, correction=2)

Mfft_ELa10a <- mfft(ELa10a, nfreq=80, correction=2)
Mfft_EBre73ts <- mfft(EBre73ts, nfreq=30, correction=2)



pdf('EPi_spectrum_plot.pdf')
par(mfrow=c(2,1))

plot(Per_La10a, main = "La10a", xlab="Ang. Velocity", ylab = "Power")
lines(abs(Mfft_La10a$Freq) , Mfft_La10a$Amp^2, col='red', type='h')

plot(Per_Bre73ts, main = "Bretagnon 1973", xlab = "Ang. Velocity", ylab = "Power")
lines(abs(Mfft_Bre73ts$Freq) , Mfft_Bre73ts$Amp^2, col='red', type='h')
lines(Bre73$epi$Freq, Bre73$epi$Amp^2, col='blue', type='h')
dev.off()

pdf('E_spectrum_plot.pdf')
par(mfrow=c(2,1))

plot(Per_ELa10a, xlim=(c(5e-7, 1.e-4)), main = "La10a")
lines(abs(Mfft_ELa10a$Freq) , Mfft_ELa10a$Amp^2, col='red', type='h')
lines(Per_ELa10a$Freq, Per_ELa10a$Power, lwd=2)

EBre73s_theory <- eccentricity_spectrum(Bre73$epi)

plot(Per_EBre73ts, xlim=c(5e-7, 1.e-4), main = "Bretagnon 1973")
lines(abs(EBre73s_theory$Freq) , EBre73s_theory$Amp^2, col='lightskyblue1', type='h')
lines(abs(Mfft_EBre73ts$Freq) , Mfft_EBre73ts$Amp^2, col='red', type='h')
lines(Per_EBre73ts$Freq, EBre73ts$Power, lwd=2)

# Morlet plots

dev.off()
png('cwt_E.png', height=1024, width = 1400)
par(mfrow=c(2,1))
plot(cwt_morlet(ELa10a), main = "La10", xlab = 'time (ka)')
plot(cwt_morlet(EBre73ts), main = "Bre73", xlab = 'time (ka)')

dev.off()

