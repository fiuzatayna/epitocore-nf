process RUNPSORTB{
    tag "PSORTB on ${proteome.baseName}"

    publishDir 'intermediary/psortb', mode: 'copy', overwrite: false

    input:
    path proteome
    val gram
    path psortb

    output:
    path "${proteome.baseName}_psortb.result"

    script:
    """

    faa=\$(printf $proteome | sed 's;.gz;;g');
    output_file="${proteome.baseName}_tmhmm.result";
    ./${psortb} --seq \${faa} -${gram} --output terse --verbose -r .
    """
}