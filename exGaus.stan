

data {

int<lower=0> nsubjects;
int<lower=0> nobs;
int<lower=0> Subject[nobs];
vector[nobs] y;
real k;

}

parameters {

real mu; 
real<lower=0> sigma;
real<lower=0> nu;
real<lower=0> sigma_e;
vector[nsubjects] G_raw;
vector<lower=0,upper=1>[nsubjects] E_raw;

}

transformed parameters {

real lsigma;
real lnu; 
vector[nsubjects] G;
vector[nsubjects] E;
lsigma = log(sigma);
lnu = log(nu);
G = mu + G_raw*sigma;
E = -nu*log(1-E_raw);

}

model {

mu ~normal(0,k);
sigma ~ lognormal(-1.5,k);
nu ~ lognormal(-1,k);
sigma_e ~ lognormal(-1.5,k);

for (i in 1:nsubjects)
{
  G_raw[i] ~ std_normal();
}

for (i in 1:nobs)
{
y[i] ~ normal(G[Subject[i]] + E[Subject[i]], sigma_e); 
}

}





