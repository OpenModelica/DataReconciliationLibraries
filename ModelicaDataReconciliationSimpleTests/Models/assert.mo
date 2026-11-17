within ModelicaDataReconciliationSimpleTests.Models;
model assert
  Real a(uncertain=Uncertainty.refine);
  Real b(uncertain=Uncertainty.refine);
  parameter Real c=5 annotation(__OpenModelica_BoundaryCondition=true);
  Real table_real[2]={1.0,2.0};
equation
  a=b;
  a=c;
  assert(abs(table_real[1] - 1.0) < 1e-10, "Assert");
  annotation (
    experiment(StartTime=0, StopTime=1),
    __OpenModelica_simulationFlags(
      lv="LOG_JAC",
      eps="0.0023",
      s="dassl",
      sx="modelica://ModelicaDataReconciliationSimpleTests/resources/model_assert_DR.csv"));
end assert;
