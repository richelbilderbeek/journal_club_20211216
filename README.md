# journal_club_20211216

My Journal Club presentation on Dec 16th 2021

## Presentation sketch

 * Why article
   * Could be an example of using AI for quantitative trait prediction?
   * Authors are in Uppsala

 * Problem: PCA is linear
   * Each step maximizes the variance *individually*
   * Scaling of variables (e.g. using Celsius or Fahrenheit) matters [Leznik and Tofallis, 2005]

![](ausmees_and_nettelblad_fig_3b.png)

 * Hypothesis: deep learning with autoencoders can do better

 * Introduction
   * ML
   * DL
   * Dimensionality reduction
   * PCA
     * Sensitive to rare alleles
     * Sensitive to correlated SNPs due to LD 
     * Linear
   * Fix PCA by filtering or shrinkage
   * Non-ML alternatives to PCA
     * non-centred Minimum Curvilinear Embedding (ncMCE)
       * Question: why wasn't this used?
     * t-distributed stochastic neighbor embedding (t-SNE) 
     * Uniform Manifold Approximation and Projection (UMAP)
       * Problem: the focus on preserving local topology results in a projection in which distances between larger clusters are more difficult to interpret
       * Question: does GCAE solve this problem?
    * ML alternatives to PCA for SNP data
      * restricted Boltzmann machines (RBMs) [Yelmen et al., 2021]
      * variational autoencoders [Battey et al., 2020], better than t-SNE and UMAP
    * GCAE:
      * 'The main differentiating feature between GCAE and the other DL methods mentioned is that our model makes use of convolutional layers, which take into account the sequential nature of genotype data.'
 * Methods
   * Build autoencoder: 'Autoencoders are a class of DL models that transform data to a lower-dimensional latent representation from which it is subsequently reconstructed'

![](ausmees_and_nettelblad_fig_2.jpg)

 * Methods: set up a convolutional autoencoder to learn to represent the data
   * Novelty: convolutional
   * Compare dimensionality reduction to t-SNE and UMAP
   * Compare to ADMIXTURE






![Reconstruction_autoencoders_vs_PCA.png](Reconstruction_autoencoders_vs_PCA.png)

 * Discussion
   * Could use nonlinear PCA's as well:
     * Principal Curves [Hastie and Stuetzle, 1989]
     * Kernel PCA [Schölkopf et al., 1998]

## Links

 * Article 'A deep learning framework for characterization of genotype data' by Kristiina Ausmees and Carl Nettelblad:
   * [bioRxiv](https://www.biorxiv.org/content/10.1101/2020.09.30.320994v2)
   * [Download](2020.09.30.320994v2.full.pdf), from [bioRxiv](https://www.biorxiv.org/content/10.1101/2020.09.30.320994v2)
 * [GenoCAE python package](https://github.com/richelbilderbeek/genocae/tree/Pheno)
 * [gcaer R package](https://github.com/richelbilderbeek/gcaer)

## Sources

 * [Reconstruction_autoencoders_vs_PCA.png](https://en.wikipedia.org/wiki/Autoencoder#/media/File:Reconstruction_autoencoders_vs_PCA.png)

## Refs

 * [Leznik and Tofallis, 2005] Leznik, Michael, and Chris Tofallis. "Estimating invariant principal components using diagonal regression." (2005).

 * [Hastie and Stuetzle, 1989] Hastie, Trevor, and Werner Stuetzle. "Principal curves." Journal of the American Statistical Association 84.406 (1989): 502-516.

 * [Schölkopf et al., 1998] Schölkopf, Bernhard, Alexander Smola, and Klaus-Robert Müller. "Nonlinear component analysis as a kernel eigenvalue problem." Neural computation 10.5 (1998): 1299-1319.

