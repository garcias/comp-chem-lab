# comp-chem-lab

## What is this for?

Intended use is an instructor creating a team workspace on Cloud9, for students to clone. Students can therefore start with workspace that already has installed GAMESS, Jmol/JSMol, OpenBabel, and optionally Jupyter/Pandas/R/Seaborn.

## Installing required tools

Starting in `workspace` directory, get `molvis-tools` (which has JSMol) and `install-gamess`.

    $ git clone https://github.com/garcias/molvis-tools.git
    $ git clone https://github.com/garcias/install-gamess.git

Get the `gamess-built` tarball built by your institution or department. Move it into the `install-gamess` directory. Provision with `Cloud9file` and then install GAMESS with script. Once tests are passed, remove repository to save space, if desired.

    $ cd install-gamess
    $ ./Cloud9file
    $ ./install-gamess.sh
    $ cd ..
    $ rm -rf install-gamess

## Installing optional tools

### Cloud9-VNC

Cloud9-VNC allows you to run a lightwight desktop environment on Cloud9 with access through the browser. Clone the Cloud9-VNC repository and run the installation script.

    $ git clone https://github.com/garcias/cloud9-vnc.git
    $ cloud9-vnc/install.sh

### Python data tools

**Jupyter** is a web app that records data analysis commands, runs them, and then displays output (text, tables, and graphs) in a nicely formatted way. It can function as an electronic notebook for Julia, Python, or R scripts (hence, *Ju-Pyt-R*).

**Pandas** is a data management library for Python and implements a DataFrame structure. Pandas DataFrames can sort, group, filter, and summarize data.

**Matplotlib** is a plotting library for Python. It can do standard plots easily and is simple to customize, but requires extra programming for more complex, multivariate data. **Seaborn** is more appropriate for analyzing multivariable relationships, but is more difficult to customize.

To install Python data tools, run the `install-python-tools.sh` script. It installs in a virtual environment, so activate the environment after installation to make these tools available.

    $ . optional/install-python-tools.sh
    $ . venv/bin/activate

### R

**R** is a statistical scripting language. Although it is fairly domain-specific, it boasts an unparalleled catalog of open-source packages maintained by a dedicated community of users and developers. To install R, run the following script.

    $ . optional/install-R.sh

### R kernel for Jupyter

To make R visible to Jupyter, activate the virtual environment and start R

    $ . venv/bin/activate
    $ R

Install `devtools` and several other libraries. Use `devtools` to install `IRkernel` and then run `installspec`.

```R    
    > install.packages('devtools')
    > install.packages(c('repr', 'IRdisplay', 'evaluate','crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))
    > devtools::install_github('IRkernel/IRkernel')
    > IRkernel::installspec()
```

## Todo

- [x] Instructions for minimal install of Jupyter/Pandas/Seaborn
- [x] Instructions for installing R
- [ ] Script for Miniconda install (requires > 2GB workspace)
