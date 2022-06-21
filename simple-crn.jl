using DifferentialEquations

function hjelmfelt!(du, u, p, t)
    k1 = 100.0
    km1 = 1.0
    k2 = 5e4
    km2 = 1.0
    k3 = 5e4
    km3 = 1.0
    k4 = 1.0
    km4 = 100
    
    J1 = k1*C0 - km1*C0*u[1]
    J2 = k2*u[1]*u[4] - km2*u[3]
    J3 = k3*u[2]*u[3] - km3*u[4]
    J4 = k4*u[2] - km4

    # u = [X1, X3, A, B]
    du[1] = J1 - J2
    du[2] = -J3 - J4
    du[3] = J2 - J3
    du[4] = J3 - J2
end 


u0 = [0.0;0.0;0.9;0.0]
tspan = (0.0, 100.0)
prob = ODEProblem(hjelmfelt!, u0, tspan)
sol = solve(prob)

using Plots

plot(sol, vars=(3, 4))
