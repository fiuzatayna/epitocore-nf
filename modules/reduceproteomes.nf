process REDUCEPROTEOMES{
    input:
    path proteome

    output:
    path "reduced_${proteome.baseName}"

    script:
    """
    zcat ${proteome} | seqkit sample -p 0.05 -s 824 -o "reduced_${proteome.baseName}"
    """
}
