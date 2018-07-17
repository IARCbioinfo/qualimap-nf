
# Quality control of WGS alignment data #

## Description ##

Perform quality control of WGS alignment data. 

## Dependencies ##

This pipeline is based on nextflow. As we have several nextflow pipelines, we have centralized the common information in the IARC-nf repository. Please read it carefully as it contains essential information for the installation, basic usage and configuration of nextflow and our pipelines.
samtools: see official installation here. You can avoid installing all the external software by only installing Docker (not available yet). See the IARC-nf repository for more information.)
Qualimap: see official installation here. You can avoid installing all the external software by only installing Docker (not available yet). See the IARC-nf repository for more information.)
Multiqc: see official installation here. You can avoid installing all the external software by only installing Docker (not available yet). See the IARC-nf repository for more information.)

## Input ##

**Name**        | **Description**
--------------- | -------------
--input_folder  |  Folder containing Fasta files
--output_folder |  Path to output folder

## Parameters ##

### Optional ###

**Name**          | **Example value** | **Description**
------------------| ------------------| ------------------
--qualimap        | /usr/bin/qualimap | Path to Qualimap installation directory
--samtools        | /usr/bin/samtools | Path to samtools installation directory
--multiqc         | /usr/bin/multiqc  | Path to MutliQC installation directory
--cpu             | INTEGER           | Number of cpus to be used

### Flags ###

Flags are special parameters without value.

**Name**      | **Description**
------------- | -------------
--help        | Display help

## Download test data set ##

`git clone blablabla`

## Usage ##
`nextflow run iarcbioinfo/Qualimap.nf   --qualimap /path/to/qualimap  --multiqc /path/to/multiqc --samtools /path/to/samtools --input_folder /path/to/bam  --output_folder /path/to/output`

## Output ## 


**Name**        | **Description**
--------------- | -------------
HTMLs           | An html file for each analysed BAM file, and one containing the aggregated results

