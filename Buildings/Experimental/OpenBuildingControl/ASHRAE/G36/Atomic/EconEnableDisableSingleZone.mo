within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Atomic;
block EconEnableDisableSingleZone
  "Single zone VAV AHU economizer enable/disable switch"

  parameter Boolean use_enthalpy = true
    "Set to true to evaluate outdoor air (OA) enthalpy in addition to temperature";
  parameter Modelica.SIunits.Time smaDisDel = 0
    "Optional small time delay before closing the OA damper at disable to avoid pressure fluctuations";
  parameter Real retDamPhyPosMax(final min=0, final max=1, final unit="1") = 1
    "Physically fixed maximum position of the return air damper";
  parameter Real retDamPhyPosMin(final min=0, final max=1, final unit="1") = 0
    "Physically fixed minimum position of the return air damper";

  CDL.Interfaces.RealInput TOut(final unit="K", final quantity = "ThermodynamicTemperature")
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-220,250},{-180,290}}),
      iconTransformation(extent={{-120,90},{-100,110}})));
  CDL.Interfaces.RealInput hOut(final unit="J/kg", final quantity="SpecificEnergy") if use_enthalpy
    "Outdoor air enthalpy"
    annotation (Placement(transformation(extent={{-220,170},{-180,210}}),
      iconTransformation(extent={{-120,50},{-100,70}})));
  CDL.Interfaces.RealInput TOutCut(final unit="K", final quantity = "ThermodynamicTemperature")
    "OA temperature high limit cutoff. For differential dry bulb temeprature condition use return air temperature measurement"
    annotation (Placement(transformation(extent={{-220,210},{-180,250}}),
      iconTransformation(extent={{-120,70},{-100,90}})));
  CDL.Interfaces.RealInput hOutCut(final unit="J/kg", final quantity="SpecificEnergy") if use_enthalpy
    "OA enthalpy high limit cutoff. For differential enthalpy use return air enthalpy measurement"
    annotation (Placement(transformation(extent={{-220,130},{-180,170}}),iconTransformation(extent={{-120,30},{-100,50}})));
  CDL.Interfaces.RealInput uOutDamPosMin(final min=0, final max=1)
    "Minimum outdoor air damper position, get from damper position limits sequence"
    annotation (Placement(transformation(extent={{-220,-180},{-180,-140}}),
      iconTransformation(extent={{-120,-70},{-100,-50}})));
  CDL.Interfaces.RealInput uOutDamPosMax(final min=0, final max=1)
    "Maximum outdoor air damper position, get from damper position limits sequence"
    annotation (Placement(transformation(extent={{-220,-150},{-180,-110}}),
      iconTransformation(extent={{-120,-50},{-100,-30}})));
  CDL.Interfaces.BooleanInput uSupFan "Supply fan on/off status signal"
    annotation (Placement(transformation(extent={{-220,90},{-180,130}}),iconTransformation(extent={{-120,-30},{-100,-10}})));
  CDL.Interfaces.IntegerInput uZonSta "Zone state status signal"
    annotation (Placement(transformation(extent={{-220,-30},{-180,10}}),
      iconTransformation(extent={{-120,-10},{-100,10}})));
  CDL.Interfaces.IntegerInput uFreProSta "Freeze protection stage status signal"
    annotation (Placement(transformation(extent={{-220,30},{-180,70}}),
      iconTransformation(extent={{-120,10},{-100,30}})));

  CDL.Interfaces.RealOutput yOutDamPosMax(final min=0, final max=1, final unit="1")
    "Maximum outdoor air damper position"
    annotation (Placement(transformation(extent={{180,-150},{200,-130}}),
      iconTransformation(extent={{100,28},{140,68}})));
  CDL.Interfaces.RealOutput yRetDamPosMin(final min=retDamPhyPosMin, final max=retDamPhyPosMax, final unit="1")
    "Minimum return air damper position"
    annotation (Placement(transformation(extent={{180,-250},{200,-230}}),
      iconTransformation(extent={{100,-100},{140,-60}})));
  CDL.Interfaces.RealOutput yRetDamPosMax(final min=retDamPhyPosMin, final max=retDamPhyPosMax, final unit="1")
    "Maximum return air damper position"
    annotation (Placement(transformation(
      extent={{180,-220},{200,-200}}), iconTransformation(extent={{100,-40},{140,0}})));

  CDL.Logical.And3 andEnaDis "Logical and that checks freeze protection stage and zone state"
   annotation (Placement(transformation(extent={{40,30},{60,50}})));
  CDL.Logical.TrueFalseHold trueFalseHold(duration=600) "10 min on/off delay"
    annotation (Placement(transformation(extent={{0,200},{20,220}})));

protected
  final parameter Modelica.SIunits.Temperature delTOutHis=1
    "Delta between the temperature hysteresis high and low limit";
  final parameter Modelica.SIunits.SpecificEnergy delEntHis=1000
    "Delta between the enthalpy hysteresis high and low limits"
    annotation(Evaluate=true, Dialog(group="Enthalpy sensor in use", enable = use_enthalpy));
  final parameter Modelica.SIunits.Temperature TOutHigLimCutHig = 0
    "Hysteresis high limit cutoff";
  final parameter Real TOutHigLimCutLow = TOutHigLimCutHig - delTOutHis
    "Hysteresis low limit cutoff";
  final parameter Modelica.SIunits.SpecificEnergy hOutHigLimCutHig = 0
    "Hysteresis block high limit cutoff";
  final parameter Real hOutHigLimCutLow = hOutHigLimCutHig - delEntHis
    "Hysteresis block low limit cutoff";

  CDL.Continuous.Sources.Constant disableDelay(final k=smaDisDel)
    "Small delay before closing the outdoor air damper to avoid pressure fluctuations"
    annotation (Placement(transformation(extent={{-120,-120},{-100,-100}})));
  CDL.Logical.Sources.Constant entSubst(final k=false) if not use_enthalpy
    "Deactivates outdoor air enthalpy condition if there is no enthalpy sensor"
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  CDL.Continuous.Sources.Constant retDamPhyPosMinSig(final k=retDamPhyPosMin)
    "Physically fixed minimum position of the return air damper"
    annotation (Placement(transformation(extent={{-140,-258},{-120,-238}})));
  CDL.Continuous.Sources.Constant retDamPhyPosMaxSig(final k=retDamPhyPosMax)
    "Physically fixed maximum position of the return air damper. This is the initial condition of the return air damper"
    annotation (Placement(transformation(extent={{-140,-220},{-120,-200}})));
  CDL.Logical.Hysteresis hysOutTem(final uHigh=TOutHigLimCutHig, final uLow=TOutHigLimCutLow)
    "Outdoor air temperature hysteresis for both fixed and differential dry bulb temperature cutoff conditions"
    annotation (Placement(transformation(extent={{-100,240},{-80,260}})));
  CDL.Logical.Hysteresis hysOutEnt(final uLow=hOutHigLimCutLow, final uHigh=hOutHigLimCutHig) if use_enthalpy
    "Outdoor air enthalpy hysteresis for both fixed and differential enthalpy cutoff conditions"
    annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
  CDL.Continuous.Add add2(final k2=-1) if use_enthalpy
    "Add block that determines the difference between hOut and hOutCut"
    annotation (Placement(transformation(extent={{-140,160},{-120,180}})));
  CDL.Continuous.Add add1(final k2=-1)
    "Add block that determines difference the between TOut and TOutCut"
    annotation (Placement(transformation(extent={{-140,240},{-120,260}})));
  CDL.Logical.Switch outDamSwitch "Set maximum OA damper position to minimum at disable (after time delay)"
    annotation (Placement(transformation(extent={{40,-150},{60,-130}})));
  CDL.Logical.Switch minRetDamSwitch
    "Keep minimum RA damper position at physical maximum for a short time period after disable"
    annotation (Placement(transformation(extent={{40,-250},{60,-230}})));
  CDL.Logical.GreaterEqual greEqu "Logical greater or equal block"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  CDL.Logical.Timer timer "Timer gets started as the economizer gets disabled"
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  CDL.Logical.Nor nor1 "Logical nor"
    annotation (Placement(transformation(extent={{-40,200},{-20,220}})));
  CDL.Logical.Not not2 "Logical not that starts the timer at disable signal "
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  CDL.Logical.LessEqualThreshold equ(final threshold=Constants.FreezeProtectionStages.stage0)
    "Logical block to check if the freeze protection is deactivated"
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  CDL.Logical.GreaterThreshold greThr(final threshold=Constants.ZoneStates.heating)
    "Check if ZoneState is other than heating"
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  CDL.Logical.GreaterThreshold greThr2(final threshold=0) "Check if the timer got started"
    annotation (Placement(transformation(extent={{80,-180},{100,-160}})));
  CDL.Logical.And and1 "Logical and checks supply fan status"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));
  CDL.Logical.And and3 "Logical and"
    annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  CDL.Conversions.IntegerToReal intToRea "Integer to real converter"
    annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  CDL.Conversions.IntegerToReal intToRea1 "Integer to real converter"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));

equation
  connect(outDamSwitch.y, yOutDamPosMax)
    annotation (Line(points={{61,-140},{61,-140},{190,-140}}, color={0,0,127}));
  connect(TOut, add1.u1)
    annotation (Line(points={{-200,270},{-160,270},{-160,256},{-142,256}},color={0,0,127}));
  connect(TOutCut, add1.u2)
    annotation (Line(points={{-200,230},{-160,230},{-160,244},{-142,244}},color={0,0,127}));
  connect(add1.y, hysOutTem.u)
    annotation (Line(points={{-119,250},{-102,250}}, color={0,0,127}));
  connect(hOut, add2.u1)
    annotation (Line(points={{-200,190},{-160,190},{-160,176},{-142,176}},color={0,0,127}));
  connect(hOutCut, add2.u2)
    annotation (Line(points={{-200,150},{-160,150},{-160,164},{-142,164}}, color={0,0,127}));
  connect(add2.y, hysOutEnt.u) annotation (Line(points={{-119,170},{-102,170}}, color={0,0,127}));
  connect(hysOutTem.y, nor1.u1) annotation (Line(points={{-79,250},{-60,250},{-60,210},{-42,210}}, color={255,0,255}));
  connect(hysOutEnt.y, nor1.u2)
    annotation (Line(points={{-79,170},{-60,170},{-60,202},{-42,202}},  color={255,0,255}));
  connect(entSubst.y, nor1.u2) annotation (Line(points={{-79,200},{-60,200},{-60,202},{-42,202}}, color={255,0,255}));
  connect(timer.y, greEqu.u1) annotation (Line(points={{51,-60},{60,-60},{60,-80},{-80,-80},{-80,-100},{-72,-100}},
        color={0,0,127}));
  connect(uOutDamPosMin, outDamSwitch.u1)
    annotation (Line(points={{-200,-160},{-120,-160},{-60,-160},{-60,-132},{38,-132}},   color={0,0,127}));
  connect(uOutDamPosMax, outDamSwitch.u3)
    annotation (Line(points={{-200,-130},{-80,-130},{-80,-148},{38,-148}}, color={0,0,127}));
  connect(nor1.y, trueFalseHold.u) annotation (Line(points={{-19,210},{-1,210}}, color={255,0,255}));
  connect(andEnaDis.y, not2.u)
    annotation (Line(points={{61,40},{72,40},{72,-20},{-20,-20},{-20,-60},{-12,-60}}, color={255,0,255}));
  connect(minRetDamSwitch.y, yRetDamPosMin)
    annotation (Line(points={{61,-240},{100,-240},{146,-240},{190,-240}}, color={0,0,127}));
  connect(not2.y, timer.u) annotation (Line(points={{11,-60},{28,-60}}, color={255,0,255}));
  connect(uFreProSta, intToRea.u) annotation (Line(points={{-200,50},{-200,50},{-162,50}}, color={255,127,0}));
  connect(intToRea.y, equ.u) annotation (Line(points={{-139,50},{-134,50},{-122,50}}, color={0,0,127}));
  connect(equ.y, andEnaDis.u2)
    annotation (Line(points={{-99,50},{-62,50},{-20,50},{-20,40},{38,40}},color={255,0,255}));
  connect(uZonSta, intToRea1.u) annotation (Line(points={{-200,-10},{-182,-10},{-162,-10}}, color={255,127,0}));
  connect(intToRea1.y, greThr.u) annotation (Line(points={{-139,-10},{-134,-10},{-130,-10},{-122,-10}}, color={0,0,127}));
  connect(greThr.y, andEnaDis.u3)
    annotation (Line(points={{-99,-10},{-20,-10},{-20,32},{38,32}}, color={255,0,255}));
  connect(timer.y, greThr2.u)
    annotation (Line(points={{51,-60},{70,-60},{70,-170},{78,-170}}, color={0,0,127}));
  connect(trueFalseHold.y, and1.u1)
    annotation (Line(points={{21,210},{30,210},{30,130},{-10,130},{-10,110},{-2,110}},color={255,0,255}));
  connect(and1.y, andEnaDis.u1)
    annotation (Line(points={{21,110},{21,110},{30,110},{30,48},{38,48}}, color={255,0,255}));
  connect(uSupFan, and1.u2)
    annotation (Line(points={{-200,110},{-102,110},{-102,102},{-2,102}}, color={255,0,255}));
  connect(retDamPhyPosMaxSig.y, minRetDamSwitch.u1)
    annotation (Line(points={{-119,-210},{-4,-210},{-4,-232},{38,-232}}, color={0,0,127}));
  connect(retDamPhyPosMinSig.y, minRetDamSwitch.u3)
    annotation (Line(points={{-119,-248},{0,-248},{38,-248}}, color={0,0,127}));
  connect(retDamPhyPosMaxSig.y, yRetDamPosMax)
    annotation (Line(points={{-119,-210},{190,-210}}, color={0,0,127}));
  connect(and2.y, minRetDamSwitch.u2)
    annotation (Line(points={{141,-160},{150,-160},{150,-200},{30,-200},{30,-240},{38,-240}}, color={255,0,255}));
  connect(not2.y, and2.u1)
    annotation (Line(points={{11,-60},{20,-60},{20,-120},{114,-120},{114,-160},{118,-160}}, color={255,0,255}));
  connect(greThr2.y, and2.u2)
    annotation (Line(points={{101,-170},{110,-170},{110,-168},{118,-168}}, color={255,0,255}));
  connect(disableDelay.y, greEqu.u2)
    annotation (Line(points={{-99,-110},{-86,-110},{-86,-108},{-72,-108}}, color={0,0,127}));
  connect(greEqu.y, and3.u2) annotation (Line(points={{-49,-100},{-36,-100},{-36,-108},{-22,-108}}, color={255,0,255}));
  connect(not2.y, and3.u1)
    annotation (Line(points={{11,-60},{16,-60},{16,-74},{-30,-74},{-30,-100},{-22,-100}}, color={255,0,255}));
  connect(and3.y, outDamSwitch.u2)
    annotation (Line(points={{1,-100},{12,-100},{12,-140},{38,-140}}, color={255,0,255}));
    annotation(Evaluate=true, Dialog(group="Enthalpy sensor in use", enable = use_enthalpy),
    Icon(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-2,60},{78,60}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-78,-64},{-2,-64},{-2,60}},
          color={0,0,127},
          thickness=0.5),
        Text(
          extent={{-170,150},{158,112}},
          lineColor={0,0,127},
          textString="%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-180,-280},{180,280}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-170,-44},{170,-274}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,16},{170,-36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,76},{170,24}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,136},{170,84}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-170,274},{170,144}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
                                     Text(
          extent={{102,168},{178,156}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Outdoor air
conditions"),                        Text(
          extent={{100,70},{264,48}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Freeze protection -
disable if stage1
and above"),                         Text(
          extent={{100,-34},{214,-86}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Damper position
limit assignments"),                 Text(
          extent={{102,16},{206,-22}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Zone state -
disable if
heating"),                           Text(
          extent={{100,102},{182,92}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Supply fan status")}),
    Documentation(info="<html>
<p>
This is a single zone VAV AHU economizer enable/disable sequence
based on ASHRAE G36 PART5.5 and PART5.A.17. Additional
conditions included in the sequence are: <a href=\"modelica://Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Constants.FreezeProtectionStages\">
Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Constants.FreezeProtectionStages</a> (PART5.9),
supply fan status <code>TSupFan</code> (PART5.4.d),
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Constants.ZoneStates\">
Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Constants.ZoneStates</a> (PART5.3.b).
</p>
<p>
Economizer shall be disabled whenever the outdoor air conditions
exceed the economizer high limit setpoint as specified by the local
code. This sequence allows for all device types listed in
ASHRAE 90.1-2013 and Title 24-2013.
</p>
<p>
In addition, economizer shall be disabled without a delay whenever any of the
following is true: supply fan is off, zone state is <code>heating</code>,
freeze protection stage is not <code>0</code>.
</p>
<p>
The following state machine chart illustrates the above listed conditions:
</p>
<p align=\"center\">
<img alt=\"Image of economizer enable-disable state machine chart\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/Atomic/EconEnableDisableStateMachineChartSingleZone.png\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
July 06, 2017, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end EconEnableDisableSingleZone;
