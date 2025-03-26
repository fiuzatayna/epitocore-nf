# Epitocore-Nf
> an attempt to convert epitocore pipeline into a nextflow one - part 1 is being done as a project assignment 

## Introduction

Epitocore is a bioinformatics pipeline that provides surfaceome prediction of proteins from related strains, defines core proteins within those, calculate their immunogenicity, predicts epitopes for a given set of MHC alleles defined by the user, and then reports if epitopes are located extracellularly and if they are conserved among the core homologs. 

This is an attempt to convert that pipeline to a NextFlow format.

## Usage

### Basic Usage

```bash
nextflow run main.nf
```

### Change parameters

```bash
nextflow run main.nf --params.species [species name under ncbi assembly] --params.gram [gram positive or negative or archea]
```

## Credits

fiuzatayna/epitocore-nf was originally written by fiuzatayna.

## Citations

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).