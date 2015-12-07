FROM rocker/rstudio
MAINTAINER "Jacqueline Buros Novik" jackinovik@gmail.com

Rscript -e "install.packages(c('inline', 'Rcpp', 'coda', 'BH', 'RcppEigen', 'RInside', 'RUnit', 'ggplot2', 'gridExtra'), repos='http://cran.rstudio.com')"

R -q -e "options(repos = getCRANmirrors()[1,'URL']); library(devtools); install_github('Rcpp', 'Rcppcore')"

cd tmp

git clone --recursive https://github.com/stan-dev/rstan.git
cd rstan
git config -f .gitmodules submodule.stan.branch develop
git config -f .gitmodules submodule.StanHeaders/inst/include/mathlib.branch develop
git submodule update --remote
R CMD build StanHeaders/
R CMD INSTALL `find StanHeaders*.tar.gz`

cd rstan 
make build
make install

