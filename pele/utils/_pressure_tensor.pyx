"""
# distutils: language = C++

This module provides access to the c++ pressure measurement.
"""
import numpy as np
cimport numpy as np
cimport pele.potentials._pele as _pele
from pele.potentials._pele cimport array_wrap_np
from pele.potentials._pele cimport shared_ptr

cdef extern from "pele/pressure_tensor.h" namespace "pele":
    double c_pressure_tensor "pele::pressure_tensor"(
           shared_ptr[_pele.cBasePotential] pot,
           _pele.Array[double] x,
           _pele.Array[double] ptensor,
           double volume
           )except +
           
cdef pressure_tensor(shared_ptr[_pele.cBasePotential] pot, np.ndarray[double, ndim=1] x, volume, ndim):
    """Computes the pressure tensor and returns the scalar pressure.
    
    The negative of the pressure tensor is often called the stress
    tensor, see Allen, Tidsley, "Computer Simulation of Liquids"
    pp. 60-61.
    
    Parameters
    ----------
    pot : base-potential
        potential for pressure compuation
    x : array
        particle coordinates
    volume : scalar
        box volume
    ndim : scalar
        box dimension
        
    Returns
    -------
    p : pressure (trace of ptensor?)
    ptensor : pressure tensor
    """
    cdef np.ndarray[double, ndim=1] ptensor = np.zeros(ndim * ndim)
    p = c_pressure_tensor(pot, array_wrap_np(x), array_wrap_np(ptensor), volume)
    return p, ptensor

