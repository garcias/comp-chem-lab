# Jmol console tutorial

## `load`

The versatile `load` command can import model data using a variety of methods. Most read from a file on the server, but some can retrieve models from a database (PubChem, RCSD, AMCSD, COD, PDB), or even call a conversion service like NIH Cactus. 

Jmol typically infers the format from the data set itself. Common file formats include MOL file (`.mol`), GAMESS input (`.inp`) and output (`.out`), XMOL (`.xyz`), CIF (`.cif`), MOPAC output (`.mopout`), Protein Data Bank (`.pdb`), Java Molecular Editor (`.jme`), and Chemical Markup Language (`.cml`).

Load a model of water from a MOL file, containing coordinates and bond connectivity table.

    load H2O.mol

Load all models from a GAMESS output file of a Hessian calculation, containing the coordinates, bonds, molecular orbitals, and normal mode vibrations of ethane.

    load ethane-1.out

To retrieve a model form PubChem, prefix its PubChem name or id with a colon (`:`). For RCSB, prefix its PDB id with equals (`=`). The following commands load caffeine (from PubChem), paracetamol (PubChem 1983), and streptavidin (PDB 1STP).

    load :caffeine
    load :1983
    load =1STP

You can send a SMILES string to NIH Cactus, which generates and sends back a 3D structure. Prefix the string with `$`. The following commands load butane, benzene, and isobutyl alcohol.

    load $CCCC
    load $C1=CC=CC=C1
    load $CC(C)CO 

## `write`

Write can export a model information in different ways: as chemically meaningful data, an rendered 3D scene, or a simple image. 


## `minimize`

In the process of building a molecule, you might find that you stretched a bond too far, distorted bond angles, or the conformation is too compact. The `minimize` command will use an force-field method to approximately optimize the structure.
