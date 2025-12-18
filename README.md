Presentation at Coldigiocco summer school

```r
git submodule update --init  
```

you need a working version of TeX and pandoc. 

you will need the latest versions of gtseries, the astroanalytic package for analytical spectra of eccentricity, precession and obliquity, and the gtseries package

```r
ucl_host <- "forge.uclouvain.be"

# Install palinsol and astronalytic
remotes::install_gitlab("mcrucifix/palinsol", host = ucl_host)
remotes::install_gitlab("mcrucifix/astronalytic", host = ucl_host)

# Install the latest version of gtseries
remotes::install_gitlab("mcrucifix/gtseries", host = ucl_host)
```

Zeebe and Laskar solutions (in R) downloaded from their respective websites (and, for Zeebe, time resolution degraded by taking 1 out of every 50 entries). That directory still needs some clean-up. They are note covered by the LICENSE. 


