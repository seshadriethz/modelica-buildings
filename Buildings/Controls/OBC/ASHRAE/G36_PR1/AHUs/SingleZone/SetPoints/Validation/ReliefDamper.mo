within Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.SetPoints.Validation;
model ReliefDamper
  "Validate of the controller for actuated relief damper without fan"
  extends Modelica.Icons.Example;

  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.SetPoints.ReliefDamper
    relDamPos
    "Block of controlling actuated relief damper without fan"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant supFan(k=true)
    "Supply fan status"
    annotation (Placement(transformation(extent={{-40,-52},{-20,-32}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp outDamPos(
    duration=1200,
    startTime=0,
    height=0.6,
    offset=0.4)
    "Outdoor air damper position"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

equation
  connect(supFan.y, relDamPos.uSupFan)
    annotation (Line(points={{-19,-42},{0,-42},{0,-6},{39,-6}},
      color={255,0,255}));
  connect(outDamPos.y, relDamPos.uOutDamPos)
    annotation (Line(points={{-19,40},{0,40},{0,6},{39,6}},
      color={0,0,127}));

annotation (
  experiment(StopTime=1200.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/G36_PR1/AHUs/SingleZone/SetPoints/Validation/ReliefDamper.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.SetPoints.ReliefDamper\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.SetPoints.ReliefDamper</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 15, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end ReliefDamper;
