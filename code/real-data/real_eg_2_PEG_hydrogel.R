# Load required packages
library(AIUQ)
library(bioimagetools)

# Set the working directory to the root directory of the downloaded repository.
# This directory should contain the code/, data/, and results/ folders.
# Replace the example path below with the path to the repository on your computer.
#
# Example for macOS or Linux:
# setwd("/Users/your_name/Desktop/repository-root")
#
# Example for Windows:
# setwd("C:/Users/your_name/Desktop/repository-root")

setwd("/path/to/repository-root")

# Set TRUE to run MF-AIUQ using the microscopy video.
# Set FALSE to use the provided MF-AIUQ records.
run_MFAIUQ = FALSE

# Download the microscopy videos from Zenodo (link) and place the TIFF files
# in the data/ folder at the root of this repository.
#
# Expected directory structure:
# repository-root/
# ├── code/
# ├── data/
# └── results/
#
# Select one experiment:
# "13 min", "22 min", "31 min", "40 min", "49 min", or "58 min"
scenario = "13 min"

if (scenario == "13 min") {
  file_name = "20mgmL_25C_DMSO_13min"
  plot_name = "13min"
  legend_text = "13 min"
} else if (scenario == "22 min") {
  file_name = "20mgmL_25C_DMSO_22min"
  plot_name = "22min"
  legend_text = "22 min"
} else if (scenario == "31 min") {
  file_name = "20mgmL_25C_DMSO_31min"
  plot_name = "31min"
  legend_text = "31 min"
} else if (scenario == "40 min") {
  file_name = "20mgmL_25C_DMSO_40min"
  plot_name = "40min"
  legend_text = "40 min"
} else if (scenario == "49 min") {
  file_name = "20mgmL_25C_DMSO_49min"
  plot_name = "49min"
  legend_text = "49 min"
} else if (scenario == "58 min") {
  file_name = "20mgmL_25C_DMSO_58min"
  plot_name = "58min"
  legend_text = "58 min"
} else {
  stop("Unknown scenario. Choose '13 min', '22 min', '31 min', '40 min', '49 min', or '58 min'.")
}

mindt = 0.0309 # Time interval between consecutive frames in seconds
pxsz = 0.2930 # Pixel size in micrometers

if (run_MFAIUQ) {
  # Load the microscopy video
  intensity = suppressWarnings(readTIF(paste0("data/", file_name, ".tif")))

  # Estimate the MSD and its 95% confidence interval using MF-AIUQ
  M = 200 # Number of tracer particles
  sam_mf = SAM(intensity = intensity, intensity_str = "SST_array", M = M, mindt = mindt, pxsz = pxsz,
               model_free_estimation = TRUE, uncertainty = TRUE)

  # MF-AIUQ results
  d_input = sam_mf@d_input[-1]
  MSD_MFAIUQ = sam_mf@msd_est[-1]
  MSD_lower = sam_mf@msd_lower[-1]
  MSD_upper = sam_mf@msd_upper[-1]
  AIUQ_records = read.csv(paste0("results/MF_AIUQ_records/MSD_", file_name, ".csv"), header = T)
  MSD_AIUQ = as.matrix(AIUQ_records$par_AIUQ)[-1]
} else {
  # Read the provided MF-AIUQ records
  MFAIUQ_records = read.csv(paste0("results/MF_AIUQ_records/MSD_", file_name, ".csv"), header = T)
  d_input = as.matrix(MFAIUQ_records$d_input)[-1]
  MSD_MFAIUQ = as.matrix(MFAIUQ_records$n_par_AIUQ)[-1]
  MSD_AIUQ = as.matrix(MFAIUQ_records$par_AIUQ)[-1]
  MSD_lower = as.matrix(MFAIUQ_records$lower)[-1]
  MSD_upper = as.matrix(MFAIUQ_records$upper)[-1]
}

# Read the MPT results
tau_MPT = read.csv(paste0("results/MPT_records/", file_name, "_tau.csv"), header = F)
tau_MPT = as.matrix(tau_MPT)
MSD_MPT = read.csv(paste0("results/MPT_records/", file_name, "_MSD.csv"), header = F)
MSD_MPT = as.matrix(MSD_MPT)

# Read the DDM-UQ results
DDMUQ_records = read.csv(paste0("results/DDM_UQ_records/DDMUQ_", file_name, "_MSD.csv"), header = T)
tau_DDMUQ = as.matrix(DDMUQ_records[,1])
MSD_DDMUQ = as.matrix(DDMUQ_records[,2])


# Plot
xlim_l = 0.0309
xlim_u = max(d_input) + 2
ylim_l = min(0.001, min(MSD_lower), MSD_AIUQ) * 0.9
ylim_u = max(range((c(MSD_MFAIUQ, MSD_AIUQ, MSD_MPT, MSD_DDMUQ)))[2], max(MSD_upper)) * 1.2
plot(tau_MPT, MSD_MPT, log = "xy", type = "n",
     xlab = expression(Delta*t ~ "[s]"), ylab = expression("<" * Delta*x^2 * "(" * Delta*t * ")" * ">" ~ "[" * mu*m^2 * "]"),
     xlim = c(xlim_l, xlim_u),
     ylim = c(ylim_l, ylim_u),
     xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n", cex.lab = 2)
kx = floor(log10(c(xlim_l, xlim_u)))
major_x = 10^(kx[1]:kx[2])
major_x = major_x[major_x >= xlim_l & major_x <= xlim_u]
minor_x = as.vector(outer(10^(kx[1]:kx[2]), 2:9))
minor_x = minor_x[minor_x >= xlim_l & minor_x <= xlim_u]
axis(1, at = major_x, labels = parse(text = paste0("10^", log10(major_x))), tcl = 0.4, lwd = 1.4, cex.axis = 1.8)
axis(1, at = minor_x, labels = FALSE, tcl = 0.3, lwd = 1)
ky = floor(log10(c(ylim_l, ylim_u)))
major_y = 10^(ky[1]:ky[2])
major_y = major_y[major_y >= ylim_l & major_y <= ylim_u]
minor_y = as.vector(outer(10^(ky[1]:ky[2]), 2:9))
minor_y = minor_y[minor_y >= ylim_l & minor_y <= ylim_u]
axis(2, at = major_y, labels = parse(text = paste0("10^", log10(major_y))), tcl = 0.4, lwd = 1.4, cex.axis = 1.8)
axis(2, at = minor_y, labels = FALSE, tcl = 0.3, lwd = 1)
points(d_input, MSD_AIUQ, pch = 4, col = "blue", cex = 1.1, lwd = 1.1)
points(d_input, MSD_MFAIUQ, pch = 1, col = "cyan", cex = 1.8, lwd = 1.8)
points(tau_DDMUQ, MSD_DDMUQ, pch = 2, col = "darkgreen", cex = 1.1, lwd = 1.1)
lines(tau_MPT, MSD_MPT, col = "#E76F51", lwd = 3)
polygon(c(d_input, rev(d_input)),
        c(MSD_lower, rev(MSD_upper)),
        col = rgb(0.5, 0.5, 0.5, 0.5), border = NA)
legend("bottomright", legend = legend_text,
       bty = "n", text.font = 1.8, cex = 2.2, inset = c(-0.03, -0.04))
