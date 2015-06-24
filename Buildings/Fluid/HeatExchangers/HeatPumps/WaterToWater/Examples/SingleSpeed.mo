within Buildings.Fluid.HeatExchangers.HeatPumps.WaterToWater.Examples;
model SingleSpeed "Test model for single speed water to water heat pump"
  extends Modelica.Icons.Example;
  package Medium1 = Buildings.Media.ConstantPropertyLiquidWater;
  package Medium2 = Buildings.Media.ConstantPropertyLiquidWater;
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal = datHP.heaMod.m1_flow_nominal
    "Medium1 nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal = datHP.heaMod.m2_flow_nominal
    "Medium2 nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp1_nominal = 8000
    "Pressure drop at m1_flow_nominal";
  parameter Modelica.SIunits.Pressure dp2_nominal = 8000
    "Pressure drop at m2_flow_nominal";
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 101325,
    nPorts=1,
    T=323.15) "Sink"
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Buildings.Fluid.Sources.Boundary_pT sou2(
    use_p_in=true,
    redeclare package Medium = Medium2,
    nPorts=1,
    T=293.15)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Buildings.Fluid.Sources.Boundary_pT sin2(
    redeclare package Medium = Medium2,
    p(displayUnit="Pa") = 101325,
    T=298.15,
    nPorts=1) "Sink"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Fluid.Sources.Boundary_pT sou1(
    use_p_in=true,
    redeclare package Medium = Medium1,
    nPorts=1,
    T=293.15)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  Modelica.Blocks.Sources.Ramp p1(
    duration=600,
    offset=101325,
    height=2000,
    startTime=60) "Pressure"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp p2(
    duration=600,
    offset=101325,
    startTime=60,
    height=3000) "Pressure"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,-30})));
  Buildings.Fluid.HeatExchangers.HeatPumps.WaterToWater.SingleSpeed sinSpe(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    datHP=datHP,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=dp1_nominal,
    dp2_nominal=dp2_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    "Single speed water to water heat pump"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));

  Data.HPData datHP(cooMod(
      m1_flow_nominal=1.89,
      m2_flow_nominal=1.89,
      nSta=1,
      cooPer={
          Data.BaseClasses.CoolingPerformance(
          spe=1200,
          Q_flow_nominal=-39890.91,
          P_nominal=4790,
          cooCap={-1.52030596,3.46625667,-1.32267797,0.09395678,0.038975504},
          cooP={-8.59564386,0.96265085,8.69489229,0.02501669,-0.20132665})}),
      heaMod(
      m1_flow_nominal=1.89,
      m2_flow_nominal=1.89,
      nSta=1,
      heaPer={
          Data.BaseClasses.HeatingPerformance(
          spe=1200,
          QHea_flow_nominal=39040.92,
          PHea_nominal=5130,
          heaCap={-3.33491153,-0.51451946,4.51592706,0.01797107,0.155797661},
          heaP={-8.93121751,8.57035762,1.29660976,-0.21629222,0.033862378})}))
    "Heat  pump data"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Sources.IntegerTable intTab(table=[0,0; 900,1; 1800,2; 2700,1])
    "Mode change"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(p1.y, sou1.p_in) annotation (Line(
      points={{-79,10},{-72,10},{-72,18},{-62,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p2.y, sou2.p_in) annotation (Line(
      points={{79,-30},{72,-30},{72,-22},{62,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sou1.ports[1], sinSpe.port_a1) annotation (Line(
      points={{-40,10},{-26,10},{-26,6},{-8,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sin2.ports[1], sinSpe.port_b2) annotation (Line(
      points={{-40,-30},{-26,-30},{-26,-6},{-8,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sin1.ports[1], sinSpe.port_b1) annotation (Line(
      points={{40,10},{28,10},{28,6},{12,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinSpe.port_a2, sou2.ports[1]) annotation (Line(
      points={{12,-6},{26,-6},{26,-30},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intTab.y, sinSpe.mode) annotation (Line(
      points={{-59,50},{-20,50},{-20,10},{-10,10}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/HeatPumps/WaterToWater/Examples/SingleSpeed.mos"
        "Simulate and plot"),
          Documentation(info="<html>
<p>
This is a test model for  
<a href=\"modelica://Buildings.Fluid.HeatExchangers.HeatPumps.WaterToWater.Examples.SingleSpeed\">
Buildings.Fluid.HeatExchangers.HeatPumps.WaterToWater.Examples.SingleSpeed</a>. 
The model has open-loop control and time-varying input conditions. 
Pressure difference across both sides of heat pump is ramped up from zero to 2000 Pa and 3000 Pa respectively thus, this example tests zero mass flow rate condition. 
Also the control input i.e. the mode of coil is changed to heating and then cooling condition from off state.
</p>
</html>",
revisions="<html>
<ul>
<li>
Jan 12, 2013 by Kaustubh Phalak:<br>
First implementation. 
</li>
</ul></html>"));
end SingleSpeed;