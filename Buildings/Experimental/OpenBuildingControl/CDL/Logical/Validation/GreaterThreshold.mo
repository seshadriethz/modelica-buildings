within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Validation;
model GreaterThreshold
  "Validation model for the GreaterThreshold block"
extends Modelica.Icons.Example;

  Buildings.Experimental.OpenBuildingControl.CDL.Sources.Ramp ramp2(
    duration=1,
    offset=-1,
    height=2) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));

  Buildings.Experimental.OpenBuildingControl.CDL.Logical.GreaterThreshold greThr
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));

equation
  connect(ramp2.y, greThr.u)
    annotation (Line(points={{-5,0},{8,0},{24,0}}, color={0,0,127}));
  annotation (
  experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Logical/Validation/GreaterThreshold.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Logical.GreaterThreshold\">
Buildings.Experimental.OpenBuildingControl.CDL.Logical.GreaterThreshold</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 1, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end GreaterThreshold;
