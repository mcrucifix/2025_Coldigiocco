require(gtseries)
La <- read.table('La2010a_alkhqp3.dat', skip=0, col.names=c('time','a','l','q','p','k','h'))

kh <- with(La, ts(rev(k + 1i*h), start = -249995, deltat = 5) )
N <- length(kh)

hann <- 0.5 * (1 - cos(2*pi*seq(0, N-1)/N)) 

P <- gtseries::periodogram(hann*kh)

## TODO : ENCODE A COMPLEX PERIODOGRAM
## AND ADD AN OPTION TO RETURN AMPLITUDE RATHER THAN POWER

