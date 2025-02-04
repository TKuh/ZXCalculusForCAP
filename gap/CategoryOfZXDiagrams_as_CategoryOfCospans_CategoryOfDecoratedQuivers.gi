# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

InstallGlobalFunction( CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers, function ( )
  local S_ZX, decorated_quivers, FinalizeCategory, csp, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, ZX;
    
    # expanded version of: S_ZX := CreateQuiver( 4, S_ZX_EDGES );
    S_ZX := CreateCapCategoryObjectWithAttributes( FinQuivers, DefiningTripleOfQuiverEnrichedOverSkeletalFinSets, Triple( 4, 7, S_ZX_EDGES ) );
    
    decorated_quivers := CategoryOfDecoratedQuivers( S_ZX, [ "white", "green", "red", "yellow" ], [ "black", "black", "black", "black", "black", "black", "black" ] : FinalizeCategory := true );
    
    # Display( ENHANCED_SYNTAX_TREE( x -> CreateCapCategoryObjectWithAttributes( FinQuivers, DefiningTripleOfQuiverEnrichedOverSkeletalFinSets, Triple( 4, 7, S_ZX_EDGES ) ) ).bindings.BINDING_RETURN_VALUE );
    ModelingCategory( decorated_quivers )!.compiler_hints.category_attribute_resolving_functions := rec(
        BaseObject := { } -> rec(
            args := rec(
                1 := rec(
                    gvar := "FinQuivers",
                    type := "EXPR_REF_GVAR"
                ),
                2 := rec(
                    gvar := "DefiningTripleOfQuiverEnrichedOverSkeletalFinSets",
                    type := "EXPR_REF_GVAR"
                ),
                3 := rec(
                    args := rec(
                        1 := rec(
                            type := "EXPR_INT",
                            value := 4
                        ),
                        2 := rec(
                            type := "EXPR_INT",
                            value := 7
                        ),
                        3 := rec(
                            gvar := "S_ZX_EDGES",
                            type := "EXPR_REF_GVAR"
                        ),
                        length := 3,
                        type := "SYNTAX_TREE_LIST"
                    ),
                    funcref := rec(
                        gvar := "Triple",
                        type := "EXPR_REF_GVAR"
                    ),
                    type := "EXPR_FUNCCALL"
                ),
                length := 3,
                type := "SYNTAX_TREE_LIST"
            ),
            funcref := rec(
                gvar := "CreateCapCategoryObjectWithAttributes",
                type := "EXPR_REF_GVAR"
            ),
            type := "EXPR_FUNCCALL"
        ),
    );
    
    csp := CategoryOfCospans_for_ZXCalculus( decorated_quivers : FinalizeCategory := true );
    
    object_constructor := function ( cat, integer )
      local obj;
        
        if not (IsBigInt( integer ) and integer >= 0) then
            
            Error( "The object datum in the category of ZX-diagrams must be a non-negative integer." );
            
        fi;
        
        obj := CreateCapCategoryObjectWithAttributes( cat, AsInteger, integer );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( cat, obj ) );
        
        return obj;
        
    end;
    
    modeling_tower_object_constructor := function ( cat, integer )
      local csp, decorated_quivers, decorated_quiver, obj;
        
        if not (IsBigInt( integer ) and integer >= 0) then
            
            Error( "The object datum in the category of ZX-diagrams must be a non-negative integer." );
            
        fi;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        decorated_quiver := ObjectConstructor( decorated_quivers, Pair(
            Triple( integer, BigInt( 0 ), [ ] ), # (nr_vertices, nr_edges, edges)
            Pair( ListWithIdenticalEntries( integer, BigInt( 0 ) ), [ ] ) # (decorations_of_vertices, deocorations_of_edges)
        ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( decorated_quivers, decorated_quiver ) );
        
        obj := ObjectConstructor( csp, decorated_quiver );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( csp, obj ) );
        
        return obj;
        
    end;
    
    object_datum := function ( cat, object )
        
        return AsInteger( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
      local csp, decorated_quivers, pair, integer;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        pair := ObjectDatum( decorated_quivers, ObjectDatum( csp, object ) );
        
        integer := pair[1][1]; # nr_vertices
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert(
            0,
            pair = Pair(
                Triple( integer, BigInt( 0 ), [ ] ), # (nr_vertices, nr_edges, edges)
                Pair( ListWithIdenticalEntries( integer, BigInt( 0 ) ), [ ] ) # (decorations_of_vertices, deocorations_of_edges)
            )
        );
        
        return integer;
        
    end;
    
    morphism_constructor := function ( cat, source, pair, range )
      local mor;
        
        mor := CreateCapCategoryMorphismWithAttributes( cat, source, range, VertexLabeledGraph, pair );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( cat, mor ) );
        
        return mor;
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, pair, range )
      local csp, decorated_quivers, labels, edges, input_positions, output_positions, source_decorated_quiver, source_pair, range_decorated_quiver, range_pair, nr_vertices, nr_edges, decorations_of_vertices, decorations_of_edges, central_decorated_quiver, input_morphism, output_morphism, morphism_pair, mor;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        labels := pair[1];
        edges := pair[2];
        
        input_positions := List( PositionsProperty( labels, x -> x in [ "input", "input_output" ] ), p -> BigInt( p ) - 1 );
        output_positions := List( PositionsProperty( labels, x -> x in [ "output", "input_output" ] ), p -> BigInt( p ) - 1 );
        
        source_decorated_quiver := ObjectDatum( csp, source );
        source_pair := ObjectDatum( decorated_quivers, source_decorated_quiver );
        
        range_decorated_quiver := ObjectDatum( csp, range );
        range_pair := ObjectDatum( decorated_quivers, range_decorated_quiver );
        
        nr_vertices := Length( labels );
        nr_edges := Length( edges );
        
        decorations_of_vertices := List( labels, ZX_LabelToInteger );
        # find each edge in list of S_ZX_EDGES
        # TODO: introduce SafePositions
        decorations_of_edges := List( edges, edge -> BigInt( SafePositionProperty( S_ZX_EDGES, e -> e = Pair( decorations_of_vertices[1 + edge[1]], decorations_of_vertices[1 + edge[2]] ) ) ) - 1 );
        
        central_decorated_quiver := ObjectConstructor( decorated_quivers, Pair(
            Triple(
                nr_vertices,
                nr_edges,
                edges
            ),
            Pair(
                decorations_of_vertices,
                decorations_of_edges
            )
        ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( decorated_quivers, central_decorated_quiver ) );
        
        input_morphism := MorphismConstructor( decorated_quivers, source_decorated_quiver, Pair( input_positions, [ ] ), central_decorated_quiver );
        output_morphism := MorphismConstructor( decorated_quivers, range_decorated_quiver, Pair( output_positions, [ ] ), central_decorated_quiver );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( decorated_quivers, input_morphism ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( decorated_quivers, output_morphism ) );
        
        morphism_pair := Pair( input_morphism, output_morphism );
        
        mor := MorphismConstructor( csp, source, morphism_pair, range );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( csp, mor ) );
        
        return mor;
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return VertexLabeledGraph( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
      local csp, decorated_quivers, morphism_pair, input_morphism, output_morphism, source_decorated_quiver, range_decorated_quiver, central_decorated_quiver, central_decorated_quiver_data, nr_vertices, decorations_of_vertices, input_positions, output_positions, labels, edges;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        morphism_pair := MorphismDatum( csp, morphism );
        
        input_morphism := morphism_pair[1];
        output_morphism := morphism_pair[2];
        
        source_decorated_quiver := Source( input_morphism );
        range_decorated_quiver := Source( output_morphism );
        
        central_decorated_quiver := Range( input_morphism );
        
        central_decorated_quiver_data := ObjectDatum( decorated_quivers, central_decorated_quiver );
        
        nr_vertices := central_decorated_quiver_data[1][1];
        
        decorations_of_vertices := central_decorated_quiver_data[2][1];
        
        input_positions := MorphismDatum( decorated_quivers, input_morphism )[1];
        output_positions := MorphismDatum( decorated_quivers, output_morphism )[1];
        
        labels := List( [ 0 .. nr_vertices - 1 ], i -> ZX_IntegerToLabel( i, input_positions, output_positions, decorations_of_vertices[1 + i] ) );
        edges := central_decorated_quiver_data[1][3];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Number( labels, x -> x in [ "input", "input_output" ] ) = ObjectDatum( source_decorated_quiver )[1][1] );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Number( labels, x -> x in [ "output", "input_output" ] ) = ObjectDatum( range_decorated_quiver )[1][1] );
        
        return Pair( labels, edges );
        
    end;
    
    ZX := ReinterpretationOfCategory( csp, rec(
        name := "Category of ZX-diagrams",
        category_filter := IsCategoryOfZXDiagrams,
        category_object_filter := IsZXDiagramObject,
        category_morphism_filter := IsZXDiagramMorphism,
        object_datum_type := IsBigInt,
        morphism_datum_type := CapJitDataTypeOfNTupleOf( 2, CapJitDataTypeOfListOf( IsStringRep ), CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsBigInt, IsBigInt ) ) ),
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        only_primitive_operations := true,
    ) : FinalizeCategory := false );
    
    Finalize( ZX );
    
    return ZX;
    
end );
