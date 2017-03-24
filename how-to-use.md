# How to use this workspace

## How to use JSMol

The file `jsmol.html` defines a web app that you can open in a browser window and visualize molecular models. To run the app in Cloud9, open `jsmol.html` and click *Run > Run with > Apache*. (The keyboard shortcut on Macs is `ctrl-cmd-return`; check *Run* menu for other operating systems.) This will cause a tab to appear in the console, saying:

> Starting Apache httpd, serving https://{{ *user name* }}.c9users.io/jsmol.html.

Click on the URL and select *Open*, which will cause your browser to open a new window dedicated to the web app.

The web app is written to load any chemical data in the file named `current`. To load new data, simply copy it over `current`, and reload the page containing the web app.


## How to use GAMESS

The command to run GAMESS is `rungms`. There are two generic input files, `hfopt.inp` and `hfvib.inp`, that you can use as templates for creating new input files. Simply `cp` one of them to a new file name (e.g., `benzene-1.inp`), open the new file, and make any desired changes.

GAMESS is designed to fail if you try to reuse a file name for a new calculation. Therefore it's best to serialize file names for a given project, (e.g., `benzene-1.inp`, `benzene-2.inp`), even if you are just repeating a calculation with the exact same parameters.


## How to use OpenBabel

The command to convert chemical data formats is `obabel`. It requires you to specify the input format using the phrase "-i*xxx*", where *xxx* are three characters indicating the format. Similarly, you must specify the output format using "-o*xxx*", where *xxx* indicate the desired output format. Common values of *xxx* are:

- `mol`: MOL file
- `inp`: GAMESS input format
- `out`: GAMESS output format
- `cml`: Chemical Markup Language
- `smi`: SMILES string 


## How to use Jupyter

Jupyter is a web app that records and runs data analysis commands, and displays output as a nicely formatted web page. It can process Julia, Python, and R code (hence, *Ju-Pyt-R*). To start the web app, first activate the virtual environment, then run the `notebook` command:

    $ ./optional/venv/bin/activate
    $ jupyter notebook --ip $IP --port $PORT --no-browser
    
It will display a URL in the output. Click on the URL and select *Open* to launch the web app in a dedicated browser window. From the web app you can create a notebook for Python or R.


## How to use Python or R interpreters

You can use the `python` or `ipython` command to start an interactive Python shell. If you have a Python script in a file named `script.py`, you can run it in Python using `python script.py`. Any output will print to the console.

If you installed R, you can use the `R` command to start an interactive R shell. If you have an R script in a file named `script.R`, you can run it in R using `Rscript script.R`.  Any output will print to the console.
