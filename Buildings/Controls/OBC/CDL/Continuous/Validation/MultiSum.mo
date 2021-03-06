within Buildings.Controls.OBC.CDL.Continuous.Validation;
model MultiSum "Model to validate the application of MultiSum block"
  extends Modelica.Icons.Example;

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp1(
    duration=1,
    offset=-2,
    height=4)  "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp2(
    height=2,
    duration=1,
    offset=-1) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp3(
    height=3,
    duration=1,
    offset=-1) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp4(
    height=3,
    duration=1,
    offset=-2) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp ramp5(
    height=3,
    duration=1,
    offset=-3) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum_5(
    nin=5,
    k={1,0.5,0.1,1,2})
    "Sum of Reals, y = k[1]*u[1] + k[2]*u[2] + ... + k[5]*u[5]"
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum_2(
    nin=2,
    k={1,0.5}) "Sum of Reals, y = k[1]*u[1] + k[2]*u[2]"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiSum mulSum_1(
    nin=1,
    k={1}) "Sum of Reals, y = k[1]*u[1]"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
equation
  connect(ramp1.y, mulSum_5.u[1]) annotation (Line(points={{-39,60},{-39,60},{
          20,60},{20,-24.4},{38,-24.4}}, color={0,0,127}));
  connect(ramp2.y, mulSum_5.u[2]) annotation (Line(points={{-39,30},{-39,30},{
          10,30},{10,-27.2},{38,-27.2}}, color={0,0,127}));
  connect(ramp3.y, mulSum_5.u[3]) annotation (Line(points={{-39,0},{0,0},{0,-30},
          {38,-30}}, color={0,0,127}));
  connect(ramp4.y, mulSum_5.u[4]) annotation (Line(points={{-39,-30},{-20,-30},
          {-20,-32},{10,-32},{10,-32.8},{38,-32.8}},
                                 color={0,0,127}));
  connect(ramp5.y, mulSum_5.u[5]) annotation (Line(points={{-39,-60},{20,-60},{
          20,-35.6},{38,-35.6}}, color={0,0,127}));
  connect(ramp1.y, mulSum_1.u[1]) annotation (Line(points={{-39,60},{20,60},{20,
          50},{38,50}}, color={0,0,127}));
  connect(ramp1.y, mulSum_2.u[1]) annotation (Line(points={{-39,60},{20,60},{20,
          13.5},{38,13.5}}, color={0,0,127}));
  connect(ramp2.y, mulSum_2.u[2]) annotation (Line(points={{-39,30},{10,30},{10,
          6.5},{38,6.5}}, color={0,0,127}));
  annotation (
  experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Continuous/Validation/MultiSum.mos"
        "Simulate and plot"),
  Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Controls.OBC.CDL.Continuous.MultiSum\">
Buildings.Controls.OBC.CDL.Continuous.MultiSum</a>.
</p>
<p>
The inputs and gains are configured as follows:
</p>
<ul>
<li>
<i>u<sub>1</sub></i> varies from <i>-2</i> to <i>+2</i>,
with gain <i>k = 1</i>.
</li>
<li>
<i>u<sub>2</sub></i> varies from <i>-1</i> to <i>+1</i>,
with gain <i>k = 0.5</i>.
</li>
<li>
<i>u<sub>3</sub></i> varies from <i>-1</i> to <i>+2</i>,
with gain <i>k = 0.1</i>.
</li>
<li>
<i>u<sub>4</sub></i> varies from <i>-2</i> to <i>+1</i>,
with gain <i>k = 1</i>.
</li>
<li>
<i>u<sub>5</sub></i> varies from <i>-3</i> to <i>0</i>,
with gain <i>k = 2</i>.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
June 28, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end MultiSum;
