
load('Z23_morlet.RData')
require(gtseries)
FILENAME <- "ZB23_01_eccentricity.png"


# Load necessary libraries
library(Cairo)      # or ragg
# library(showtext)   # optional: better font rendering

# Enable showtext for LaTeX-like fonts
# showtext_auto()

# Desired figure size in cm
width_cm <- 12
height_cm <- 8
dpi <- 160

# Open PNG device
CairoPNG(filename = FILENAME, 
         width = width_cm, height = height_cm,
         units = "cm", dpi = dpi, pointsize=6)

par(mfrow=c(2,1))
par(mar=c(3,3,3,1))
par(las=1)
plot(M1, main = "ZB23_01", xlim=c(-3.5,0)*1e6, axes=FALSE)
axis(1, at=c(-3,-2,-1,0)*1e6, lab=c('-3000', '-2000','-1000', '0 Ma')) 
axis(2, at = c(400, 2400))
plot(M2, main = "ZB23_06", xlim=c(-3.5,0)*1e6, axes=FALSE)
axis(1, at=c(-3,-2,-1,0)*1e6, lab=c('-3000', '-2000','-1000', '0 Ma')) 
axis(2, at = c(400, 2400))
dev.off()
