# MremoteImport
Powershell script to create a mremote import file from a list of hosts.

This function uses the exiting mremotetemplate file, list of hosts file and creates mremote import csv file. Tested with mremote version 1.76.20 (2019-04-12).

This imports all hosts to the folder specified inside the "input/hosts.csv" file and inherits the authentication parameters from the parent folder.

# USAGE
import-csv "input/hosts.csv" | mremoteimport -MremoteTemplateFile "\input\mremotetemplate\meremotetemplate.csv" -MremoteImportFile "\output\meremoteimport.csv"