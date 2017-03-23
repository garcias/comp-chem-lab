# comp-chem-lab

## What is this for?

Intended use is an instructor creating a team workspace on Cloud9, for students can clone. Students can therefore start with workspace that already has installed GAMESS, Jmol/JSMol, OpenBabel, and optionally Numpy/Jupyter/Pandas/R/Seaborn.

## Installing required tools

Get molvis-tools (which has JSMol), install-gamess, and cloud9-vnc.

    $ git clone https://github.com/garcias/molvis-tools.git
    $ git clone https://github.com/garcias/install-gamess.git

Get the `gamess-built` tarball built by your institution or department. Move it into the `install-gamess` directory. Provision with Cloud9file and then install GAMESS with script. Once tests are passed, remove repository to save space, if desired.

    $ cd install-gamess
    $ ./Cloud9file
    $ ./install-gamess.sh
    $ cd ..
    $ rm -rf install-gamess

## Installing optional tools

Cloud9-VNC allows you to run a lightwight desktop environment on Cloud9 with access through the browser. Clone the Cloud9-VNC repository and run the installation script.

    $ git clone https://github.com/garcias/cloud9-vnc.git
    $ cloud9-vnc/install.sh

**Jupyter** is a web app that records data analysis commands, runs them, and then displays output (text, tables, and graphs) in a nicely formatted way. It can function as an electronic notebook for Julia, Python, or R scripts (hence, *Ju-Pyt-R*).

**Pandas** is a data management library for Python and implements a DataFrame structure. Pandas DataFrames can sort, group, filter, and summarize data.

**MatPlotLib** is a plotting library for Python. It can do standard plots easily and is easy to customize, but requires extra programming for more complex, multivariate data. **Seaborn** is more appropriate for analyzing multivariable relationships, but is more difficult to customize.

To install Python Tools, run the `install-python-tools.sh` script. It installs in a virtual environment, so activate the environment before using these tools.

    $ ./install-python-tools.sh
    $ ./venv/bin/activate


## Todo

- [ ] Instructions for minimal install of Jupyter/Pandas/Seaborn
- [ ] Instructions for installing R
- [ ] Script for Miniconda install (requires > 2GB workspace)
