# Ports Extractor
___
This tool written in Bash is very useful when We are working with Nmap and We want to see and copy to the clipboard the ports opened from a grepable nmap file. 
If You have been copying and pasting a lot of ports to a Nmap scan, You won't have to anymore.

## Installations 
___
To use this tool, You'll just have to install 'xclip':

`sudo apt-get install xclip -y`

## How do I use this tool?
___
Once you've done the last steps, you can execute it by typing:

`./PortsExtraction.sh -h` - *Executing this command will show You a panel help*

The options for this tool are just 3:

- **[-e]: Extracts the ports from a file with extension '.gnmap'**

    `./PortsExtraction.sh -e pwd/file.gnmap`
- **[-x] Extracts the ports from a file with any extension, but make sure it's a grepable file from Nmap**

    `./PortsExtraction.sh -x pwd/file`

- **[-h] Shows a panel help**

    `./PortsExtraction.sh -h`
