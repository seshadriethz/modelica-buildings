within Buildings.Controls.OBC.CDL.Continuous.Validation;
model Abs "Validation model for the absolute block"
extends Modelica.Icons.Example;

  Buildings.Controls.OBC.CDL.Continuous.Abs abs1
    "Block that outputs the absolute value of the input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp(
    height=2,
    duration=1,
    offset=-1) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(ramp.y, abs1.u)
    annotation (Line(points={{-39,0},{-26,0},{-12,0}}, color={0,0,127}));
  annotation (
experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Continuous/Validation/Abs.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.Abs\">
Buildings.Controls.OBC.CDL.Continuous.Abs</a>.
The input varies from <i>-1</i> to <i>+1</i>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 17, 2017, by Jianjun Hu:<br/>
Update the Ramp block: <a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.Ramp\">
Buildings.Controls.OBC.CDL.Continuous.Ramp</a>.
</li>
</ul>
<ul>
<li>
February 22, 2017, by Michael Wetter:<br/>
First implementation.
</li>
</ul>

</html>"));
end Abs;
