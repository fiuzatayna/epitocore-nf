process GETNCBIPATHS {
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
