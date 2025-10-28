reset;
model model.ampl;
data data.ampl;

option solver gurobi;



solve;

display maxLoad, minAvgPref;
display load, totalPref, avgPref, assigned;
display x;

printf "\nРаспределение задач по исполнителям:\n";
for {n in N, t in T: x[n,t] > 0.5} {
    printf "Исполнитель %s <- Задача %s\n", n, t;
}
