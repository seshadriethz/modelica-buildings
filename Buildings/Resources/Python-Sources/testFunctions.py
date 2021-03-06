# Python module with test functions.
# These functions are used to test the Modelica Python interface.
# They are not meaningful, but rather kept simple to test whether
# the interface is correct.
#
# Make sure that the python path is set, such as by running
# export PYTHONPATH=`pwd`

def r1_r1(xR):
    return 2.*xR

def r2_r1(xR):
    y = xR[0] * xR[1]
    return y

def r1_r2(xR):
    return [xR, 2.*xR]

def i1_i1(xI):
    return 2*xI

def i1_i2(xI):
    return [xI, 2*xI]

def r1i1_r2(xR, xI):
    return [2.*xR, 2.*float(xI)]

def s2_r1(xS):
    import os
    filNam = xS[0] + "." + xS[1]
    f = open(filNam, 'r')
    l = f.readline()
    f.close()
    os.remove(filNam)
    y = float(l)
    return y
