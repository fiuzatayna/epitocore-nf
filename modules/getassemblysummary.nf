process GETASSEMBLYSUMMARY{
    output:
    path 'assembly_summary.txt'

    script:
    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt -O assembly_summary.txt
    """
}