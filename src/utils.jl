
# --------------------------------------------------------------------------
# ACE1.jl: Julia implementation of the Atomic Cluster Expansion
# Copyright (c) 2019 Christoph Ortner <christophortner0@gmail.com>
# Licensed under ASL - see ASL.md for terms and conditions.
# --------------------------------------------------------------------------


module Utils

import ACE1.RPI: BasicPSH1pBasis, SparsePSHDegree, RPIBasis, get_maxn
import ACE1: PolyTransform, transformed_jacobi
import ACE1.PairPotentials: PolyPairBasis

# - simple ways to construct a radial basis
# - construct a descriptor
# - simple wrappers to generate RPI basis functions (ACE + relatives)

export rpi_basis, descriptor, pair_basis, ace_basis

function rpi_basis(; species = :X, N = 3,
      # transform parameters
      r0 = 2.5,
      trans = PolyTransform(2, r0),
      # degree parameters
      wL = 1.5, 
      D = SparsePSHDegree(; wL = wL),
      maxdeg = 8,
      # radial basis parameters
      rcut = 5.0,
      rin = 0.5 * r0,
      pcut = 2,
      pin = 2,
      constants = false,
      rbasis = nothing, 
      # one-particle basis type 
      Basis1p = BasicPSH1pBasis, 
      warn = true)

   if rbasis == nothing    
      if (pcut < 2) && warn 
         @warn("`pcut` should normally be ≥ 2.")
      end
      if (pin < 2) && (pin != 0) && warn 
         @warn("`pin` should normally be ≥ 2 or 0.")
      end

      rbasis = transformed_jacobi(get_maxn(D, maxdeg, species), trans, rcut, rin;
                                  pcut=pcut, pin=pin)
   end

   basis1p = Basis1p(rbasis; species = species, D = D)
   return RPIBasis(basis1p, N, D, maxdeg, constants)
end

descriptor = rpi_basis
ace_basis = rpi_basis

function pair_basis(; species = :X,
      # transform parameters
      r0 = 2.5,
      trans = PolyTransform(2, r0),
      # degree parameters
      maxdeg = 8,
      # radial basis parameters
      rcut = 5.0,
      rin = 0.5 * r0,
      pcut = 2,
      pin = 0,
      rbasis = transformed_jacobi(maxdeg, trans, rcut, rin; pcut=pcut, pin=pin))

   return PolyPairBasis(rbasis, species)
end




end
