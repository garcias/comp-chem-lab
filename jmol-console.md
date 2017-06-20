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

Write can export the current selection in different ways: as chemically meaningful data, a 3D scene, or a rendered image. 

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

If there are multiple models, `write` will export all of them. This works for SDF but not for Mol file. To export just one model, select all the atoms in that model and then write.

    select */8
    write mol

Alternatively, write all the models to SDF and then use OBabel's `-f` option to convert only the desired model.

## `minimize`

In the process of building a molecule, you might find that you stretched a bond too far, distorted bond angles, or the conformation is too compact. The `minimize` command will use an force-field method to approximately optimize the structure.

## `set picking`

Set picking allows you to control what mouse clicks do in the model.

## `selectionhalos`

For convenience in working with selections, you can turn selection halos `on` or `off`.

## `label`

To show a reference label for each atom, use `label on`. By default, the label is of the form "*{chemical symbol}{number}* #*{number}*", which is a bit unwieldy. Instead `label %a` will give only chemical symbol and atom number. And sometimes they don't show up very well, so use the `color` command with the `labels` option to change their color.

```
    labels on
    labels %a
    color labels black
```

## `select`

When editing or studying a molecule, you may need to mark a subset of atoms for further action. Use `select` along with an **atom expression**. An atom expression may contain keywords such as `all`, `none`, `bonded`, and others.

To target atoms by element, specify the element name. Alternatively, you can use the elemental symbol preceded by an underscore, with mass number to indicate isotope:

- `select carbon`: selects all C atoms
- `select deuterium`: selects all D atoms
- `select _31P`: selects all P-31 atoms

To target atoms by property, specify a logical test involving the property. Common properties are `atomno`, `elemno`, `atomx`, `bondcount`, `mass`, `shape`, `valence`:

- `select atomno = [1,4]`: select two atoms, numbered 1 and 4
- `select elemno < 7`: select all atoms from H to C
- `select bondcount = 3`: select all atoms with three bonds, including sp<sup>2</sup> C and sp<sup>3</sup> N.
- `select mass < 15`: select all atoms lighter than 15, including nitrogen-14, carbon-14, carbon-12, etc.
- `select shape = "trigonal planar"`: select all sp<sup>2</sup>-hybridized atoms
- `select valence == 3`: select B, N, P, *etc*

To extend or restrict an existing selection, use `select add` and `select remove`.

- `select _C; select add _H`: selects all C and H atoms
- `select _C; select remove C3`: selects all C except for C3

By default, each atom is assigned a unique label of the form *{chemical symbol}{atom number}*, e.g. `C5`. To target a specific atom, use its label.

- `select C3, C4, C8`: selects only those carbon atoms

## Manipulating structures

Once atoms are selected, you can change their position, bonding, or appearance.

- `select C8 or C9; connect single`: create a single bond between carbons 8 and 9
- `color purple`: color atoms and bond purple
- `select C8 or C9; connect delete`: remove the bond
- `define ~a C8,C9`: define C8 and C9 as an entity
- `select * and not ~a`: select all atoms except for C8 and C9
- `rotateselected {C8} {C9} 30`: rotate molecule about the C8-C9 bond by 30 degrees
- 