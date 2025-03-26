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