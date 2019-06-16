
# --------------------------------------------------------------------------
# ACE.jl and SHIPs.jl: Julia implementation of the Atomic Cluster Expansion
# Copyright (c) 2019 Christoph Ortner <christophortner0@gmail.com>
# All rights reserved.
# --------------------------------------------------------------------------



function eval_basis end
function eval_basis! end
function eval_grad end
function eval_basis_d! end

eval_basis(B, args...) = eval_basis!(zeros(length(B)), B, args...)
eval_basis_d(B, args...) = eval_basis_d!(zeros(length(B)), zeros(length(B)), B, args...)

function transform end
function transform_d end
function fcut end
function fcut_d end
