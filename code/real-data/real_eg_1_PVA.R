# Load required packages
library(AIUQ)
library(bioimagetools)

# Load the image sequence
file_name = '4pct_PVA_1um_25C'
# file_name = '4pct_PVA_200nm_25C'
# file_name = '4pct_PVA_100nm_25C'
# file_name = '4pct_PVA_100nm_25C_BF'

intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))

mindt = 0.0309 # Minimum lag time
pxsz =0.2930 # Pixel size 

# Estimate the MSD using MF-AIUQ
sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", mindt = mindt, pxsz = pxsz, 
             model_free_estimation = TRUE) 

# Set uncertainty = TRUE to obtain the 95% confidence interval
# M = 100 # Number of particles
# sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", M = M, mindt = mindt, pxsz = pxsz, 
#              model_free_estimation = TRUE, uncertainty = TRUE) 


# plot
# if(file_name=='4pct_PVA_1um_25C'){
#   b_truth=0.0759
# }else if(file_name=='4pct_PVA_200nm_25C'){
#   b_truth=0.3795
# }else if(file_name=='4pct_PVA_100nm_25C'|file_name=='4pct_PVA_100nm_25C_BF'){
#   b_truth=0.7589
# }else if(file_name=='4pct_PVA_20nm_25C'){
#   b_truth=3.7945
# }

# tau_MPT = read.csv(paste0("MPT_records/", file_name, "_tau.csv"), header = F)
# tau_MPT = as.matrix(tau_MPT)
# MSD_MPT = read.csv(paste0("MPT_records/", file_name, "_MSD.csv"), header = F)
# MSD_MPT = as.matrix(MSD_MPT)
# 
# if (file_name == "4pct_PVA_100nm_25C_BF") {
#   DDMUQ_records = read.csv(paste0("DDMUQ_records/DDMUQ_", file_name, ".csv"), header = T)
#   tau_DDMUQ = as.matrix(DDMUQ_records[,1]) 
#   MSD_DDMUQ = as.matrix(DDMUQ_records[,2])
# } else {
#   DDMUQ_records = read.csv(paste0("DDMUQ_records/DDMUQ_", file_name, ".csv"), header = F)
#   tau_DDMUQ = as.matrix(DDMUQ_records[1,]) 
#   MSD_DDMUQ = as.matrix(DDMUQ_records[2,])
# }

# if (file_name == "4pct_PVA_1um_25C") {
#   plot_name = "1um"
#   legend_text = latex2exp::TeX("1 $\\mu$m")
#   intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))
#   img = intensity[,,250]
#   img = (img-min(img))/diff(range(img))
# } else if (file_name == "4pct_PVA_200nm_25C") {
#   plot_name = "200nm"
#   legend_text = "200 nm"
#   intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))
#   img = intensity[,,250]
#   img = (img-min(img))/diff(range(img))
# } else if (file_name == "4pct_PVA_100nm_25C") {
#   plot_name = "100nm"
#   legend_text = "100 nm"
#   intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))
#   img = intensity[,,250]
#   img = (img-min(img))/diff(range(img))
# } else {
#   plot_name = "100nm_BF"
#   legend_text = "100 nm BF"
#   intensity=suppressWarnings(readTIF(paste0(file_name, ".tif")))
#   img = intensity[,,250]
#   img = (img-min(img))/diff(range(img))
# }
# 
# 
# par(mar = c(4.1, 5.6, 1.5, 1.5), mgp = c(3.2, 1, 0), xpd = NA)
# xlim_l = 0.0309
# xlim_u = max(d_input) + 2
# ylim_l = min(MSD_lower) * 0.05 # 0.7 for 1um 0.1 for 200nm 0.05 for 100nm
# ylim_u = max(range((c(truth, MSD_MFAIUQ, MSD_MPT, MSD_DDMUQ)))[2], max(MSD_upper)) * 1.1
# plot(d_input, truth, log = "xy", type = "n",
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
# points(d_input, MSD_MFAIUQ, pch = 1, col = "cyan", cex = 1.8, lwd = 1.8)
# points(tau_DDMUQ, MSD_DDMUQ, pch = 2, col = "darkgreen", cex = 1.1, lwd = 1.1)
# lines(tau_MPT, MSD_MPT, col = "#E76F51", lwd = 3)
# lines(d_input, truth, col = "black", lwd = 3)
# polygon(c(d_input, rev(d_input)), c(MSD_lower, rev(MSD_upper)), col = rgb(0.5, 0.5, 0.5, 0.5), border = NA) 
# img_raster = as.raster(img)
# oldpar = par(no.readonly = TRUE)
# par(fig = c(0.64, 0.92, 0.2, 0.59), mar = c(0, 0, 0, 0), new = TRUE)
# plot.new()
# plot.window(xlim = c(0, 1), ylim = c(0, 1), asp = 1)
# rasterImage(img_raster, 0, 0, 1, 1)
# scale_um = 50
# field_um = 0.293 * 512
# bar_frac = scale_um/field_um
# segments(0.62, 0.12, 0.62 + bar_frac, 0.12, col = "white", lwd = 5, lend = "butt")
# par(oldpar)
# legend("topleft", legend = legend_text,
#        bty = "n", text.font = 1.8, cex = 2.2, inset = c(-0.1, -0.04))

