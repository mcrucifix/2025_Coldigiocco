export PATH="$PATH:/opt/nvim-linux-x86_64/bin"require(palinsol)
require(gtseries)
dfvelop(Bre73$epi, start = 50000e3, end =0, deltat=1e3)

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

MELa10a <- cwt_morlet(ELa10a)
MEBre73ts <- cwt_morlet(EBre73ts)


EBre73s_theory <- eccentricity_spectrum(Bre73$epi)

save(Per_La10a, Per_Bre73ts, Mfft_La10a, Mfft_Bre73ts, Mfft_ELa10a, Mfft_EBre73ts, Per_ELa10a, Per_EBre73ts, MELa10a, MEBre73ts, EBre73s_theory,  file="EData.RData")


