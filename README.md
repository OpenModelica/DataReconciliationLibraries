# Data reconciliation libraries

Test libraries for the data reconciliation feature of
[OpenModelica](https://github.com/OpenModelica/OpenModelica), moved here from its
testsuite (`testsuite/openmodelica/dataReconciliation`), see
[OpenModelica#14817](https://github.com/OpenModelica/OpenModelica/issues/14817).

- `ModelicaDataReconciliationSimpleTests`: small examples using the Modelica Standard Library 4.1.0.
- `TSP_DataReconciliationSimpleTests`: examples built on ThermoSysPro 4.2.

Both are installed by the OpenModelica package manager, tested in the OpenModelica
testsuite and on [libraries.openmodelica.org](https://libraries.openmodelica.org).

## Running a model

Every model to be tested has an `experiment` annotation, and its reconciliation
settings, measurements (`sx`) and correlation matrix (`cx`) in the
`__OpenModelica_simulationFlags` annotation, with the input files as `modelica://`
URIs into the library's `resources` directory:

```mo
annotation (experiment(StartTime=0, StopTime=1),
  __OpenModelica_simulationFlags(lv="LOG_JAC", eps="0.023", s="dassl",
    sx="modelica://ModelicaDataReconciliationSimpleTests/resources/NewDataReconciliationSimpleTests.DistillationTower_Inputs.csv"));
```

Run it with the data reconciliation module and `-reconcile`:

```mo
setCommandLineOptions("--preOptModules+=dataReconciliation");
loadModel(ModelicaDataReconciliationSimpleTests);
simulate(ModelicaDataReconciliationSimpleTests.Models.DistillationTower,
  simflags="-reconcile -lv=LOG_JAC -eps=0.023 -s=dassl -sx=modelica://ModelicaDataReconciliationSimpleTests/resources/NewDataReconciliationSimpleTests.DistillationTower_Inputs.csv");
```

The simulation writes `<model>.html`, the reconciliation report, next to the
executable, and `<model>_Outputs.csv` with the reconciled values.

## Models without an experiment annotation

The `TSP_DataReconciliationSimpleTests.Models.BIL100` models refer to input files
that are not in this repository, so they are not tested yet.
