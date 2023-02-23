# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Declarations
#
#! @Chapter The category of ZX diagrams

#! @Section Constructors

#! @Description
#!   Creates a category of ZX diagrams as a tower.
#! @Returns a category of zx diagrams
DeclareGlobalFunction( "CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers" );

#! @Section Filters

#! @Description
#!   The filter of categories of ZX-diagrams.
DeclareFilter( "IsCategoryOfZXDiagrams", IsCapCategory );

#! @Description
#!   The filter of objects in a category of ZX-diagrams.
DeclareFilter( "IsZXDiagramObject", IsCapCategoryObject );

#! @Description
#!   The filter of morphisms in a category of ZX-diagrams.
DeclareFilter( "IsZXDiagramMorphism", IsCapCategoryMorphism );

#! @Section Attributes

#! @Description
#!   The integer defining an object in a category of ZX-diagrams.
#! @Arguments obj
DeclareAttribute( "Integer", IsZXDiagramObject );

CapJitAddTypeSignature( "Integer", [ IsZXDiagramObject ], IsInt );

#! @Description
#!   The labeled graph defining a morphism in a category of ZX-diagrams.
#! @Arguments mor
DeclareAttribute( "VertexLabeledGraph", IsZXDiagramMorphism );

CapJitAddTypeSignature( "VertexLabeledGraph", [ IsZXDiagramMorphism ], CapJitDataTypeOfNTupleOf( 2, CapJitDataTypeOfListOf( IsString ), CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsInt, IsInt ) ) ) );

# helpers
DeclareGlobalName( "ZX_LabelToInteger" );
DeclareGlobalName( "ZX_IntegerToLabel" );
DeclareGlobalName( "S_ZX_EDGES" );