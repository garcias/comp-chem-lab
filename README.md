# comp-chem-lab

## what is this for?

Intended use is an instructor creating a team workspace on Cloud9, for students can clone. Students can therefore start with workspace that already has installed GAMESS, Jmol/JSMol, OpenBabel, and optionally Numpy/Jupyter/Pandas/R/Seaborn.

## Getting started

Get molvis-tools (which has JSMol), install-gamess, and cloud9-vnc.

    $ git clone https://github.com/garcias/molvis-tools.git
    $ git clone https://github.com/garcias/cloud9-vnc.git
    $ git clone https://github.com/garcias/install-gamess.git

Run the installation script for cloud9-vnc.

    $ cloud9-vnc/install.sh

Get the `gamess-built` tarball built by your institution or department. Move it into the `install-gamess` directory. Provision with Cloud9file and then install GAMESS with script. Once tests are passed, remove repository to save space, if desired.

    $ cd install-gamess
    $ ./Cloud9file
    $ ./install-gamess.sh
    $ cd ..
    $ rm -rf install-gamess

## Todo

- [ ] Instructions for minimal install of Jupyter/Pandas/Seaborn
- [ ] Instructions for installing R
- [ ] Script for Miniconda install (requires > 2GB workspace)
