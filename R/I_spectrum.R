# header
require(gtseries)
THRESHOLD <- 1e4

# sterms
s <- c(s1=-5.604, s2=-7.053, s3=-18.849, s4=-17.7614, s5=0., s6=-26.33, s7= -2.9854, s8=-0.6917, "s6+g5-g6"=-50.336)

## Read input
La <- read.table('La2010a_alkhqp3.dat', skip=0, col.names=c('time','a','l','q','p','k','h'))


kh <- with(La, ts(rev(k + 1i*h), start = -249995, deltat = 5) )
N <- length(kh)

hann <- 0.5 * (1 - cos(2*pi*seq(0, N-1)/N)) 

P <- gtseries::periodogram_complex(hann*kh)

P$Power = P$Power * N
# from rotations per kry to arcsec per year
P$Freq  = P$Freq * 3.6 * 360 

# look for sharp peaks

pdf("I_spectrum.pdf")


nn <- seq(5, N-5)
Ratio <- P$Power[nn] / sqrt(P$Power[nn-4]*P$Power[nn+4])

sharp_peaks <- which(Ratio > THRESHOLD)

print ("-<<-")
print(P$Freq[sharp_peaks])

# attribute

plot (P, xlab="Angular velocity (arcsec/yr)", ylab="Power", ylim=c(1.e-10, max(P$Power)*1000))

penalty <- 5
penalty_pow <- 2
for (i in seq(along=sharp_peaks)){
  print(i)
  hero <- which(abs(s[i] - P$Freq) < 1.e-2)
  if (length(hero >= 1)){
    true_hero <- which.max(P$Power[hero])
    hero <- hero[true_hero]
    print (P$Freq[hero])
    text(P$Freq[hero]+penalty, P$Power[hero]*(3+penalty_pow)*10,names(s)[i], col='blue')
    lines(c(P$Freq[hero]+penalty, P$Freq[hero]), 
          c(P$Power[hero]*(3+penalty_pow)*10, P$Power[hero]), col='blue')
    penalty = -penalty
    penalty_pow = -penalty_pow
  }
}


dev.off()



## TODO : ENCODE A COMPLEX PERIODOGRAM
## AND ADD AN OPTION TO RETURN AMPLITUDE RATHER THAN POWER

