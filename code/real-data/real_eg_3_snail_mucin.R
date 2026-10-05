# Load required packages
library(AIUQ)
library(bioimagetools)

# Load the image sequence
file_name = "snail_mucin"
intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))

mindt = 0.3 # Minimum lag time
pxsz = 0.1465 # Pixel size 

# Estimate the MSD using MF-AIUQ
sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", mindt = mindt, pxsz = pxsz, 
             model_free_estimation = TRUE) 

# Set uncertainty = TRUE to obtain the 95% confidence interval
# Set estimate_moduli = TRUE to estimate the storage and loss moduli
M = 200 # Number of particles
sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", M = M, mindt = mindt, pxsz = pxsz,
             model_free_estimation = TRUE, uncertainty = TRUE, estimate_moduli = TRUE)


# plot
# tau_MPT = read.csv("MPT_records/snail_mucin_tau.csv", header = F)
# tau_MPT = as.matrix(tau_MPT)
# MSD_MPT = read.csv("MPT_records/snail_mucin_MSD.csv", header = F)
# MSD_MPT = as.matrix(MSD_MPT)
# 
# MPT_sp = read.csv(paste0("MPT_records/MPT_MSD_spline_snail_mucin.csv"), header = T)
# tau_MPT_sp = MPT_sp$tau
# MSD_MPT_sp = MPT_sp$MSD_spline
# 
# DDMUQ_records = read.csv(paste0("DDMUQ_records/DDMUQ_snail_mucin_MSD.csv"), header = T)
# tau_DDMUQ = as.matrix(DDMUQ_records[,1])
# MSD_DDMUQ = as.matrix(DDMUQ_records[,2])
# 
# GSER_bulk = read.csv("GSER_records/Bulk Rheology Result_mucin.csv", header = T)
# GSER_MF_AIUQ = read.csv("GSER_records/Gp_Gpp_MF_AIUQ.csv", header = T)
# GSER_MPT_poly = read.csv("GSER_records/Gp_Gpp_MPT_poly.csv", header = T)
# GSER_MPT_spline = read.csv("GSER_records/Gp_Gpp_sp_record.csv", header = T)
# 
# idx = which(MSD_MPT > 0)
# n = length(idx)
# MSD_ln_dev_est = numeric(n)
# ln_MSD_est = log(MSD_MPT[idx])
# ln_time = log(d_input[idx])
# lm_ln_MSD_est = lm(ln_MSD_est ~ poly(ln_time, 4, raw=TRUE))
# MSD_MPT_poly = exp(predict(lm_ln_MSD_est))
# 
# 
# xlim_l = min(d_input)
# xlim_u = max(d_input) + 2
# ylim_l = min(0.001, min(MSD_lower), MSD_MPT) * 0.4
# ylim_u = max(range((c(MSD_MFAIUQ, MSD_MPT, MSD_DDMUQ)))[2], max(MSD_upper)) * 1.2
# plot(d_input, MSD_MFAIUQ, log = "xy", type = "n",
#      xlab = expression(Delta*t ~ "[s]"), ylab = expression("<" * Delta*x^2 * "(" * Delta*t * ")" * ">" ~ "[" * mu*m^2 * "]"), ,
#      xlim = c(xlim_l, xlim_u), 
#      ylim = c(ylim_l, ylim_u),
#      xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2.2)
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
# points(d_input, MSD_MFAIUQ, pch = 1, col = "cyan", cex = 1.8, lwd = 1.8)
# points(tau_DDMUQ, MSD_DDMUQ, pch = 2, col = "darkgreen", cex = 1.1, lwd = 1.1)
# lines(tau_MPT, MSD_MPT, col = "#E76F51", lwd = 3)
# lines(tau_MPT_sp, MSD_MPT_sp, col = "gold", lwd = 3)
# lines(tau_MPT, MSD_MPT_poly, col = "#918ac2", lwd = 2.2)
# polygon(c(d_input, rev(d_input)), 
#         c(MSD_lower, rev(MSD_upper)),
#         col = rgb(0.5, 0.5, 0.5, 0.5), border = NA)
# legend("bottomright",
#        #inset = c(0.03, 0.02),
#        legend = c("MF-AIUQ", "DDM-UQ", "MPT", "MPT spline", "MPT polynomial"),
#        col = c("cyan", "darkgreen", "#E76F51", "gold", "#918ac2"),
#        pch = c(1, 2, NA, NA, NA),
#        lty = c(NA, NA, 1, 1, 1),
#        lwd = c(NA, NA, 2.5, 2.5, 2.5),
#        bty = "n",
#        cex = 1.2,
#        pt.cex = 1.1,
#        pt.lwd = 2,
#        x.intersp = 0.5,
#        y.intersp = 1.1,
#        seg.len = 1.4)
# 
# 
# xlim_l = 0.001
# xlim_u = max(GSER_MF_AIUQ$omega, GSER_bulk$omega_Gp, GSER_bulk$omega_Gpp) * 2
# ylim_l = 0.001
# ylim_u = max(GSER_bulk$Gp, GSER_bulk$Gpp, GSER_MF_AIUQ$Gp, GSER_MF_AIUQ$Gpp) * 2
# plot(GSER_bulk$omega_Gp, GSER_bulk$Gp, log = "xy", type = "n",
#      xlab = expression(omega ~ "[" * rad/s * "]"), ylab = expression(G*minute ~ "," ~ G*minute*minute ~ "[Pa]"),
#      xlim = c(xlim_l, xlim_u), ylim = c(ylim_l, ylim_u),
#      xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2)
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
# points(GSER_bulk$omega_Gp, GSER_bulk$Gp,
#        pch = 22, bg = "darkgray", col = "black", cex = 1.3)
# points(GSER_bulk$omega_Gpp, GSER_bulk$Gpp,
#        pch = 21, bg = "darkgray", col = "black", cex = 1.3)
# lines(GSER_MF_AIUQ$omega, GSER_MF_AIUQ$Gp,
#       type = "l", col = "cyan", lwd = 5)
# points(GSER_MF_AIUQ$omega, GSER_MF_AIUQ$Gpp,
#        pch = 21, bg = "white", col = "cyan", cex = 1.3)
# legend("bottomright",
#        legend = c(expression(MF-AIUQ~G*minute),
#                   expression(MF-AIUQ~G*minute*minute),
#                   expression(bulk~G*minute),
#                   expression(bulk~G*minute*minute)),
#        col = c("cyan", "cyan", "black", "black"),
#        lty = c(1, NA, NA, NA),
#        pch = c(NA, 21, 22, 21),
#        lwd = c(2, 1.5, NA, NA),
#        pt.bg = c(NA, "white", "darkgray", "darkgray"),
#        pt.cex = 1.3,
#        bty = "n",
#        cex = 1.2)
# 
# 
# xlim_l = 0.001
# xlim_u = max(GSER_MPT_poly$omega, GSER_bulk$omega_Gp, GSER_bulk$omega_Gpp) * 2
# ylim_l = 0.001
# ylim_u = max(GSER_bulk$Gp, GSER_bulk$Gpp, GSER_MPT_poly$Gp, GSER_MPT_poly$Gpp) * 2
# plot(GSER_bulk$omega_Gp, GSER_bulk$Gp, log = "xy", type = "n",
#      xlab = expression(omega ~ "[" * rad/s * "]"), ylab = expression(G*minute ~ "," ~ G*minute*minute ~ "[Pa]"),
#      xlim = c(xlim_l, xlim_u), ylim = c(ylim_l, ylim_u),
#      xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2)
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
# #plot_idx = seq(1, length(GSER_MPT_poly$omega), 3)
# points(GSER_bulk$omega_Gp, GSER_bulk$Gp,
#        pch = 22, bg = "darkgray", col = "black", cex = 1.3)
# points(GSER_bulk$omega_Gpp, GSER_bulk$Gpp,
#        pch = 21, bg = "darkgray", col = "black", cex = 1.3)
# lines(GSER_MPT_poly$omega, GSER_MPT_poly$Gp,
#       type = "l", col = "#918ac2", lwd = 5)
# points(GSER_MPT_poly$omega, GSER_MPT_poly$Gpp,
#        pch = 21, bg = "white", col = "#918ac2", cex = 1.3)
# legend("bottomright",
#        legend = c(expression(MPT-polynomial~G*minute),
#                   expression(MPT-polynomial~G*minute*minute),
#                   expression(bulk~G*minute),
#                   expression(bulk~G*minute*minute)),
#        col = c("#918ac2", "#918ac2", "black", "black"),
#        lty = c(1, NA, NA, NA),
#        pch = c(NA, 21, 22, 21),
#        lwd = c(2, 1.5, NA, NA),
#        pt.bg = c(NA, "white", "darkgray", "darkgray"),
#        pt.cex = 1.3,
#        bty = "n",
#        cex = 1.2)
# 
# 
# 
# xlim_l = 0.001
# xlim_u = max(GSER_MPT_spline$omega, GSER_bulk$omega_Gp, GSER_bulk$omega_Gpp) * 2
# ylim_l = 0.001
# ylim_u = max(GSER_bulk$Gp, GSER_bulk$Gpp, GSER_MPT_spline$Gprime, GSER_MPT_spline$Gdoubleprime) * 2
# plot(GSER_bulk$omega_Gp, GSER_bulk$Gp, log = "xy", type = "n",
#      xlab = expression(omega ~ "[" * rad/s * "]"), ylab = expression(G*minute ~ "," ~ G*minute*minute ~ "[Pa]"),
#      xlim = c(xlim_l, xlim_u), ylim = c(ylim_l, ylim_u),
#      xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2)
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
# #plot_idx = seq(1, length(GSER_MPT_spline$omega_rad_s), 3)
# points(GSER_bulk$omega_Gp, GSER_bulk$Gp,
#        pch = 22, bg = "darkgray", col = "black", cex = 1.3)
# points(GSER_bulk$omega_Gpp, GSER_bulk$Gpp,
#        pch = 21, bg = "darkgray", col = "black", cex = 1.3)
# lines(GSER_MPT_spline$omega, GSER_MPT_spline$Gprime,
#       type = "l", col = "gold", lwd = 5)
# points(GSER_MPT_spline$omega, GSER_MPT_spline$Gdoubleprime,
#        pch = 21, bg = "white", col = "gold", cex = 1.3)
# legend("bottomright",
#        legend = c(expression(MPT-spline~G*minute),
#                   expression(MPT-spline~G*minute*minute),
#                   expression(bulk~G*minute),
#                   expression(bulk~G*minute*minute)),
#        col = c("gold", "gold", "black", "black"),
#        lty = c(1, NA, NA, NA),
#        pch = c(NA, 21, 22, 21),
#        lwd = c(2, 1.5, NA, NA),
#        pt.bg = c(NA, "white", "darkgray", "darkgray"),
#        pt.cex = 1.3,
#        bty = "n",
#        cex = 1.2)


