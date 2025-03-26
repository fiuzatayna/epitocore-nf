process RUNTMHMM{
    tag "TMHMM on ${proteome.baseName}"

    publishDir 'intermediary/tmhmm', mode: 'copy', overwrite: false

    input:
    path proteome

    output:
    path "${proteome.baseName}_tmhmm.result"

    script:
    """
    gzip -dkvf $proteome;
    faa=\$(printf $proteome | sed 's;.gz;;g');
    output_file="${proteome.baseName}_tmhmm.result";
    #docker run --rm -v \${PWD}:/home/ fiuzatayna/dev-epitocore perl /tmhmm-2.0c/bin/tmhmm -short \${faa} > \${output_file}
    perl /tmhmm-2.0c/bin/tmhmm -short \${faa} > \${output_file};
    """
}
