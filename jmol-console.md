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

Write can export a model information in different ways: as chemically meaningful data, a 3D scene, or a rendered image. 

You can write to a variety of chemical information formats to the console output. Use the `console clear` command before writing, so you don't get other output mixed in. The following exports the model as a MOL file, Cartesian coordinates, Chemical Markup Language, JSON, and Structured Data File. 

    console clear
    write mol
    write xyz
    write cml
    write json
    write sdf

Once the data are written to output, you can copy and paste to desired tool or file. To save directly to a local file, add a file name afterward in quotes.

    write cml "caffeine.cml"
    
For a 3D scene, specify the desired format. Jmol supports Maya ASCII, POV-Ray, and VRML, among others.

    write maya caffeine.ma
    write povray caffeine.pov
    write vrml caffeine.vrml

Finally, Jmol can render the model as an image in common formats, such as png, pdf, and jpg. Use the keyword `image`, the width and height in pixels, and the desired format. If you leave out the width and height, Jmol will use the currently displayed resolution. Jmol can also infer the format from the file-name extension, as in the last example.

    write image 600 600 png caffeine.png
    write image pdf caffeine.pdf
    write caffeine.jpg 


## `minimize`

In the process of building a molecule, you might find that you stretched a bond too far, distorted bond angles, or the conformation is too compact. The `minimize` command will use an force-field method to approximately optimize the structure.

## `set picking`

Set picking allows you to control what mouse clicks do in the model.
