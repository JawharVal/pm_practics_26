set N ordered;   # работники
set T ordered;   # задачи

param effort{T} >= 0;
param pref{N,T} >= 0;

var x{N,T} binary;

s.t. Assign{t in T}: sum{n in N} x[n,t] = 1;

var load{n in N} = sum{t in T} effort[t] * x[n,t];
var maxLoad >= 3;
s.t. DefMaxLoad{n in N}: load[n] <= maxLoad;

var totalPref{n in N} = sum{t in T} pref[n,t] * x[n,t];
var assigned{n in N} = sum{t in T} x[n,t];
var avgPref{n in N} = if assigned[n] > 0 then totalPref[n]/assigned[n] else 0;

var minAvgPref;
s.t. DefMinAvg{n in N}: minAvgPref <= avgPref[n];

param Lmin := ceil(sum{t in T} effort[t] / card(N));
param Lmax := sum{t in T} effort[t];
param Pmin := min{n in N, t in T} pref[n,t];
param Pmax := max{n in N, t in T} pref[n,t];

var f1;
var f2;

s.t. DefF1: f1 = (maxLoad - Lmin) / (Lmax - Lmin + 1e-6);
s.t. DefF2: f2 = (Pmax - minAvgPref) / (Pmax - Pmin + 1e-6);

param alpha := 0.5;
param beta  := 0.5;

minimize Obj: alpha * f1 + beta * f2;
