# Proposal for new repositories

## jsmol-lab

jsmol-lab would be a custom implementation of the jsmol web app. It would contain the Jmol code in a child jsmol directory, but the jsmol.html web app would be in the repository directory. The web app would have an embedded console to encourage the user to use Jmol commands. Generally the user would clone the repository, open the web app page, and serve it with Apache. The user could then view, analyze, and create models. The repository would also contain some starter models and tutorials on how to use it for useful chemistry.

## 

## gamess-lab


## Linux tutorials

To introduce Chem 122 students to Linux in a chemical context, start with:

- `cal` (for fun)
- `head` and `tail`
- write and save files containing data
- run JSME web app to draw structures
- write and save scripts to be loaded by JSMol
- `grep`
- `curl`
- 

Scrape the mass spectral data from here:
    http://www.hmdb.ca/spectra/ms_ms/206901

Scrape normal concentrations from here:
    http://www.hmdb.ca/metabolites/HMDB00684
    
To look up CID of a compound by name

    curl https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/kynurenicacid/cids/txt
    
To check names of a compound by CID

    curl https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/3845/synonyms/json

To look up a property of a compound by CID

    curl https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/8549/property/MolecularWeight/txt;

To grab mol file from pubchem with cid

    curl https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/846/sdf > kynurenine.sdf

