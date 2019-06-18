
# --------------------------------------------------------------------------
# ACE.jl and SHIPs.jl: Julia implementation of the Atomic Cluster Expansion
# Copyright (c) 2019 Christoph Ortner <christophortner0@gmail.com>
# All rights reserved.
# --------------------------------------------------------------------------


using SHIPs, JuLIP, BenchmarkTools

trans = PolyTransform(2, 1.0)
ship = SHIPBasis(3, 12, 2.0, trans, 2, 0.5, 3.0)

Rs = 1.0 .+ rand(JVecF, 50)

@info("profile precomputation of A")
@btime SHIPs.precompute_A!($ship, $Rs)
@btime SHIPs.precompute_A!($ship, $Rs)

@info("profile basis computation")
B = SHIPs.alloc_B(ship)
@btime SHIPs.eval_basis!($B, $ship, $Rs)
@btime SHIPs.eval_basis!($B, $ship, $Rs)




# using Profile
# ##
# function runn(ship, Rs, N)
#    for n = 1:N
#       SHIPs.precompute_A!(ship, Rs)
#    end
#    return ship
# end
# Profile.clear()
# runn(ship, Rs, 10)
# @profile runn(ship, Rs, 10_000)
# Profile.print()
