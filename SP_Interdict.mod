#---------MODEL FILE----------------
#Name of Model file: model SP_Interdict.mod
param N_Nodes;
param N_Arcs;
param Budget;#Total resource available to the Interdictor
param Source_Node;
param Dest_Node;
set NODES:= 1..N_Nodes;
set ARCS:= 1..N_Arcs;
param Node_Arc{ARCS, NODES};
param Arc_Length{ARCS};
param Arc_Delay{ARCS};
param Arc_Resource{ARCS}; #amount of resource required to interdict the arc
var Interdict{ARCS} binary; #1 if Arc a is interdicted, 0 otherwise
var Dual{NODES}; #Dual variable for Node i. It represents the length of the shortest path to node i from source s
maximize Longest_shortest_path: Dual[Dest_Node] - Dual[Source_Node];
subject to
Dual_Constraint{a in ARCS}: sum{n in NODES} Node_Arc[a,n]*Dual[n] -
Arc_Delay[a]*Interdict[a] <= Arc_Length[a];
Dual_node_source: Dual[Source_Node] = 0;
Interdiction_budget: sum{a in ARCS} Arc_Resource[a]*Interdict[a] <= Budget;
#---------END OF MODEL FILE----------------