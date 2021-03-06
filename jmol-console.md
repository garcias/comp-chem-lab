# Jmol console tutorial

## `load`

The versatile `load` command can import model data using a variety of methods. Most read from a file on the server, but some can retrieve models from a database (PubChem, RCSD, AMCSD, COD, PDB), or even call a conversion service like NIH Cactus. 

Jmol typically infers the format from the data set itself. Common file formats include MOL file (`.mol`), GAMESS input (`.inp`) and output (`.out`), XMOL (`.xyz`), CIF (`.cif`), MOPAC output (`.mopout`), Protein Data Bank (`.pdb`), Java Molecular Editor (`.jme`), and Chemical Markup Language (`.cml`).

Load a model of water from a MOL file, containing coordinates and bond connectivity table.

    load H2O.mol

Load all models from a GAMESS output file, containing the coordinates, bonds, and molecular orbitals of ethane. If it was a Hessian calculation, also loads normal mode vibrations and frequencies, which can be animated.

    load ethane-1.out

To retrieve a model from PubChem, prefix its PubChem name or id with a colon (`:`). For RCSB, prefix its PDB id with equals (`=`). The following commands load caffeine (from PubChem), paracetamol (PubChem 1983), and streptavidin (PDB 1STP).

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

To show a reference label for each atom, use `label on`. By default, the label is of the form "*{chemical symbol}{number}* #*{number}*", which is a bit unwieldy. Instead `label %a` will give only chemical symbol and atom number. And sometimes they don't show up very well, so use the `color` and labeloffset commands with the `labels` option to change their color and offsets.

```
    labels on
    labels %a
    color labels black
    set labeloffset 15 15
```

## `measure`

Measurements in Jmol are sensitive to the number of atoms you specify. `measure` requires atom expressions to be in parentheses.

```Java
    measure (H1) (C7)             // bond length between C7 and C8
    measure (H1) (C7) (C8)        // bond angle with C8 as central
    measure (H1) (C7) (C8) (H12)  // torsion angle along C7-C8 axis
                                  // between planes H1-C7-C8 and C7-C8-H12
    measure list                  // prints list of measurements to output
```


## `select`

When editing or studying a molecule, you may need to mark a subset of atoms for further action. Use `select` along with an **atom expression**. An atom expression may contain keywords such as `all`, `none`, `bonded`, and others.

To target atoms by element, specify the element name. Alternatively, you can use the elemental symbol preceded by an underscore, with mass number to indicate isotope:

```Java
    select carbon     // selects all C atoms
    select deuterium  // selects all D atoms
    select _31P       // selects all P-31 atoms
```

To target atoms by property, specify a logical test involving the property. Common properties are `atomno`, `elemno`, `atomx`, `bondcount`, `mass`, `shape`, `valence`:

```Java
    select atomno = [1,4]  // select two atoms, numbered 1 and 4
    select elemno < 7      // select all atoms from H to C
    select bondcount = 3   // select all atoms with three bonds, including sp2 C and sp3 N
    select mass < 15       // select atoms lighter than 15, including nitrogen-14, carbon-14, carbon-12, etc.
    select shape = "trigonal planar"      // select sp2-hybridized atoms
    select valence == 3    // select B, N, P, *etc*
```

`select add` and `select remove` allow you to extend or restrict an existing selection.

```Java
    select _C; select add _H     // selects all C and H atoms
    select _C; select remove C3  // selects all C except for C3
```

By default, each atom is assigned a unique label of the form *{chemical symbol}{atom number}*, e.g. `C5`. To target a specific atom, use its label.

```Java
    select C3, C4, C8  // selects only those carbon atoms
```

`define` allows you to designate a group to use in selection.

```Java
    define ~a C8,C9      // define C8 and C9 as an entity
    select * and not ~a  // select all atoms except for C8 and C9
```

## Manipulating structures

Once atoms are selected, you can change their position, bonding, or appearance.

`connect` creates bonds between atoms in a selection.

```Java
    select C8,C9               // select carbons 8 and 9
    connect (selected) single  // add single bond between selected atoms
    connect single             // selected is implied otherwise
    connect {C8} {C9}          // same effect but without selection
    connect delete             // remove the bond
```

`color` acts on the entire selection, including bonds

```Java
    color purple  # color atoms and bond purple
```

`rotateselected` allows you to apply `rotate` operations to just the selection, which can be useful for exploring conformations.

```Java
    rotate {C8} {C9} 30                // rotate entire structure about the C8-C9 bond by 30 degrees
    rotateselected {C8} {C9} 30        // rotate selected atoms only about the C8-C9 bond by 30
    rotateselected {C8} {C9} spin 100  // spin the selected atoms about the C8-C9 bond
```


# `spin`

First make sure center the coordinate system with `centerat average`. 

Specify the axis of rotation and optionally the rate of rotation. A rate of 240 is roughly a half turn per second.

```Java
    spin x 120
    spin off
```

# `modelKitMode`

Initiates mode in which clicking on an atom changes it to whatever atom is specified by `set picking`.


# Some useful scripts

- On startup, turn on selection halos, set labels to {element name}#, and color labels black.

  ```Java
      selectionHalos; labels %a; color labels black; set labeloffset 15 15
      background [xddd8c5]  // soda solarized
  ```

