# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2019.05.20" ) then
    
    Error( "AutoDoc version 2019.05.20 or newer is required." );
    
fi;

AutoDoc( rec(
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc" ],
    ),
    extract_examples := rec(
        units := "Single",
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                % this is the only way to suppress an overfull hbox in the signature of CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers
                \geometry{left=26mm,right=26mm}
            """,
        ),
    ),
    scaffold := rec(
        entities := [ "homalg", "CAP", "QPA" ],
    ),
) );

QUIT;
