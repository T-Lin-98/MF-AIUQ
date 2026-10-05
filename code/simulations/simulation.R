# Load required packages
library(AIUQ) 

# Simulation setup
# Parameters used in the simulation studies are specified below.
# Uncomment the corresponding block to reproduce each simulation scenario in the article.
set.seed(1)
M=100 
frame_size=500 
len=500 
# Initial particle positions
pos0 = matrix(0.25*frame_size+0.5*frame_size*runif(2*M),nrow=M,ncol=2)

# Slow Brownian motion
# sigma_bm = 0.1
# simul_model_name = 'BM'
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                    I0 = 20, pos0 = pos0, M = M, sigma_bm = sigma_bm)

# Fast Brownian motion
# sigma_bm = 1
# simul_model_name = 'BM'
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                    I0 = 20, pos0 = pos0, M = M, sigma_bm = sigma_bm)
 
# Subdiffusive fractional Brownian motion
# sigma_fbm = 2
# H = 0.3
# simul_model_name = 'FBM'
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                   I0 = 20, pos0 = pos0, M = M, sigma_fbm = sigma_fbm, H = H)
  
# Superdiffusive fractional Brownian motion
# sigma_fbm = 0.5
# H = 0.6
# simul_model_name = 'FBM'
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                    I0 = 20, pos0 = pos0, M = M, sigma_fbm = sigma_fbm, H = H)

# Ornstein-Uhlenbeck process
# sigma_ou = 4
# rho = 0.95
# simul_model_name = 'OU'
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                    I0 = 20, pos0 = pos0, M = M, sigma_ou = sigma_ou, rho = rho)

# Mixture of Ornstein-Uhlenbeck and fractional Brownian motion process
# sigma_ou = 1.5
# rho = 0.85
# sigma_fbm = 1
# H = 0.225
# simul_model_name = "OU+FBM"
# simulation_list = AIUQ::simulation(sz = frame_size, len_t = len, model_name = simul_model_name, noise = "gaussian", 
#                                    I0 = 20, pos0 = pos0, M = M, 
#                                    sigma_fbm = sigma_fbm, H = H, sigma_ou = sigma_ou, rho = rho)


# Estimate the MSD using MF-AIUQ
sam_mf = SAM(sim_object = simulation_list, model_name = sim_bm@model_name, 
             model_free_estimation = TRUE)

# Set uncertainty = TRUE to obtain the 95% confidence interval
# sam_mf = SAM(sim_object = simulation_list, model_name = sim_bm@model_name, 
#              model_free_estimation = TRUE, uncertainty = TRUE) 


# plot
# tau_MPT = read.csv(paste0("MPT_records/", file_name, "_tau.csv"), header = F)
# tau_MPT = as.matrix(tau_MPT)
# MSD_MPT = read.csv(paste0("MPT_records/", file_name, "_MSD.csv"), header = F)
# MSD_MPT = as.matrix(MSD_MPT)
# 
# DDMUQ_records = read.csv(paste0("DDMUQ_records/DDMUQ_", file_name, "_MSD.csv"), header = T)
# tau_DDMUQ = as.matrix(DDMUQ_records[,1])
# MSD_DDMUQ = as.matrix(DDMUQ_records[,2])
# MSD_lower_DDMUQ = as.matrix(DDMUQ_records[,3])
# MSD_upper_DDMUQ = as.matrix(DDMUQ_records[,4])

# if (simul_model_name == "BM") {
#   file_name = paste0("BM_", sigma_bm)
#   if (sigma_bm == 0.1) {
#     legend_text = "Slow BM"
#     ylim_l = 0.01
#   } else if (sigma_bm == 1) {
#     legend_text = "Fast BM"
#     ylim_l = 1
#   }
# } else if (simul_model_name == "FBM") {
#   file_name = paste0("FBM_", sigma_fbm, "_H_", H)
#   if (sigma_fbm == 2 && H == 0.3) {
#     legend_text = "Subdiffusive FBM"
#     ylim_l = 1
#   } else if (sigma_fbm == 0.5 && H == 0.6) {
#     legend_text = "Superdiffusive FBM"
#     ylim_l = 0.1
#   }
# } else if (simul_model_name == "OU") {
#   file_name = paste0("OU_", sigma_ou, "_rho_", rho)
#   legend_text = "OU"
#   ylim_l = 1
# } else if (simul_model_name == "OU_FBM") {
#   file_name = paste0("OU_", sigma_ou, "_rho_", rho, "_FBM_", sigma_fbm, "_H_", H)
#   legend_text = "OU-FBM"
#   ylim_l = 1
# }
# 
# xlim_l = 1
# xlim_u = max(d_input) + 60
# ylim_l = ylim_l
# ylim_u = max(range((c(truth, MSD_MFAIUQ, MSD_MPT, MSD_DDMUQ)))[2], max(MSD_upper)) * 1.1
# plot(d_input, truth, log = "xy", type = "n",
#      xlab = expression(Delta*t), ylab = expression("<" * Delta*x^2 * "(" * Delta*t * ")" * ">"),
#      xlim = c(xlim_l, xlim_u), 
#      ylim = c(ylim_l, ylim_u),
#      xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2.5)
# kx = floor(log10(c(xlim_l, xlim_u)))
# major_x = 10^(kx[1]:kx[2])
# major_x = major_x[major_x >= xlim_l & major_x <= xlim_u]
# minor_x = as.vector(outer(10^(kx[1]:kx[2]), 2:9))
# minor_x = minor_x[minor_x >= xlim_l & minor_x <= xlim_u]
# axis(1, at = major_x, labels = parse(text = paste0("10^", log10(major_x))), tcl = 0.4, lwd = 1.4, cex.axis = 1.8)
# axis(1, at = minor_x, labels = FALSE, tcl = 0.3, lwd = 1)
# ky = floor(log10(c(ylim_l, ylim_u)))
# major_y = 10^(ky[1]:ky[2])
# major_y = major_y[major_y >= ylim_l & major_y <= ylim_u]
# minor_y = as.vector(outer(10^(ky[1]:ky[2]), 2:9))
# minor_y = minor_y[minor_y >= ylim_l & minor_y <= ylim_u]
# axis(2, at = major_y, labels = parse(text = paste0("10^", log10(major_y))), tcl = 0.4, lwd = 1.4, cex.axis = 1.8)
# axis(2, at = minor_y, labels = FALSE, tcl = 0.3, lwd = 1)
# #points(d_input, par_AIUQ, pch = 4, col = "blue", cex = 1.9, lwd = 2.2)
# points(d_input, MSD_MFAIUQ, pch = 1, col = "cyan", cex = 1.8, lwd = 1.8)
# points(tau_DDMUQ, MSD_DDMUQ, pch = 2, col = "darkgreen", cex = 1.1, lwd = 1.1)
# lines(tau_MPT, MSD_MPT, col = "#E76F51", lwd = 3)
# lines(d_input, truth, col = "black", lwd = 3)
# polygon(c(d_input, rev(d_input)), 
#         c(MSD_lower, rev(MSD_upper)),
#         col = rgb(0.5, 0.5, 0.5, 0.5), border = NA)
# legend("bottomright", legend = legend_text,
#        bty = "n", text.font = 1.8, cex = 2.2, inset = c(-0.03, -0.04))




