within Buildings.Controls.OBC.CDL.Logical.Validation;
model And3 "Validation model for the And3 block"
extends Modelica.Icons.Example;

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul1(
      width=0.5, period=1.5) "Block that outputs cyclic on and off"
    annotation (Placement(transformation(extent={{-26,24},{-6,44}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul2(
      width=0.5, period=5) "Block that outputs cyclic on and off"
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));

  Buildings.Controls.OBC.CDL.Logical.And3 and1
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul3(
      width=0.5, period=3) "Block that outputs cyclic on and off"
    annotation (Placement(transformation(extent={{-26,-44},{-6,-24}})));
equation
  connect(booPul1.y, and1.u1) annotation (Line(points={{-5,34},{8,34},{8,8},{24,
          8}},  color={255,0,255}));
  connect(booPul2.y, and1.u2)
    annotation (Line(points={{-5,0},{10,0},{24,0}}, color={255,0,255}));
  connect(booPul3.y, and1.u3) annotation (Line(points={{-5,-34},{8,-34},{8,-8},
          {24,-8}},color={255,0,255}));
  annotation (
  experiment(StopTime=10.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Logical/Validation/And3.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.CDL.Logical.And3\">
Buildings.Controls.OBC.CDL.Logical.And3</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 10, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end And3;
