require(gtseries)
require(palinsol)
data(Bre73)


load("EData.RData")

pdf('EPi_spectrum_plot.pdf', width=8, height=4)
par(mfrow=c(1,2))
par(mar=c(3,2,2,1))

Per_La10a

plot(Per_Bre73ts, main = "Bretagnon 1973", xlab = "Ang. Velocity", ylab = "Power")
lines(abs(Mfft_Bre73ts$Freq) , Mfft_Bre73ts$Amp^2, col='red', type='h')
lines(Bre73$epi$Freq, Bre73$epi$Amp^2, col='blue', type='h')

plot(Per_La10a, main = "La10a", xlab="Ang. Velocity", ylab = "Power")
lines(abs(Mfft_La10a$Freq) , Mfft_La10a$Amp^2, col='red', type='h')



dev.off()

pdf('E_spectrum_plot.pdf', width=8, height=4)
par(mfrow=c(1,2))
par(mar=c(3,2,2,1))


plot(Per_EBre73ts, xlim=c(5e-7, 1.e-4), main = "Bretagnon 1973")
lines(abs(EBre73s_theory$Freq) , EBre73s_theory$Amp^2, col='lightskyblue1', type='h')
lines(abs(Mfft_EBre73ts$Freq) , Mfft_EBre73ts$Amp^2, col='red', type='h')
lines(Per_EBre73ts$Freq, Per_EBre73ts$Power, lwd=2)

plot(Per_ELa10a, xlim=(c(5e-7, 1.e-4)), main = "La10a")
lines(abs(Mfft_ELa10a$Freq) , Mfft_ELa10a$Amp^2, col='red', type='h')
lines(Per_ELa10a$Freq, Per_ELa10a$Power, lwd=2)



# Morlet plots

dev.off()

library(Cairo)      # or ragg
# library(showtext)   # optional: better font rendering

# Enable showtext for LaTeX-like fonts
# showtext_auto()

# Desired figure size in cm
width_cm <- 11
height_cm <- 8
dpi <- 160
FILENAME = "cwt_E.png"

# Open PNG device
CairoPNG(filename = FILENAME, 
         width = width_cm, height = height_cm,
         units = "cm", dpi = dpi, pointsize=6)

par(mfrow=c(1,1))

attr(MELa10a,"time") <- attr(MELa10a,"time") / 1.e6
plot(MELa10a, main = "La10", xlab = 'time (Ma)')
# plot(MEBre73ts, main = "Bre73", xlab = 'time (ka)')

dev.off()

