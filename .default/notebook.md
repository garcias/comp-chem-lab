
# Procedure

## Build ethane

Open jsmol.html and run web app. Enter ModelKit mode and start new molecule. Click on H atom to replace with methyl group. Extract MOL data, select all text, and copy.

Create new file named `ethane-1.mol`. 

    $ touch ethane-1.mol
    $ c9 open ethane-1.mol
    
Open file, paste MOL data, and save. 



Use OpenBabel to convert to coordinates in `$DATA` block for GAMESS input file. 

    $ obabel -imol ethane-1.mol -oinp

Copy the `$DATA` block from the output:

     $DATA
    string
    C1
    C      6.0     -1.0807600000    0.0002100000   -0.0003600000 
    H      1.0     -1.4694300000   -0.5258600000    0.8769900000 
    H      1.0     -1.4688400000   -0.4965600000   -0.8948800000 
    H      1.0     -1.4688500000    1.0232700000    0.0164200000 
    C      6.0      0.4332600000   -0.0000800000    0.0001400000 
    H      1.0      0.8217300000    1.0228300000    0.0171900000 
    H      1.0      0.8217400000   -0.4970000000   -0.8941200000 
    H      1.0      0.8211500000   -0.5263000000    0.8777500000 
     $END


## Optimize geometry

Make new input file from template file `hfopt.inp`.

    $ cp hfopt.inp ethane-1.inp

Open file and edit `$CONTRL` parameters. Set the method to restricted Hartree-Fock, run type to optimization, charge to 0, and multiplicity to singlet: 

- `SCFTYP=RHF`
- `RUNTYP=OPTIMIZE`
- `ICHARG=0`
- `MULT=1`

Edit `$BASIS` parameters. Set basis set to *N*-21 with 3 Gaussian functions and 1 D-type polarization function per atom.

- `GBASIS=N21`
- `NGAUSS=3`
- `NDFUNC=1`

Replace $DATA block with copied molecular data. Save file. Run GAMESS and save output to `ethane-1.out`.

    $ rungms ethane-1.inp > ethane-1.out


## Calculate vibrational modes

Use OpenBabel to convert output file to coordinates for GAMESS $DATA block.

    $ obabel -iout ethane-1.out -oinp

Copy the `$DATA` block from the output:

     $DATA
    OpenBabel
    C1
    C      6.0     -1.0807600000    0.0002100000   -0.0003600000 
    H      1.0     -1.4694300000   -0.5258600000    0.8769900000 
    H      1.0     -1.4688400000   -0.4965600000   -0.8948800000 
    H      1.0     -1.4688500000    1.0232700000    0.0164200000 
    C      6.0      0.4332600000   -0.0000800000    0.0001400000 
    H      1.0      0.8217300000    1.0228300000    0.0171900000 
    H      1.0      0.8217400000   -0.4970000000   -0.8941200000 
    H      1.0      0.8211500000   -0.5263000000    0.8777500000 
     $END

Make new input file from template file `hfvib.inp`.

    $ cp hfvib.inp ethane-2.inp

Open file and edit `$CONTRL` parameters. Set the method to restricted Hartree-Fock, run type to Hessian, charge to 0, and multiplicity to singlet: 

- `SCFTYP=RHF`
- `RUNTYP=HESSIAN`
- `ICHARG=0`
- `MULT=1`

Edit `$BASIS` parameters. Set basis set to *N*-21 with 3 Gaussian functions and 1 D-type polarization function per atom.

- `GBASIS=N21`
- `NGAUSS=3`
- `NDFUNC=1`

Edit `$FORCE` parameters. Set vibrational analysis to level 2.

- `NVIB=2`

Replace $DATA block with copied molecular data. Save file. Run GAMESS and save output to `ethane-2.out`.

    $ rungms ethane-2.inp > ethane-2.out


Open output file and search for "FREQ(CM". Copy and record frequency summary table. Open jsmol.html and run web app. Animate each mode in JSMol and describe.

      MODE FREQ(CM**-1)  SYMMETRY  RED. MASS  IR INTENS.  DESCRIPTION
         1       0.008    A        3.755864    0.000000   translation
         2       0.002    A        3.755872    0.000000   translation
         3       0.000    A        3.755873    0.000000   translation
         4      14.135    A        2.072025    0.000000   rotation, C-C perpendicular
         5      14.521    A        2.072054    0.000000   rotation, C-C perpendicular
         6      22.609    A        1.007832    0.000000   rotation, C-C parallel
         7     313.881    A        1.007825    0.000000   H-C-C-H twist
         8     921.635    A        1.057219    0.160155   C-C-H scissor, alternating
         9     921.653    A        1.057213    0.160065   C-C-H scissor, alternating
        10    1003.815    A        4.047882    0.000000   C-C stretch
        11    1351.492    A        1.449784    0.000000   C-C-H scissor, synchronous
        12    1351.503    A        1.449737    0.000000   C-C-H scissor, synchronous
        13    1571.420    A        1.171511    0.000051   CH3 umbrella, synchronous
        14    1579.797    A        1.200724    0.153531   CH3 umbrella, alternating
        15    1677.023    A        1.021090    0.000947   CH3 scissor, synchronous
        16    1677.061    A        1.021327    0.002324   CH3 scissor, synchronous
        17    1678.000    A        1.063225    0.250264   CH3 scissor, alternating
        18    1678.055    A        1.062980    0.248878   CH3 scissor, alternating
        19    3195.709    A        1.032281    1.263951   CH3 stretch, symmetric, alternating
        20    3199.892    A        1.033956    0.000002   CH3 stretch, symmetric, synchronous
        21    3240.262    A        1.101111    0.000072   CH3 stretch, antisymmetric, synchronous
        22    3240.357    A        1.101120    0.000033   CH3 stretch, antisymmetric, synchronous
        23    3267.113    A        1.101896    1.664631   CH3 stretch, antisymmetric, alternating
        24    3267.204    A        1.101903    1.664152   CH3 stretch, antisymmetric, alternating


## Verify against CCCBDB

Search CCCBDB for calculated vibrations of ethane and record path:

- *Calculated > Vibrations > Frequencies > C2H6 > ground state > HF > 3-21G\** 

Copy and record the frequency table.

    number	Symmetry	Frequency   Scaled	    Intensity	reduced mass
                        (cm-1)      (cm-1)      (km/mol)    (amu)
    1  	    A1'	        3215    	2902	    0.000	    1.035	
    2	    A1'	        1596       	1441	    0.000	    1.1316	
    3	    A1'	        995         898	        0.000	    4.5896	
    4	    A1"	        302i       	272i	    0.000	    1.0078	
    5	    A2"	        3203       	2891	    56.301	    1.0326	
    6	    A2"	        1578       	1424	    5.633	    1.2002	
    7	    E'	        3274       	2955	    122.030	    1.1014	
    8	    E'	        1689       	1525	    24.752	    1.0618	
    9	    E'	        996        	899	        13.227	    1.0592	
    10	    E"	        3250       	2934	    0.000	    1.1017	
    11	    E"	        1675       	1512	    0.000	    1.0228	
    12	    E"	        1313       	1185	    0.000	    1.4439	


# Analysis

## Correlate CCCBDB and GAMESS predictions

Sort CCCBDB modes by frequency. Look up and record degeneracy of each.

    number	Symmetry	Frequency   Intensity	red mass    degeneracy
    7	    E'	        3274       	122.030	    1.1014	    2
    10	    E"	        3250       	0.000	    1.1017	    2
    1  	    A1'	        3215    	0.000	    1.035	    1
    5	    A2"	        3203       	56.301	    1.0326	    1
    8	    E'	        1689       	24.752	    1.0618	    2
    11	    E"	        1675       	0.000	    1.0228	    2
    2	    A1'	        1596       	0.000	    1.1316	    1
    6	    A2"	        1578       	5.633	    1.2002	    1
    12	    E"	        1313       	0.000	    1.4439	    2
    9	    E'	        996        	13.227	    1.0592	    2
    3	    A1'	        995         0.000	    4.5896	    1
    4	    A1"	        302      	0.000	    1.0078	    1

Match modes between GAMESS and CCCBDB by correlating frequency, reduced mass, IR intensity. 

              mode            frequency   	  reduced mass	    IR intensity	relative
    GAMESS  CCCBDB       GAMESS  CCCBDB     GAMESS  CCCBDB      GAMESS  CCCBDB     error
    ====================================================================================
        24	     7  	3267.20	   3274	      1.10	  1.10  	1.6642	   122	   -0.21
        23	     7  	3267.11	   3274	      1.10	  1.10  	1.6646	   122	   -0.21
        22	    10  	3240.36	   3250	      1.10	  1.10  	0.0000	     0	   -0.30
        21	    10  	3240.26	   3250	      1.10	  1.10  	0.0001	     0	   -0.30
        20	     1  	3199.89	   3215	      1.03	  1.04  	0.0000	     0	   -0.47
        19	     5  	3195.71	   3203	      1.03	  1.03  	1.2640	    56	   -0.23
        18	     8  	1678.06	   1689	      1.06	  1.06  	0.2489	    25	   -0.65
        17	     8  	1678.00	   1689	      1.06	  1.06  	0.2503	    25	   -0.65
        16	    11  	1677.06	   1675	      1.02	  1.02  	0.0023	     0	    0.12
        15	    11  	1677.02	   1675	      1.02	  1.02  	0.0009	     0	    0.12
        14	     6  	1579.80	   1578	      1.20	  1.20  	0.1535	     6	    0.11
        13	     2  	1571.42	   1596	      1.17	  1.13  	0.0001	     0	   -1.54
        12	    12  	1351.50	   1313	      1.45	  1.44  	0   	     0	    2.93
        11	    12  	1351.49	   1313	      1.45	  1.44  	0	         0	    2.93
        10	     3  	1003.82	    995	      4.05	  4.59  	0	         0	    0.89
         9	     9  	 921.65	    996	      1.06	  1.06  	0.1601	    13	   -7.46
         8	     9  	 921.64	    996	      1.06	  1.06  	0.1602	    13	   -7.47
         7	     4  	 313.88	    302	      1.01	  1.01  	0	         0	    3.93
 
 Calculate relative error in frequency for each mode. For example, mode 24:

    RE = [ (GAMESS frequency) - (CCCBDB frequency) ] / (CCCBDB frequency)
       = (3267.20 - 3274) / (3274)
       = -0.21 %
 
Standard deviation of relative error: 2.9%



# Procedure

## Refine geometry optimization

Convert `ethane-2.out` to coordinates for GAMESS input using OpenBabel.

    $ obabel -iout ethane-2.out -oinp
    
Copy `$DATA` block of result.

     $DATA
    ethane-2.out
    C1
    C      6.0     -0.7713461605    0.0000020759    0.0000030237 
    C      6.0      0.7712481712   -0.0000089743   -0.0000087389 
    H      1.0     -1.1560643925   -0.2522480640   -0.9817362271 
    H      1.0     -1.1560865291   -0.7240925705    0.7093016682 
    H      1.0     -1.1561083647    0.9763193854    0.2724019189 
    H      1.0      1.1564885895   -0.9761726152   -0.2723283254 
    H      1.0      1.1564609897    0.2522492534    0.9815593603 
    H      1.0      1.1564764476    0.7240267500   -0.7091303447 
     $END

Copy `ethane-1.inp` to new input file for geometry optimization, and open.

    $ cp ethane-1.inp ethane-3.inp
    $ c9 open ethane-3.inp
    
Paste new coordinates into `$DATA` block and save file. Run GAMESS and save output to `ethane-3.out`.

    $ rungms ethane-3.inp > ethane-3.out


## Calculate vibrational modes

Convert `ethane-3.out` to coordinates for GAMESS input.

    $ obabel -iout ethane-3.out -oinp

Copy the `$DATA` block from the output:

     $DATA
    ethane-3.out
    C1
    C      6.0     -0.7713461605    0.0000020759    0.0000030237 
    C      6.0      0.7712481712   -0.0000089743   -0.0000087389 
    H      1.0     -1.1560643925   -0.2522480640   -0.9817362271 
    H      1.0     -1.1560865291   -0.7240925705    0.7093016682 
    H      1.0     -1.1561083647    0.9763193854    0.2724019189 
    H      1.0      1.1564885895   -0.9761726152   -0.2723283254 
    H      1.0      1.1564609897    0.2522492534    0.9815593603 
    H      1.0      1.1564764476    0.7240267500   -0.7091303447 
     $END

Make new input file for vibrational analysis, from `ethane-2.inp`.

    $ cp ethane-2.inp ethane-4.inp

Paste new coordinates into `$DATA` block and save file. Run GAMESS and save output to `ethane-3.out`.

    $ rungms ethane-4.inp > ethane-4.out


Open output file and search for "FREQ(CM". Copy and record frequency summary table.

      MODE FREQ(CM**-1)  SYMMETRY  RED. MASS  IR INTENS.
         1       0.009    A        3.755865    0.000000
         2       0.002    A        3.755872    0.000000
         3       0.002    A        3.755873    0.000000
         4      14.166    A        2.072027    0.000000
         5      14.551    A        2.072054    0.000000
         6      22.641    A        1.007832    0.000000
         7     313.883    A        1.007825    0.000000
         8     921.634    A        1.057219    0.160156
         9     921.653    A        1.057213    0.160066
        10    1003.814    A        4.047870    0.000000
        11    1351.489    A        1.449783    0.000000
        12    1351.501    A        1.449735    0.000000
        13    1571.418    A        1.171513    0.000052
        14    1579.795    A        1.200724    0.153536
        15    1677.021    A        1.021095    0.000980
        16    1677.059    A        1.021335    0.002375
        17    1677.998    A        1.063219    0.250237
        18    1678.052    A        1.062971    0.248824
        19    3195.709    A        1.032281    1.263930
        20    3199.892    A        1.033956    0.000002
        21    3240.262    A        1.101111    0.000072
        22    3240.357    A        1.101120    0.000034
        23    3267.113    A        1.101896    1.664596
        24    3267.204    A        1.101903    1.664104

Frequencies didn't change!


# Analysis

## Check geometries

### CCCBDB geometry data

Search CCCBDB for calculated geometry of ethane and record path:

- Calculated > Geometry > Calculated Geometry > C2H6 > ground state > HF > 3-21G\* 
    
Copy coordinate table.

```
    Atom    	X	        Y	        Z
    C	 0.0000000	 0.0000000	 0.7782150
    C	 0.0000000	 0.0000000	-0.7782150
    H	 0.0000000	 1.0098560	 1.1698740
    H	-0.8745610	-0.5049280	 1.1698740
    H	 0.8745610	-0.5049280	 1.1698740
    H	 0.0000000	 1.0098560	-1.1698740
    H	 0.8745610	-0.5049280	-1.1698740
    H	-0.8745610	-0.5049280	-1.1698740
```

Copy atom-atom distance table.

        	C1  	C2	    H3	    H4	    H5	    H6	    H7	    H8
    C1	        1.5564	1.0831	1.0831	1.0831	2.1943	2.1943	2.1943
    C2	1.5564		    2.1943	2.1943	2.1943	1.0831	1.0831	1.0831
    H3	1.0831	2.1943		    1.7491	1.7491	2.3397	2.9213	2.9213
    H4	1.0831	2.1943	1.7491	    	1.7491	2.9213	2.9213	2.3397
    H5	1.0831	2.1943	1.7491	1.7491	    	2.9213	2.3397	2.9213
    H6	2.1943	1.0831	2.3397	2.9213	2.9213	    	1.7491	1.7491
    H7	2.1943	1.0831	2.9213	2.9213	2.3397	1.7491	    	1.7491
    H8	2.1943	1.0831	2.9213	2.3397	2.9213	1.7491	1.7491	    

Copy bond-angle table.

    atom1	atom2	atom3	angle	    atom1	atom2	atom3	angle
    C1  	C2  	H6  	111.198		C1  	C2  	H7  	111.198
    C1  	C2  	H8  	111.198		C2  	C1  	H3  	111.198
    C2  	C1  	H4  	111.198		C2  	C1  	H5  	111.198
    H3  	C1  	H4  	107.690		H3  	C1  	H5  	107.690
    H4  	C1  	H5  	107.690		H6  	C2  	H7  	107.690
    H6  	C2  	H8  	107.690		H7  	C2  	H8  	107.690


### GAMESS geometry data

Open `ethane-1.out` and search for "EQUILIBRIUM GEOMETRY LOCATED". Copy coordinates table.

       ATOM   CHARGE       X              Y              Z
     ------------------------------------------------------------
     C           6.0  -0.7706592002   0.0000080299  -0.0000034410
     C           6.0   0.7719351314  -0.0000323073   0.0000287738
     H           1.0  -1.1553976401  -1.0010361374   0.1591729289
     H           1.0  -1.1553995409   0.6383693357   0.7873417755
     H           1.0  -1.1554012259   0.3626674347  -0.9465182753
     H           1.0   1.1571553749  -0.3625983666   0.9463980508
     H           1.0   1.1571681550   1.0008422096  -0.1591716729
     H           1.0   1.1571633817  -0.6382228807  -0.7872411895


Use OpenBabel to convert `ethane-1.out` to geometry report.

    $ obabel -iout ethane-1.out -oreport

Copy internuclear distances table.

```
INTERATOMIC DISTANCES

              C   1      C   2      H   3      H   4      H   5      H   6
              ------------------------------------------------------------------
   C   1    0.0000 
   C   2    1.5426     0.0000 
   H   3    1.0842     2.1776     0.0000 
   H   4    1.0842     2.1776     1.7556     0.0000 
   H   5    1.0842     2.1776     1.7556     1.7556     0.0000 
   H   6    2.1780     1.0842     2.5249     2.5249     3.0752     0.0000 
   H   7    2.1780     1.0842     3.0752     2.5249     2.5249     1.7554 
   H   8    2.1780     1.0842     2.5249     3.0752     2.5249     1.7554 

              H   7      H   8
              ----------------------
   H   7    0.0000 
   H   8    1.7553     0.0000 
```

Copy bond-angle table.

    BOND ANGLES
       2    1    5   C3   C3   HC    110.787
       3    1    5   HC   C3   HC    108.125
       4    1    5   HC   C3   HC    108.127
       2    1    3   C3   C3   HC    110.784
       2    1    4   C3   C3   HC    110.785
       3    1    4   HC   C3   HC    108.125
       7    2    8   HC   C3   HC    108.091
       1    2    8   C3   C3   HC    110.813
       6    2    8   HC   C3   HC    108.104
       1    2    7   C3   C3   HC    110.811
       6    2    7   HC   C3   HC    108.098
       1    2    6   C3   C3   HC    110.814


Compare bond lengths and angles between GAMESS and CCCBDB.

                GAMESS   NIST   RE(%) 
                ======  ======  =====
     C-C        1.5426  1.5564  -0.89
     C-H        1.0842  1.0831  +0.10
     C-C-H      110.79  111.20  -0.37
     H-C-H      108.13  107.69  +0.41

Calculate error relative to NIST values.

    RE = [ (GAMESS value) - (CCCBDB value) ] / (CCCBDB value)
       = (1.5426 - 1.5564) / (1.5564)
       = -0.89 %

Compare H3-H6 distances and calculate relative error in the same way.

                GAMESS   NIST   RE(%) 
                ======  ======  =====
     H3-H6      2.5249  2.3397   -7.9
     H3-H7      3.0752  2.9213   +5.3
     H3-H8      2.5249  2.9213  -14


### Visualize NIST geometry

Copy `ethane-4.inp` to `ethane-cccbdb.inp` and open file.

    $ cp ethane-4.inp ethane-cccbdb.inp
    $ c9 open ethane-cccbdb.inp

Copy and paste CCCBDB coordinates into `$DATA` block and save file. Copy to new file named `current`. Open jsmol.html and run web app.

    $ cp ethane-cccbdb.inp current
    $ c9 open jsmol.html

**Observation.** NIST geometry is in eclipsed conformation, which is WRONG. `ethane-1` through `ethane-4` were all built in staggered conformation. 


