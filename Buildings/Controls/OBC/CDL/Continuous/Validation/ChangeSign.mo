within Buildings.Controls.OBC.CDL.Continuous.Validation;
model ChangeSign "Validation model for the ChangeSign block"
extends Modelica.Icons.Example;

  Buildings.Controls.OBC.CDL.Continuous.ChangeSign changSign
    "Block that change sign of the input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp1(
    duration=1,
    offset=-1.5,
    height=3.0) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(ramp1.y, changSign.u)
    annotation (Line(points={{-39,0},{-12,0}},         color={0,0,127}));
  annotation (
experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Continuous/Validation/ChangeSign.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.ChangeSign\">
Buildings.Controls.OBC.CDL.Continuous.ChangeSign</a>.
</p>
<p>
The input <code>u</code> varies from <i>-1.5</i> to <i>+1.5</i>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 22, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end ChangeSign;
