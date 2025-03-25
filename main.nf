#!/usr/bin/env nextflow
process GETASSEMBLYSUMMARY{
    output:
    path 'assembly_summary.txt'

    script:
    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/genbank/bacteria/assembly_summary.txt -O assembly_summary.txt
    """
}

process GETPATHS {
    input:
    val species
    path assembly_summary

    output:
    path '*_proteome.txt'

    script:
    """
    simplified_species_name=\$(echo "$species" | sed 's/ /_/g' | tr '[:punct:]' '_');
    awk -F'\t' 'BEGIN { OFS="\t" } {if ((\$8 == "$species" ) && (\$12 == "Complete Genome")) {print \$8,\$9,\$12,\$20}}' \${PWD}'/'${assembly_summary} > \${simplified_species_name}'_proteome.txt'
    """
}

process DOWNLOADPROTEOMES{
    publishDir 'intermediary/proteomes/', mode: 'copy', overwrite: false

    input:
    val assembly

    output:
    path '*_proteome.*'

    script:
    """
    ftp=\$(printf "${assembly}" | awk -F'\t' '{print \$4}');
    strain=\$(echo \${ftp} | rev | cut -d/ -f1 | rev | cut -d_ -f1,2 | tr '[:punct:]' '_');
    proteome_file=\$(echo \${ftp}'/'\$(echo \${ftp} | rev | cut -d/ -f1 | rev | sed 's/\$/_protein.faa.gz/g'));
    wget \${proteome_file} -O \${strain}'_proteome.faa.gz';
    """
}

process RUNTMHMM{
    //container 'fiuzatayna/dev-epitocore'

    publishDir 'intermediary/tmhmm', mode: 'copy', overwrite: false

    input:
    path proteome

    output:
    path "${proteome.baseName}_tmhmm.result"

    script:
    """
    gzip -dkvf $proteome;
    faa=\$(printf $proteome | sed 's;.gz;;g');
    output_file="${proteome.baseName}_tmhmm.result"
    docker run --rm -v \${PWD}:/home/ fiuzatayna/dev-epitocore perl /tmhmm-2.0c/bin/tmhmm -short \${faa} > \${output_file}
    """
}

species = "Mycobacterium tuberculosis subsp. tuberculosis"

workflow {
    assembly_summary_ch = GETASSEMBLYSUMMARY()
    assembly_summary_ch.view{ it }
    get_paths_ch = GETPATHS(species, assembly_summary_ch)
    get_paths_ch.view{ it }
    download_proteomes_ch = DOWNLOADPROTEOMES(get_paths_ch.splitText())
    runtmhmm_ch = RUNTMHMM(download_proteomes_ch)
}
