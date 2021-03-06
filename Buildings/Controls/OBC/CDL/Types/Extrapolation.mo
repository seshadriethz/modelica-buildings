within Buildings.Controls.OBC.CDL.Types;
type Extrapolation = enumeration(
    HoldLastPoint
      "Hold the first/last table point outside of the table scope",
    LastTwoPoints
      "Extrapolate by using the derivative at the first/last table points outside of the table scope",
    Periodic "Repeat the table scope periodically")
  "Enumeration defining the extrapolation of time table interpolation";
