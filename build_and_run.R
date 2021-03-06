library(tidyverse)

#https://snap.stanford.edu/data/ca-GrQc.html
collabs <- read_tsv('data/ca-GrQc.txt', skip = 4, col_names = c('source', 'target'))

makeNetworkData <- function(size = 500, random_sizes = FALSE){
  vertices <- data_frame(id = unique(collabs$source)) %>%
    mutate(index = 1:n(), color = 'steelblue', name = as.character(index)) %>%
    head(size)

  if(random_sizes){
    vertices$size = runif(nrow(vertices), min = 0, max = 0.3)
  }

  edges <- collabs %>%
    filter((source %in% vertices$id) & (target %in% vertices$id))

  list(
    edges = edges,
    vertices = vertices
  )
}


data <- makeNetworkData(1000)

# collaboration_networks <- makeNetworkData(1000)
#
# collaboration_networks$vertices <- collaboration_networks$vertices %>%
#   select(id, name)
#
# devtools::use_data(collaboration_networks, overwrite = TRUE)
# data_sized_verts <- makeNetworkData(1000, TRUE)
#
# devtools::document()

devtools::install()
network3d::network3d(
  vertices = data$vertices, edges = data$edges,
  max_iterations = 75,
  node_size = 0.05,
  edge_opacity = 0.1,
  force_explorer = TRUE)
# network3d::network3d(data, max_iterations = 75, manybody_strength = 1, force_explorer = FALSE)

# network3d::network3d(data_sized_verts, max_iterations = 75)

# testing camera custom settings
# network3d::network3d(
#   data,
#   camera = list(
#     start_pos = list(x=1.2, y=1.2, z=20)
#   ),
#   max_iterations = 75
# )
