#!/usr/bin/env nextflow

// Copyright (C) 2017 IARC/WHO

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


params.help          		 = null
params.config         		= null
params.cpu            		= "8"
params.mem                  ="32"

log.info ""
log.info "----------------------------------------------------------------"
log.info "           Quality control with Qualimap  and MultiQC           "
log.info "----------------------------------------------------------------"
log.info "Copyright (C) IARC/WHO"
log.info "This program comes with ABSOLUTELY NO WARRANTY; for details see LICENSE"
log.info "This is free software, and you are welcome to redistribute it"
log.info "under certain conditions; see LICENSE for details."
log.info "--------------------------------------------------------"
if (params.help) {
    log.info "--------------------------------------------------------"
    log.info "                     USAGE                              "
    log.info "--------------------------------------------------------"
    log.info ""
    log.info "-------------------QC-------------------------------"
    log.info "" 
    log.info "nextflow run iarcbioinfo/Qualimap.nf   --qualimap /path/to/qualimap  --multiqc /path/to/multiqc --samtools /path/to/samtools --input_folder /path/to/bam  --output_folder /path/to/output"
    log.info ""
    log.info "Mandatory arguments:"
    log.info "--qualimap              PATH               Qualimap installation dir"
    log.info "--samtools              PATH              Samtools installation dir"
    log.info "--multiqc              PATH               MultiQC installation dir"
    log.info "--input_folder         FOLDER               Folder containing bam files"
    log.info "--output_folder        PATH                 Output directory for html and zip files (default=fastqc_ouptut)" 
    log.info ""
    log.info "Optional arguments:"
    log.info "--cpu                  INTEGER              Number of cpu to use (default=8)"
    log.info "--config               FILE                 Use custom configuration file"
    log.info "--mem                  INTEGER              Size of memory used. Default 32Gb"
    log.info ""
    log.info "Flags:"
    log.info "--help                                      Display this message"
    log.info ""
    exit 1
} 

bams = Channel.fromPath( params.input_folder+'/*.bam' )
              .ifEmpty { error "Cannot find any bam file in: ${params.input_folder}" }



process qualimap {
    tag "${bam.baseName}"
    publishDir "${params.outdir}/qualimap", mode: 'copy'

    input:
    file bam from bams

    output:
    file "${bam.baseName}_qualimap" into qualimap_results

    script:

    """
    ${params.samtools} sort ${bam} -o ${bam.baseName}.sorted.bam
   ${params.qualimap} bamqc -nt ${params.cpu} -bam ${bam} -outdir ${bam.baseName}.qualimap -outformat html
    ${params.samtools} flagstat ${bam} > ${bam.baseName}.dup.stats.txt
    """
}

process multiqc{
            cpus '1'
             
            input:
	    	 file(filehtml)  from qualimap_results
	output :
	publishDir '${params.output_folder}', mode: 'copy', pattern: '{*.html}'
            shell:
            '''
	  ${params.multiqc} -d qualimap_results
            '''
}