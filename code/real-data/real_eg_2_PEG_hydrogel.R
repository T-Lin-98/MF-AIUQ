# Load required packages
library(AIUQ)
library(bioimagetools)

# Load the image sequence
file_name = paste0("20mgmL_25C_DMSO_13min")
file_name = paste0("20mgmL_25C_DMSO_22min")
file_name = paste0("20mgmL_25C_DMSO_31min")
file_name = paste0("20mgmL_25C_DMSO_40min")
file_name = paste0("20mgmL_25C_DMSO_49min")
file_name = paste0("20mgmL_25C_DMSO_58min")

intensity = suppressWarnings(readTIF(paste0(file_name, ".tif")))

mindt = 0.0309 # Minimum lag time
pxsz = 0.2930 # Pixel size 

# Estimate the MSD using MF-AIUQ
sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", mindt = mindt, pxsz = pxsz, 
             model_free_estimation = TRUE) 

# Set uncertainty = TRUE to obtain the 95% confidence interval
# M = 200 # Number of particles
# sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", M = M, mindt = mindt, pxsz = pxsz, 
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
# 
# if (file_name == "20mgmL_25C_DMSO_13min") {
#   plot_name = "13min"
#   legend_text = "13 min"
# } else if (file_name == "20mgmL_25C_DMSO_22min") {
#   plot_name = "22min"
#   legend_text = "22 min"
# } else if (file_name == "20mgmL_25C_DMSO_31min") {
#   plot_name = "31min"
#   legend_text = "31 min"
# } else if (file_name == "20mgmL_25C_DMSO_40min") {
#   plot_name = "40min"
#   legend_text = "40 min"
# } else if (file_name == "20mgmL_25C_DMSO_49min") {
#   plot_name = "49min"
#   legend_text = "49 min"
# } else {
#   plot_name = "58min"
#   legend_text = "58 min"
# }

# xlim_l = 0.0309
# xlim_u = max(d_input) + 2
# ylim_l = min(0.001, min(MSD_lower), MSD_AIUQ) * 0.9
# ylim_u = max(range((c(MSD_MFAIUQ, MSD_AIUQ, MSD_MPT, MSD_DDMUQ)))[2], max(MSD_upper)) * 1.2
# plot(tau_MPT, MSD_MPT, log = "xy", type = "n",
#      xlab = expression(Delta*t ~ "[s]"), ylab = expression("<" * Delta*x^2 * "(" * Delta*t * ")" * ">" ~ "[" * mu*m^2 * "]"),
#      xlim = c(xlim_l, xlim_u), 
#      ylim = c(ylim_l, ylim_u),
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
# points(d_input, MSD_AIUQ, pch = 4, col = "blue", cex = 1.1, lwd = 1.1)
# points(d_input, MSD_MFAIUQ, pch = 1, col = "cyan", cex = 1.8, lwd = 1.8)
# points(tau_DDMUQ, MSD_DDMUQ, pch = 2, col = "darkgreen", cex = 1.1, lwd = 1.1)
# lines(tau_MPT, MSD_MPT, col = "#E76F51", lwd = 3)
# polygon(c(d_input, rev(d_input)), 
#         c(MSD_lower, rev(MSD_upper)),
#         col = rgb(0.5, 0.5, 0.5, 0.5), border = NA) 
# legend("bottomright", legend = legend_text,
#        bty = "n", text.font = 1.8, cex = 2.2, inset = c(-0.03, -0.04))
# 
# 
