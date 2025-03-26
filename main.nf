#!/usr/bin/env nextflow
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT MODULES / SUBWORKFLOWS / FUNCTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { GETASSEMBLYSUMMARY } from './modules/getassemblysummary'
include { GETNCBIPATHS } from './modules/getncbipaths'
include { DOWNLOADPROTEOMES } from './modules/downloadproteomes'
include { RUNTMHMM } from './modules/runtmhmm'
include { DOWNLOADPSORTB } from './modules/downloadpsortb'
include { REDUCEPROTEOMES } from './modules/reduceproteomes'
include { RUNPSORTB } from './modules/runpsortb'

/*
 * pipeline input parameters
 */
params.species = "Mycobacterium tuberculosis subsp. tuberculosis"
params.gram = "positive"

log.info """\
    E P I T O C O R E - N F   P I P E L I N E
    =========================================
    species: ${params.species}
    gram: ${params.gram}
    """
    .stripIndent(true)


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
workflow {
    assembly_summary_ch = GETASSEMBLYSUMMARY()
    //assembly_summary_ch.view{ it }
    get_ncbi_paths_ch = GETNCBIPATHS(params.species, assembly_summary_ch)
    //get_ncbi_paths_ch.view{ it }
    download_proteomes_ch = DOWNLOADPROTEOMES(get_ncbi_paths_ch.splitText())
    reduced_proteomes_ch = REDUCEPROTEOMES(download_proteomes_ch)
    //runtmhmm_ch = RUNTMHMM(reduced_proteomes_ch) # runs on codespaces, but not locally
    //downloadpsortb_ch = DOWNLOADPSORTB() 
    //runpsortb_ch = RUNPSORTB(reduced_proteomes_ch,params.gram,downloadpsortb_ch) # ... runs? but takes forever??
}
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
