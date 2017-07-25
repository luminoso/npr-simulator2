# Network Performance And Dimension simulators

This is the 2nd simulator of 4 developed at Universidade de Aveiro at the course [47064 - Network Performance and Dimension](https://www.ua.pt/uc/2306) in which is is addressed the issue of resource management in network systems and introduce the main techniques of performance analysis and design (stochastic modeling and simulation of discrete events).

The available developed simulator tool set is the following:

 * [Simulator 1](https://github.com/luminoso/npr-simulator1): Connectivity performance of multi-hop wireless networks with mobile terminals
 * [Simulator 2](https://github.com/luminoso/npr-simulator2): (this project) Impact of transmission errors in network performance
 * [Simulator 3](https://github.com/luminoso/npr-simulator3): Blocking performance of video-streaming services
 * [Simulator 4](https://github.com/luminoso/npr-simulator4): Traffic Engineering of packet switched networks

All simulators run both in Matlab or Octave.

## Simulator 2 - Impact of transmission errors in network performance

### 2.1 Data error detection and correction

On a given network link supporting the exchange of data packets, the average bit error rate (i.e., the probability of each bit being received with error due to propagation or interference factors) is *q*, with 0 < *q* ≪ 1. It is assumed that errors in different bits are statistically independent (in this case, the number of errors in a data packet is a binomial random variable). It is considered that the following bit error rate values q=10E-7, q=10E-6 and q=10E-5. In this link, data packets are sent with a 32 bytes field with appropriate information for the receiver to be able to correct 1 error and to detect 2 or more errors. So, each data packet is accepted if it has 0 or 1 error and is discarded if it has 2 or more errors.

The probability function of a binomial random variable with parameter *n* and *q* is calculated as the following:

<p align="center"> 
	<img src="https://latex.codecogs.com/svg.latex?%5Clarge%20f%28i%29%3D%5Cbinom%7Bn%7D%7Bi%7Dq%5E%7Bi%7D%281-q%29%5E%7Bn-i%7D%2C%20i%3D%200%2C1%2C2...n%5Ctextup%7B%20where%20%7D%5Cbinom%7Bn%7D%7Bi%7D%3D%5Cfrac%7Bn%21%7D%7Bi%21%28n-i%29%21%7D" alt="f(i)=\binom{n}{i}q^{i}(1-q)^{n-i}, i= 0,1,2...n\textup{ where }\binom{n}{i}=\frac{n!}{i!(n-i)!}">
</p>

And the probability of a geometric random variable with parameter *p* is:

<p align="center"> 
	<img src="https://latex.codecogs.com/svg.latex?%5Clarge%20f%28i%29%20%3D%20p%281-p%29%5E%7Bi%7D%2C%20i%20%3D%200%2C1%2C2%2C..." alt="f(i) = p(1-p)^{i}, i = 0,1,2,...">
</p>

*task1.m* contains analytical analysis for the probability of a packet being received with 0 ,1 or 2 or more errors, given a bit error rate.

All in all, the following variables are available in *task1.m*:

| Variable    | Description                          |
|-------------|--------------------------------------|
| q           | Array of bit error values to compute |
| error_rates | Error rate probability               |
| B           | Size of the packet (bits)            |

Also in the same m-file there's also analysis that computes the same values for packets sizes of an according probability and packet sizes with a size of *B* plus a geometric random value with the parameter *p*.


### 2.2 Detection rates of wireless interference

In *task2.m* the scenario we considered is a wireless link used by two stations for data communications. The link can be either in a normal state with a probability of *p* or in an interference state with a probability of *1 – p*. The two stations exchange from time to time a set of n consecutive control frames to decide if the link is in interference state. The probability of a control frame being received with one or more errors is at most *pEF1* (0.01%) in normal state and is at least *pEF2* (50%) in interference state.

Both stations determine with a 100% probability if the control frames have been received with errors. The stations decide that the link is in interference state when the n consecutive control frames are received with errors.

Using *Bayes'Law* we determined the following probabilities:

 * For several *p* probability of being in the normal state, we determined the probability of the link being in the interference state and in the normal state when one control frame is received
 * For same scenario the probability of false positives
 * For the same scenario the probability of false negatives

### 2.3 Interference with variation along the time

In the *task3.m* case it was considered a wireless link between multiple stations for data communications. The bit error rate (*ber*) introduced by the wireless link due to the variation along with time of the propagation and interference factors is approximately given by the following Markov chain:

<p align="center"> 
	<img src="https://github.com/luminoso/npr-simulator2/raw/master/doc/simulator2_markov.png" alt="Markov chain">
</p>

State transitions are in number of transitions per hour.

*Birth-dead Markov chain* was used to calculate the following values:
 * Average time in each state
 * Average bit error rate of the link
 * Average time duration (in minutes) that the link is in each state
 * If a link is considered in interference state when its bit error rate is *p* the probability of a link being in the interference state

According to probability of state 0:

<p align="center"> 
	<img src="https://latex.codecogs.com/svg.latex?%5Clarge%20%5Cpi_o%3D%5Cfrac%7B1%7D%7B1&plus;%5Csum_%7Bi%3D1%7D%5E%7B%5Cinfty%7D%5Cfrac%7B%5Clambda_0%5Clambda_1%20...%20%5Clambda_i-1%7D%7B%5Cmu_1%5Cmu_2%20...%20%5Cmu_i%7D%7D" alt="\pi_o=\frac{1}{1+\sum_{i=1}^{\infty}\frac{\lambda_0\lambda_1 ... \lambda_i-1}{\mu_1\mu_2 ... \mu_i}}">
</p>

and the steady-state probability of state *n*>0:

<p align="center"> 
	<img src="https://latex.codecogs.com/svg.latex?%5Clarge%20%5Cpi_n%3D%5C1%20&plus;%20%5Cfrac%7B%5Clambda_0%5Clambda_1%20...%20%5Clambda_%7Bn-1%7D%7D%7B%5Cmu_1%5Cmu_2%20...%20%5Cmu_n%7D.%5Cpi_0" alt=" \pi_n=\1 + \frac{\lambda_0\lambda_1 ... \lambda_{n-1}}{\mu_1\mu_2 ... \mu_n}.\pi_0">
</p>

## License
MIT
