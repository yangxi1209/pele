'''
Created on 3 Jun 2012

@author: ruehle
'''

from pygmin.potentials import BasePotential 
import numpy as np

__all__ = ["GMINPotential"]

class GMINPotential(BasePotential):
    '''
    classdocs
    '''


    def __init__(self, GMIN):
        '''
        Constructor
        '''
        self.GMIN = GMIN
        self.ncalls = 0

    def getEnergy(self, coords):
        self.ncalls += 1
        return self.GMIN.getEnergy(coords)
        
    def getEnergyGradient(self, coords):
        self.ncalls += 1
        grad = np.zeros(3*self.GMIN.getNAtoms()) #coords.shape)
        E = self.GMIN.getEnergyGradient(coords, grad)
        return E,grad[0:coords.size]
    
    def getCoords(self):
        coords = np.zeros(self.GMIN.getDOF())
        self.GMIN.getCoords(coords)
        return coords
